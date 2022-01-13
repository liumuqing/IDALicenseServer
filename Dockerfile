FROM ubuntu:20.04 as downloader

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl upx-ucl

RUN mkdir -p /opt/lmgrd
RUN curl https://www.hex-rays.com/products/ida/support/flexlm/x64_lsb/hexrays --output /opt/lmgrd/hexrays
RUN curl https://hex-rays.com/products/ida/support/flexlm/x64_lsb/lmgrd --output /opt/lmgrd/lmgrd
RUN chmod +x /opt/lmgrd/hexrays && upx /opt/lmgrd/hexrays
RUN chmod +x /opt/lmgrd/lmgrd && upx /opt/lmgrd/lmgrd


FROM ubuntu:20.04

RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
RUN mkdir -p /opt/lmgrd/
COPY --from=downloader /opt/lmgrd/ /opt/lmgrd/
VOLUME /opt/lmgrd/licenses/

RUN mkdir -p /usr/tmp/
# lmadmin port
EXPOSE 27000
# we use this port as hex-rays port
EXPOSE 26999

ENTRYPOINT /opt/lmgrd/lmgrd -z -c ${LICENSE_PATH}
