#!/bin/bash 

echo $1
echo $2
if [ $UID -ne 0 ]; then
	echo "Start this script $(basename $0) as a root"
	exit 1
fi
#uurime faili nimed olemasolu
if [ -z "$1" ]; then
	echo "Please insert seed file name as a argument"
	exit 0
fi
if [ -z "$2" ]; then
	echo "Please insert torrent file name as a argument"
	exit 0
fi
#Kontrollime kas apache2 on
APACHE=`/usr/bin/apt-cache policy apache2 | grep Installed | awk '{print $2}'`
if [ "$APACHE" == "(none)" ]; then
	echo 'Not installed'	
	echo 'Getting updates....'
	apt-get update -s 
	echo 'Installing apache'
	apt-get install  apache2 -y 
	echo 'Installing was a success'
fi 
PHP=`/usr/bin/apt-cache policy php5 | grep Installed | awk '{print $2}'`
if [ "$PHP" == "(none)" ]; then
	echo 'Installing php'
	apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
fi 
echo 'File moving and service restart'
cp ui.php /var/www/html/
touch /dev/shm/Bittorrent.Peers
chmod 777 /dev/shm/Bittorrent.Peers
service apache2 restart
echo 'done'
TOR=`/usr/bin/apt-cache policy transmission-cli | grep Installed | awk '{print $2}'`
if [ "$TOR" == "(none)" ]; then
	apt-get install transmission-cli transmission-daemon -y
	echo "Transmission installed"
fi
transmission-create -o $2 -t http://192.168.0.101:80/ui.php $1
echo "torrent file made"
RTOR=`/usr/bin/apt-cache policy rtorrent | grep Installed | awk '{print $2}'`
ls -a
if [ "$RTOR" == "(none)" ]; then
	apt-get install rtorrent -y
	echo "Rtorrent installed"
fi
chmod 777 $2  
rtorrent $2
