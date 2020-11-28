# Dockerlize IDALicenseServer
## Install
1. `echo "MAC_ADDRESS=XX:XX:XX:XX:XX:XX" > .env`
2. `docker-compose up -d`
3. config the server
    1. login to webui (default account: `admin:admin`), reset admin password
    2. import your license
    3. goto Administration -- Vendor Daemon Configuration -- Administer -- Vendor Daemon Port -- Use this port `26999`
    4. run `docker restart ida_license_server`
    5. login to webui again, make sure 'Administration -- Vendor Daemon Configuration -- hexrays -- Administer -- Vendor Daemon Port in Use' is 26999
4. enjoy your license server

## Note
1. `/opt/lmadmin/conf`, `/opt/lmadin/licenses` are configured as volume in Dockerfile, so licenses/configurations are kept after restart/reboot/recreate
2. service `license_server` is located in `internal` network, so all outgoing connection is blocked. Only needed ports are proxied, by `proxy_xxxx` services.
