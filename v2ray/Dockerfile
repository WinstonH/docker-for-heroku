FROM alpine:latest
ENV UUID bae4c69e-3fe3-45d4-aaae-43dc34855efc

RUN set -ex \
&& mkdir -p /usr/bin/v2ray/ \
&& apk --no-cache add ca-certificates nginx curl wget \
&& cd /tmp \
&& VER=$(curl -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | grep tag_name | awk  -F '"' '{print $4}') \
&& wget https://github.com/v2ray/v2ray-core/releases/download/$VER/v2ray-linux-64.zip \
&& unzip v2ray-linux-64.zip \
&& chmod +x v2ray v2ctl \
&& mv v2* /usr/bin/v2ray/ \
&& mv *.dat /usr/bin/v2ray/ \
&& rm -rf v2ray-linux-64.zip /tmp/* \
&& mkdir /var/log/v2ray/  \
&& adduser -D myuser \
&& mkdir /run/nginx

ENV PATH /usr/bin/v2ray:$PATH

COPY default.conf /etc/nginx/conf.d/default.conf
COPY config.json /etc/v2ray/config.json
COPY entrypoint.sh /usr/bin/

USER myuser
CMD entrypoint.sh
