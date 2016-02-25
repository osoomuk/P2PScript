#/bin/bash 

if [ $UID -ne 0 ]; then
	echo "Start this script $(basename $0) as a root"
	exit 1
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

