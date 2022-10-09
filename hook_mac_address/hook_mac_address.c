/*
 * ifhwaddr hook - a hook SIOCGIFHWADDR ioctl to give a fake MAC address for apps
 * LD_PRELOAD="hook.so" command
 *
 */

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include <dlfcn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <signal.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <net/if_arp.h>

#ifndef RTLD_NEXT
#define RTLD_NEXT ((void *) -1l)
#endif

int need_hook = 0;
unsigned char mac_address[6];
__attribute__((constructor)) static void my_init() {
    const char * mac_address_str = getenv("HOOK_MAC_ADDRESS");
    if (!mac_address_str) {
        printf("no env HOOK_MAC_ADDRESS");
        return;
    }
    need_hook = 1;
    if(6 == sscanf(mac_address_str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx%*c", &mac_address[0], &mac_address[1], &mac_address[2], &mac_address[3], &mac_address[4], &mac_address[5])) {
        return;
    }
    if(6 == sscanf(mac_address_str, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx%*c", &mac_address[0], &mac_address[1], &mac_address[2], &mac_address[3], &mac_address[4], &mac_address[5])) {
        return;
    }
    printf("cannot parse HOOK_MAC_ADDRESS, it should be AA:BB:CC:DD:EE:FF");
    exit(77);

}

int ioctl (int __fd, unsigned long int __request, ...) {
    static int (*func_ioctl) (int, unsigned long int, void *) = NULL;
    va_list args;
    void *argp;
    int retval;

    if (! func_ioctl) {
        func_ioctl = (int (*) (int, unsigned long int, void *)) dlsym (RTLD_NEXT, "ioctl");
    }
    va_start (args, __request);
    argp = va_arg (args, void *);
    va_end (args);
    struct ifreq *ifr = argp;

    retval = func_ioctl (__fd, __request, argp);

    if (need_hook && SIOCGIFHWADDR == __request && retval == 0) {

        unsigned char* mac=(unsigned char*)ifr->ifr_hwaddr.sa_data;
        memcpy(mac, mac_address, sizeof(mac_address));
    }

    return retval;
}
