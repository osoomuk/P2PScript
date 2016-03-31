#Bash script for downloading file via torrent
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
