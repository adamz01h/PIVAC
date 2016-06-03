#!/bin/bash
gpio mode 4 out
gpio mode 1 out
gpio mode 0 in
gpio mode 3 in
gpio mode 2 in
gpio mode 8 in
gpio mode 5 out

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
cpuf=$(($cpuTemp1 * 9 / 5 + 32))

temps=$(cat /sys/bus/w1/devices/28-*/w1_slave | grep = | awk '{print $10}' | awk '{$0=substr($0,3,length($0)-5); print $0}')
room=$(($temps * 9 / 5 + 32))
delay=0 # Set delay
while true;do

buffer=$(
clear
target=$(cat target.temp)
state=$(cat hvac.state)
fanstate=$(cat fan.state)
echo " CPU="$cpuTemp1"."$cpuTempM"'C\n"
echo "Current: "$room"'F\n"
echo "Set: "$target"'F\n"
echo "HVAC: "$state"\n"
echo "FAN: "$fanstate"\n"
ifconfig | grep inet | awk 'NR==1{print $2}'

)
echo -e $buffer
x=$(( $x + 1 ))
if [ "$x" = "15" ] ; then
temps=$(cat /sys/bus/w1/devices/28-*/w1_slave | grep = | awk '{print $10}' | awk '{$0=substr($0,3,length($0)-5); print $0}')
room=$(($temps * 9 / 5 + 32))

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
cpuf=$(($cpuTemp1 * 9 / 5 + 32))

x=0
fi

target=$(cat target.temp)
state=$(cat hvac.state)
cycle=$(gpio read 3)
greenboard=$(gpio read 0)
redboard=$(gpio read 2)
fan=$(gpio read 8)
fanstate=$(cat fan.state)

#-----
#cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
#cpuTemp1=$(($cpuTemp0/1000))
#cpuTemp2=$(($cpuTemp0/100))
#cpuTempM=$(($cpuTemp2 % $cpuTemp1))
#cpuf=$(($cpuTemp1 * 9 / 5 + 32))
#gpus=$(/opt/vc/bin/vcgencmd measure_temp | grep = |  awk -v FS="=" '{ print $NF }'| awk '{$0=substr($0,1,length($0)-4); print $0}')
#gpuf=$(($gpus * 9 / 5 + 32))
#echo $cpuf"'F"
#echo $gpuf"'F"
#echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
#echo GPU $(/opt/vc/bin/vcgencmd measure_temp)
#echo $room"'F"
#ifconfig | grep inet | awk 'NR==1{print $2}'
#------


if [ "$state" = "cool" ] ; then
sleep "$delay"
gpio write 1 0

	if [ $target -gt "$room" ] ; then
	sleep "$delay"
	gpio write 4 0
                if [ "$fanstate" = "auto" ] ; then
                        gpio write 5 0
                fi

	else
	sleep "$delay"
	gpio write 4 1
                if [ "$fanstate" = "auto" ] ; then
                        gpio write 5 1
                fi
	fi
fi

if [ "$state" = "heat" ] ; then
sleep "$delay"
gpio write 4 0
	if [ "$room" -gt $target ] ; then
	sleep "$delay"
	gpio write 1 0
	        if [ "$fanstate" = "auto" ] ; then
                        gpio write 5 0
                fi

	else
	sleep "$delay"
	gpio write 1 1
		if [ "$fanstate" = "auto" ] ; then
			gpio write 5 1
		fi
	fi
fi

if [ "$state" = "off" ] ; then	
gpio write 1 0
gpio write 4 0
if [ "$fanstate" = "auto" ] ; then
gpio write 5 0
fi

fi


if [ "$fanstate" = "off" ] ; then
gpio write 5 0
fi

if [ "$fanstate" = "on" ] ; then
gpio write 5 1
fi

if [ "$greenboard" = "1" ] ; then
x=0
./settemp.sh

fi
if [ "$redboard" = "1" ] ; then
x=0
./settemp.sh
fi

if [ "$cycle" = "1" ] ; then
x=0
./hvac.sh
fi

if [ "$fan" = "0" ] ; then
x=0
./fan.sh
fi

done
