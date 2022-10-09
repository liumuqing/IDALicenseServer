FROM gcc:10.4 as compiler
COPY ./hook_mac_address /opt/hook_mac_address
RUN make -C /opt/hook_mac_address

FROM ubuntu:20.04 as downloader

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl upx-ucl
RUN mkdir -p /opt/lmadmin
RUN curl https://hex-rays.com/products/ida/support/flexlm/lmadmin-x64_lsb-11.19.1.0.tgz | tar -xzC /opt/lmadmin
RUN curl https://www.hex-rays.com/products/ida/support/flexlm/x64_lsb/hexrays --output /opt/lmadmin/hexrays
RUN chmod +x /opt/lmadmin/hexrays
RUN upx /opt/lmadmin/lmadmin /opt/lmadmin/hexrays
RUN find /opt/lmadmin/ -type f -name '*.so*' -exec upx '{}' ';'


FROM ubuntu:20.04

RUN mkdir -p /opt/lmadmin/
RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
COPY --from=downloader /opt/lmadmin/ /opt/lmadmin/
COPY --from=compiler /opt/hook_mac_address /opt/hook_mac_address
RUN echo '/opt/hook_mac_address/hook_mac_address.so' >> /etc/ld.so.preload

RUN mkdir -p /opt/lmadmin/conf/ && mkdir -p /opt/lmadmin/licenses/
VOLUME /opt/lmadmin/conf/
VOLUME /opt/lmadmin/licenses/

# webui
EXPOSE 8090
# lmadmin port
EXPOSE 27000
# we use this port as hex-rays port
EXPOSE 26999

ENTRYPOINT /opt/lmadmin/lmadmin -foreground
