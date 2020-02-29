FROM ubuntu:latest
WORKDIR /root
RUN apt-get update && \
	apt-get install -y wget python3 ffmpeg librtmp1 && \
	wget https://github.com/plonk/peercast-yt/releases/download/v0.3.1/peercast-yt-linux-x86_64.tar.gz && \
	tar xzf peercast-yt-linux-x86_64.tar.gz && \
	rm peercast-yt-linux-x86_64.tar.gz && \
	apt-get purge -y wget && \
	apt-get clean && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD peercast.ini /root/peercast-yt
ADD run.sh /root
RUN mkdir -p /root/config

CMD ["/root/run.sh"]
