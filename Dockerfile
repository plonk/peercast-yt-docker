FROM ubuntu:latest as build-stage
RUN apt-get update
RUN apt-get install -y librtmp-dev
RUN apt-get install -y make g++
RUN apt-get install -y ruby
RUN apt-get install -y wget

WORKDIR /root

RUN wget https://github.com/plonk/peercast-yt/archive/v0.3.0.tar.gz
RUN tar xzf v0.3.0.tar.gz

WORKDIR /root/peercast-yt-0.3.0/ui/linux
RUN make -j4

# -----------------------------------------------------
FROM ubuntu:latest as deploy-stage
RUN apt-get update
COPY --from=build-stage /root/peercast-yt-0.3.0/ui/linux/peercast-yt /root/peercast-yt
RUN apt-get install -y python3 ffmpeg librtmp1

WORKDIR /root

RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD peercast.ini /root/peercast-yt
ADD run.sh /root
RUN mkdir -p /root/config

CMD ["/root/run.sh"]
