FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

WORKDIR /root

RUN wget https://github.com/plonk/peercast-yt/releases/download/v0.1.0/peercast-yt-linux-amd64.tar.gz
RUN tar xzf peercast-yt-linux-amd64.tar.gz
RUN rm peercast-yt-linux-amd64.tar.gz
ADD peercast.ini /root/peercast-yt
ADD run.sh /root
RUN mkdir -p /root/config

CMD ["/root/run.sh"]
