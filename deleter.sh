#bin/bash

if [ $UID -ne 0 ]; then
	echo "ROOOOT!"
	exit 1
fi
apt-get remove --purge apache2 php5 libapache2-mod-php5 php5-mcrypt -y
exit 1
