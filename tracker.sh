#Bash script for installing tools and making torrent files
#Copyright (C) 2016 Oliver Soom

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#bin/bash


#!/bin/bash 

echo $1
echo $2
echo $3
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
if [ -z "$3" ]; then
	echo "Please insert tracker address"
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
transmission-create -o $2 -t $3 $1
#transmission-create -o $2 -t http://172.16.222.245:80/ui.php $1
echo "torrent file made"
RTOR=`/usr/bin/apt-cache policy rtorrent | grep Installed | awk '{print $2}'`
ls -a
if [ "$RTOR" == "(none)" ]; then
	apt-get install rtorrent -y
	echo "Rtorrent installed"
fi
chmod 777 $2  
rtorrent $2
