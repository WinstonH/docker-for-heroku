# This version is for heroku only
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

RUN locale-gen zh_CN.UTF-8


RUN apt-get update \
&& apt-get install -y --no-install-recommends ubuntu-desktop \
&& apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal \
&& apt-get install -y tightvncserver \
&& apt-get clean \
&& mkdir /home/myuser/.vnc

RUN apt-get update \
&& sudo apt-get install -y openssh-server nginx supervisor vim git wget curl autocutsel firefox firefox-locale-zh-hans ttf-wqy-microhei libnet1-dev libpcap0.8-dev \
&& apt-get install -y language-pack-zh-hans-base language-pack-zh-hans language-pack-gnome-zh-hans language-pack-gnome-zh-hans-base \
&& apt-get clean

RUN apt-get update \
&& apt-get install -y build-essential cmake \
&& apt install libmicrohttpd-dev libssl-dev libhwloc-dev -y \
&& cd /home/myuser \
&& git clone https://github.com/fireice-uk/xmr-stak.git \
&& mkdir xmr-stak/build \
&& cd xmr-stak/build \
&& cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF .. \
&& make install
COPY supervisord.conf /etc/supervisord.conf

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
