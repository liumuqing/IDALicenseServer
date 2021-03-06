FROM ubuntu:20.04

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y lsb-core

RUN mkdir -p /opt/lmadmin

#ADD lmadmin-x64_lsb-11.17.0.0.tgz /opt/lmadmin
RUN curl https://www.hex-rays.com/products/ida/support/flexlm/lmadmin-x64_lsb-11.17.0.0.tgz | tar -xC /opt/lmadmin

#COPY hexrays /opt/lmadmin/
RUN curl https://www.hex-rays.com/products/ida/support/flexlm/x64_lsb/hexrays --output /opt/lmadmin/hexrays
RUN chmod +x /opt/lmadmin/hexrays

VOLUME /opt/lmadmin/conf/
VOLUME /opt/lmadmin/licenses/

# webui
EXPOSE 8090

# lmadmin port
EXPOSE 27000

# we use this port as hex-rays port
EXPOSE 26999

ENTRYPOINT /opt/lmadmin/lmadmin -foreground
