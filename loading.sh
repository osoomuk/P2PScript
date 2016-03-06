#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "Start script as a root"
	exit 1 
fi 
if [ -z "$1" ]; then
	echo 'Please insert torrnet file name'
	exit 1
fi
GTK=`/usr/bin/apt-cache policy transmission-gtk | grep Installed | awk '{print $2}'`
if [ $GTK == '(none)' ]; then
	echo 'transmission has not installed'
	apt-get install transmission-gtk	
	exit 1
fi
echo 'transmission installed'
transmission-gtk $1
