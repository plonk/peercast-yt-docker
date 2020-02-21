#!/bin/bash

if [ -f "/root/config/peercast.ini" ]
then
	echo "Running with user configuration: /root/config/peercast.ini"
	cp /root/config/peercast.ini /root/peercast-yt/peercast.ini
else
	echo "Running with default configuration"
fi

peercast-yt/peercast

if [ -f "/root/config/peercast.ini" ]
then
	echo "Saving configuration: /root/config/peercast.ini"
fi
cp /root/peercast-yt/peercast.ini /root/config/peercast.ini
