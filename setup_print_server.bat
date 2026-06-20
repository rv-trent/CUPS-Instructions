@echo off

set /p username="Enter your Pi's username: "
set /p password="Enter your Pi's password: "
set /p ipaddr="Enter your Pi's ip address: "

echo %password%|ssh -tt %username%@%ipaddr% "sudo apt-get update -y;" ^
	"sudo apt-get upgrade -y;" ^
	"sudo apt-get install cups -y;" ^
	"sudo apt-get install printer-driver-gutenprint -y;" ^
	"sudo usermod -aG lpadmin %username%;" ^
	"sudo cupsctl --share-printers --remote-any;" ^
	"sudo systemctl restart cups;" ^
	"sudo cupsctl WebInterface=yes;" ^
	"sudo systemctl restart cups;"

start "" "http://%ipaddr%:631/admin"
echo DO NOT CONTINUE UNTIL YOU HAVE SET UP THE PRINTER AND COPIED THE NAME
pause
set /p printname="Enter/paste the exact name of the printer: "
echo %password%|ssh -tt %username%@%ipaddr% "sudo lpadmin -p %printname% -o printer-is-shared=true;"
pause
