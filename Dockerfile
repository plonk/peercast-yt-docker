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
RUN	apt-get update && \
	apt-get install -y python3 ffmpeg librtmp1 && \
	apt-get clean && \ 
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
	mkdir /root/config && \
	ln -s /root/config/peercast.ini /root/peercast-yt/peercast.ini

ADD peercast.ini /root/peercast-yt/peercast.ini.default
ADD run.sh /root

VOLUME ["/root/config"]
EXPOSE 7144
WORKDIR /root
CMD ["/root/run.sh"]
