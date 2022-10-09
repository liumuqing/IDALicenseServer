# Dockerlize IDALicenseServer
## Install
1. `echo "MAC_ADDRESS=XX:XX:XX:XX:XX:XX" > .env`
2. open your license file, change the second line from `VENDOR hexrays` to `VENDOR hexrays PORT=26999`
3. put your `.lic` file to ./licenses/ida.lic
4. `docker-compose up -d`
5. set `License server Hostname` to `127.0.0.1` and `Port` to `27000`, when IDA asks. (make sure you uncheck the `Default ports` checkbox)
6. enjoy your license server

## Note
1. checkout [lmadmin](https://github.com/liumuqing/IDALicenseServer/tree/lmadmin/) if you prefer webui.
