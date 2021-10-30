#!/bin/bash

if [ -f "/root/config/peercast.ini" ]
then
	echo "Running with user configuration: /root/config/peercast.ini"
	cp /root/config/peercast.ini /root/.config/peercast/peercast.ini
else
	echo "Running with default configuration"
fi

./Peercast_YT-x86_64.AppImage --appimage-extract-and-run

if [ -f "/root/config/peercast.ini" ]
then
	echo "Saving configuration: /root/config/peercast.ini"
fi
cp /root/.config/peercast/peercast.ini /root/config/peercast.ini
