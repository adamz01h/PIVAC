#!/bin/bash
while true;do
sleep 1
state=$(cat hvac.state)
cycle=$(gpio read 3)
if [ "$cycle" = "1" ] ; then

	if [ "$state" = "off" ] ; then
	clear
	changestate="heat"
	echo $changestate > hvac.state
	echo "HVAC HEAT"

	fi


	if [ "$state" = "heat" ] ; then
	changestate="cool"
	clear
	echo $changestate > hvac.state
	echo "HVAC COOL"

	fi


	if [ "$state" = "cool" ] ; then
	changestate="off"
	clear
	echo $changestate > hvac.state
	echo "HVAC OFF"

	fi
fi
if [ "$cycle" = "0" ] ; then
x=$(( $x + 1 ))
sleep 1
if [ "$x" = "2" ] ; then
exit
fi
fi
done
