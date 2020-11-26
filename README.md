# Dockerlize IDALicenseServer
1. `docker run -it -d --name ida_license_server --mac-address XX:XX:XX:XX:XX:XX -p 8090:8090 -p 27000:27000 -p 26999:26999 liumuqing/ida_license_server`
2. config the server
    1. login to webui, reset admin password
    2. import your license
    3. goto Administration -- Vendor Daemon Configuration -- Administer -- Vendor Daemon Port -- Use this port `26999`
    4. run `docker restart ida_license_server`
    5. login to webui again, make sure 'Administration -- Vendor Daemon Configuration -- hexrays -- Administer -- Vendor Daemon Port in Use' is 26999
3. enjoy your license server
