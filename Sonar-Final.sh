#!/bin/bash
#####################
##Setting Variables##
#####################
flag=$1
host=$2
#######################
##Setting API Servers##
#######################
list="https://helloacm.com/api/ping/?host=
https://codingforspeed.com/api/ping/?host=
https://codingnbb.com/api/ping/?host=
https://rot47.net/api/ping/?host=
https://api.justyy.workers.dev/api/ping/?host=
https://propagationtools.com/api/ping/?host=
https://anothervps.com/api/ping/?host=
https://uploadbeta.com/api/ping/?host=
https://slowapi.com/api/ping/?hpst=
https://steemyy.com/api/ping/?host="
############################
##Setting Option Functions##
############################
f_logo(){
clear
echo "                                                                      "
echo "                        ██████  ▒█████   ███▄    █  ▄▄▄       ██▀███  "
echo "                      ▒██    ▒ ▒██▒  ██▒ ██ ▀█   █ ▒████▄    ▓██ ▒ ██▒"
echo "                      ░ ▓██▄   ▒██░  ██▒▓██  ▀█ ██▒▒██  ▀█▄  ▓██ ░▄█ ▒"
echo "                        ▒   ██▒▒██   ██░▓██▒  ▐▌██▒░██▄▄▄▄██ ▒██▀▀█▄  "
echo "                      ▒██████▒▒░ ████▓▒░▒██░   ▓██░ ▓█   ▓██▒░██▓ ▒██▒"
echo "                      ▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░"
echo "                      ░ ░▒  ░ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░  ▒   ▒▒ ░  ░▒ ░ ▒░"
echo "                      ░  ░  ░  ░ ░ ░ ▒     ░   ░ ░   ░   ▒     ░░   ░ "
echo "                            ░      ░ ░           ░       ░  ░   ░     "
echo "                                   Sonar Pinger By Ishikawa           "
echo "                                                                      "
}
f_pinger(){
while true
	do
		output=`ping -4 -c 1 $host | awk '{print $1,$2,$5,$6,$7,$8}' | sed 's/rtt.*//' | sed 's/-.*//' | sed 's/,.*//'`
	        ping=`ping -c 1 $host | grep bytes | wc -l`
	        if [ "$ping" -gt 1 ]; then
			echo $output
	        else
			echo " "
			for prox in $list
			do
				echo "Host appears down, verifying with third party site: "
				echo " "
				verify=`curl -s $prox$host | grep 100% | wc -l`
				results=`curl -s $prox$host`
					if [ "$verify" -gt 0 ];then
						echo " "
						echo "Verification Complete, $host is down"
						echo " "
						echo $results
					else
						echo "Verification Complete, $host is up"
						echo " "
						echo $results
					fi
        		done
	        fi
	done
}
########
##Logo##
########
f_logo
f_logo
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
*)
	cat <<EOF
Usage:
$0 -pinger [URL/IP]
EOF
	exit 0
;;
esac
