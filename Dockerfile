FROM ubuntu:20.04

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y lsb-core

RUN mkdir -p /opt/lmgrd

#COPY hexrays /opt/lmgrd/
RUN curl https://www.hex-rays.com/products/ida/support/flexlm/x64_lsb/hexrays --output /opt/lmgrd/hexrays
RUN chmod +x /opt/lmgrd/hexrays

#COPY lmgrd /opt/lmgrd/
RUN curl https://hex-rays.com/products/ida/support/flexlm/x64_lsb/lmgrd --output /opt/lmgrd/lmgrd
RUN chmod +x /opt/lmgrd/lmgrd

VOLUME /opt/lmgrd/licenses/

RUN mkdir -p /usr/tmp/

# webui
EXPOSE 8090

# lmadmin port
EXPOSE 27000

# we use this port as hex-rays port
EXPOSE 26999

ENTRYPOINT /opt/lmgrd/lmgrd -z -c ${LICENSE_PATH}
