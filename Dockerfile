FROM ubuntu:20.04

#RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y lsb-core curl

RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl

RUN mkdir -p /opt/lmadmin

#ADD lmadmin-x64_lsb-11.17.0.0.tgz /opt/lmadmin
RUN curl https://hex-rays.com/products/ida/support/flexlm/lmadmin-x64_lsb-11.18.3.1.tgz | tar -xzC /opt/lmadmin

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
