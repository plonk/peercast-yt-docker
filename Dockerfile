FROM ubuntu:latest
WORKDIR /root
RUN apt-get update && \
	apt-get install -y wget python3 ffmpeg librtmp1 && \
	wget https://github.com/plonk/peercast-yt/releases/download/v0.4.2/Peercast_YT-x86_64.AppImage && \
        chmod +x Peercast_YT-x86_64.AppImage && \
	apt-get purge -y wget && \
	apt-get clean && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /root/.config/peercast
ADD peercast.ini /root/.config/peercast
ADD run.sh /root
RUN mkdir -p /root/config

CMD ["/root/run.sh"]
