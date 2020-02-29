FROM ubuntu:latest as build-stage
RUN apt-get update
RUN apt-get install -y librtmp-dev
RUN apt-get install -y make g++
RUN apt-get install -y ruby
RUN apt-get install -y wget

WORKDIR /root

RUN wget https://github.com/plonk/peercast-yt/archive/v0.3.1.tar.gz
RUN tar xzf v0.3.1.tar.gz

WORKDIR /root/peercast-yt-0.3.1/ui/linux
RUN make -j4

# -----------------------------------------------------
FROM ubuntu:latest as deploy-stage
COPY --from=build-stage /root/peercast-yt-0.3.1/ui/linux/peercast-yt /root/peercast-yt
RUN apt-get update && apt-get install -y python3 ffmpeg librtmp1 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD peercast.ini /root/peercast-yt
ADD run.sh /root
RUN mkdir -p /root/config

WORKDIR /root

CMD ["/root/run.sh"]
