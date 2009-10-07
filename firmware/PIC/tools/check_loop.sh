#!/bin/sh
# Does lots of pokes, hopefully getting a response at some point.
export serialport=/dev/ttyUSB0
echo Using $serialport - edit the script to change this.
stty -F $serialport -echo -cooked
while (true)
do
	echo 6|./poke -d 8 -t $serialport -v &
	sleep 4
	killall poke 2>/dev/null
	sleep 1
	killall poke 2>/dev/null
done
