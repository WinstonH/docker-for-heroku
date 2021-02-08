# This version is for heroku only
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

RUN echo "$TZ" > /etc/timezone \
&& apt-get update \
&& apt-get install locales \
&& locale-gen zh_CN.UTF-8 \
&& apt-get install -y --no-install-recommends ubuntu-desktop \
gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal \
tightvncserver \
openssh-server supervisor vim git curl wget sudo build-essential firefox firefox-locale-zh-hans ttf-wqy-microhei libnet1-dev libpcap0.8-dev \
language-pack-zh-hans-base language-pack-zh-hans language-pack-gnome-zh-hans language-pack-gnome-zh-hans-base \
sudo nginx \
&& mkdir /root/.vnc \
&& mkdir -p /var/run/sshd \
&& echo 'root:root' |chpasswd \
&& sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& apt-get clean \
&& mkdir -p /home/myuser/.vnc
# Cloud-torrent
RUN curl https://i.jpillora.com/cloud-torrent! | bash
# V2Ray
ENV PATH /usr/bin/v2ray:$PATH
RUN curl -sL https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh | bash
COPY config.json /etc/v2ray/config.json

COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/
COPY vnc.sh /home/myuser/.vnc/vnc.sh
RUN git clone https://github.com/snooda/net-speeder.git net-speeder \
&& git clone https://github.com/novnc/noVNC.git
WORKDIR net-speeder

RUN sh build.sh \
&& mv net_speeder /usr/local/bin/

ADD xstartup /home/myuser/.vnc/xstartup
ADD passwd /home/myuser/.vnc/passwd

ADD entrypoint.sh /usr/sbin
RUN chmod 600 /home/myuser/.vnc/passwd \
&& chmod +x /usr/local/bin/net_speeder \
&& ln -s /noVNC/vnc.html /noVNC/index.html
	
RUN useradd -m myuser \
&& echo 'myuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER myuser
WORKDIR /home/myuser
ENV USER myuser

CMD entrypoint.sh
