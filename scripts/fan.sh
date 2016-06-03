#!/bin/bash

while true;do
sleep 1
#target=$(cat target.temp)
#state=$(cat state.temp)
fan=$(gpio read 8)
fanstate=$(cat fan.state)
if [ "$fan" = "0" ] ; then

        if [ "$fanstate" = "on" ] ; then
#       if [ "$fanstate" = "off" ] ; then
	clear
	changefanstate="auto"
        echo $changefanstate > fan.state
        echo "FAN AUTO"


        elif [ "$fanstate" = "auto" ] ; then
	clear
	changefanstate="on"
        echo $changefanstate > fan.state
        echo "FAN ON"


#        elif [ "$fanstate" = "on" ] ; then
#	clear
#	changefanstate="off"
#       echo $changefanstate > fan.state
#       echo "FAN OFF"
	fi
fi
if [ "$fan" = "1" ] ; then

x=$(( $x + 1 ))
sleep 1

if [ "$x" = "3" ] ; then
exit
fi

fi
done
