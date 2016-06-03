# PIVAC
Raspberry Pi powered smart thermostat.
Some software is required to run.
Apache, PHP, MySQL, WiringPi, Your LCD Driver software.
First wire up your Pi like the schematics.
Then move over to the software.
1. sudo apt-get update && sudo apt-get upgrade
2. sudo apt-get install git-core apache2 mysql-server php5
3. cd ~/
4. git clone git://git.drogon.net/wiringPi && cd wiringPi
5. git pull origin && ./build
6. Copy everything in this repo to apache serve-able location
7. Run scripts/main.sh
8. fan.state , hvac.state, target.temp must be writable  by both the user running main.sh and www-data
9. Apache protect scripts directory.

Enjoy!

-Needs added in the future.
-Login.
-Scheduler.  

