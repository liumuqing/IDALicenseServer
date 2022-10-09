# Dockerlize IDALicenseServer
## Install
1. `echo "MAC_ADDRESS=XX:XX:XX:XX:XX:XX" > .env`
2. `docker-compose up -d`
3. config the server
    1. login to webui (default account: `admin:admin`), reset admin password
    2. import your license
    3. goto Administration -- Vendor Daemon Configuration -- Administer -- Vendor Daemon Port -- Use this port `26999`
    4. run `docker-compose restart`
    5. login to webui again, make sure 'Administration -- Vendor Daemon Configuration -- hexrays -- Administer -- Vendor Daemon Port in Use' is 26999
4. set `License server Hostname` to `127.0.0.1` and `Port` to `27000`, when IDA asks. (make sure you uncheck the `Default ports` checkbox)
5. enjoy your license server

## Note
1. checkout [lmgrd](https://github.com/liumuqing/IDALicenseServer/tree/lmgrd/) if you prefer console only version.
