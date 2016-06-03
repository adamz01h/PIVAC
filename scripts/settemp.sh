#!/bin/bash

while true;do
sleep 0.5
target=$(cat target.temp)
greenboard=$(gpio read 0)
redboard=$(gpio read 2)
if [ "$greenboard" = "1" ] ; then

newtemp=$(($target+1))
clear

#Hardcoded Max temp in Fahrenheit 
if [ $newtemp -le "85" ] ; then
echo $newtemp > target.temp
echo $newtemp
else
	
	echo $target
fi

fi

if [ "$redboard" = "1" ] ; then

newtemp=$(($target-1))
clear

#Hardcoded Min temp in Fahrenheit  
if [ $newtemp -ge "65" ] ; then
echo $newtemp > target.temp
echo $newtemp
else
	
	echo $target
fi
fi

if [ "$redboard" = "$greenboard" ] ; then

x=$(( $x + 1 ))
sleep 1
if [ "$x" = "2" ] ; then
exit
fi

fi

done
