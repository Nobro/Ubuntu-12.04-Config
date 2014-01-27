#Redshift script Bucharest, Romania coordinates

vim redshift.sh

~~~

#! /bin/sh
SERVICE=redshift

if a=$(pgrep $SERVICE)
then
echo “$SERVICE is running, PID is $a”
else
echo “$SERVICE is not running, starting it”
/usr/bin/redshift -l 44.25:26.06 -t 5700:3600 -g 0.8 -m vidmode &
fi

~~~
