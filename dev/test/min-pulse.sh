#!/bin/bash 

# configuration
user=webiopi        # login username 
pass=raspberry      # login password
ipadr=127.0.0.1     # webiopi server ip address
port=8000           # webiopi server port number
pin=4               # GPIO port number
freq=0.01           # frequency [100s]
wait=300            # sec

if [ "$1" != "" ] ; then
    freq=$1
fi
echo "Frequency is $freq [Hz]"
if [ "$2" != "" ] ; then
    wait=$2
fi

# function
curl -X POST -u $user:$pass http://$ipadr:$port/GPIO/$pin/function/pwm && echo
curl -u $user:$pass http://$ipadr:$port/GPIO/$pin/function && echo 
# pulse freq
curl -X POST -u $user:$pass http://$ipadr:$port/GPIO/$pin/pulseFreq/$freq && echo
curl -u $user:$pass http://$ipadr:$port/GPIO/$pin/freq && echo
# pulse ratio
curl -X POST -u $user:$pass http://$ipadr:$port/GPIO/$pin/pulseRatio/0.5 && echo
curl -u $user:$pass http://$ipadr:$port/GPIO/$pin/pulse && echo
# wait for 300sec
sleep $wait
# disable pwm.
curl -X POST -u $user:$pass http://$ipadr:$port/GPIO/$pin/function/in && echo
