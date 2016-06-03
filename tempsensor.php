<?php
//info for temp

echo shell_exec('cat /sys/bus/w1/devices/28-*/w1_slave | grep t= | awk \'{print $10}\' | awk \'{$0=substr($0,3,length($0)-5); print $0}\'');


?>