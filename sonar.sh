#!/bin/sh
clear
echo  " "
echo "           ██████  ▒█████   ███▄    █  ▄▄▄       ██▀███  "
echo "         ▒██    ▒ ▒██▒  ██▒ ██ ▀█   █ ▒████▄    ▓██ ▒ ██▒"
echo "         ░ ▓██▄   ▒██░  ██▒▓██  ▀█ ██▒▒██  ▀█▄  ▓██ ░▄█ ▒"
echo "           ▒   ██▒▒██   ██░▓██▒  ▐▌██▒░██▄▄▄▄██ ▒██▀▀█▄  "
echo "         ▒██████▒▒░ ████▓▒░▒██░   ▓██░ ▓█   ▓██▒░██▓ ▒██▒"
echo "         ▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░"
echo "         ░ ░▒  ░ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░  ▒   ▒▒ ░  ░▒ ░ ▒░"
echo "         ░  ░  ░  ░ ░ ░ ▒     ░   ░ ░   ░   ▒     ░░   ░ "
echo "               ░      ░ ░           ░       ░  ░   ░     "
echo "                                                         "
echo "                  Sonar Pinger v0.02 By Ishikawa         "
echo "                                                         "
echo "                                                         "
flag=$1
host=$2
############################
##Setting Option Functions##
############################
f_pinger(){
while true
	do
		sleep 1
		output=`ping -4 -c 1 $host | awk '{print $1,$2,$5,$6,$7,$8}' | sed 's/rtt.*//' | sed 's/-.*//' | sed 's/,.*//'`
	        ping=`ping -c 1 $host | grep bytes | wc -l`
	        if [ "$ping" -gt 1 ]; then
	                echo $output
	        else
	                echo "Host is showing to be down, confirming with third party"
	                curl -s https://api.hackertarget.com/nping/?q=$host| grep type=0
			echo " "
	        fi
	done
}
f_verify(){
	while true
	do
		verify=`curl -s https://api.hackertarget.com/nping/?q=$host | grep type=0 | wc -l`
		if [ "$verify" -gt 0 ];then
			curl -s https://api.hackertarget.com/nping/?q=$host | grep type=0
		else
			echo "Target Verified As Down"
		fi
	done
}
f_geolocate(){
	curl https://api.hackertarget.com/geoip/?q=$host
}

########################
##Setting Option Flags##
########################
case $flag in
-pinger)
	for count in {1..100000..1};
	do
	        f_pinger
	done
;;
-verify)
        f_verify
;;
-geolocate)
	f_geolocate
;;
*)
	cat <<EOF
Usage:
$0 -pinger [URL/IP] = will run a pinger check on the target
$0 -verify [URL/IP] = will use a outside API to verify target is down
$0 -geoloate [URL/IP] = will perform a Geolocation on the target

Examples:
$0 -pinger 192.168.1.1
$0 -verify 192.168.1.1
$0 -geolocate 192.168.1.1

EOF
	exit 0
;;
esac

