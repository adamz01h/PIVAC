# PIVAC<br />
Raspberry Pi powered smart thermostat.<br />
Some software is required to run.<br />
Apache, PHP, MySQL, WiringPi, Your LCD Driver software.<br />
First wire up your Pi like the schematics.<br />
Then move over to the software.<br />
1. sudo apt-get update && sudo apt-get upgrade<br />
2. sudo apt-get install git-core apache2 mysql-server php5<br />
3. cd ~/<br />
4. git clone git://git.drogon.net/wiringPi && cd wiringPi<br />
5. git pull origin && ./build<br />
6. Copy everything in this repo to apache serve-able location<br />
7. Run scripts/main.sh<br />
8. fan.state , hvac.state, target.temp must be writable  by both the user running main.sh and www-data<br />
9. Apache protect scripts directory.<br />

Enjoy!<br />

-Needs added in the future.<br />
-Login.<br />
-Scheduler. <br /> 

