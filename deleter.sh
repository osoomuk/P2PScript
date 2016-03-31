#Bash script for removing made installations
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

if [ $UID -ne 0 ]; then
	echo "ROOOOT!"
	exit 1
fi
apt-get remove --purge apache2 php5 libapache2-mod-php5 php5-mcrypt -y
exit 1
