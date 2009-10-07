#!/bin/sh
echo "Makes the X and Y Steppers do a square ad infinitum"
export pokeDev=/dev/ttyUSB0
# Add your "poke" command here.
export poke="./poke -t $pokeDev -v -d "
export xaxis=2
export yaxis=3
export slp=4.8
export spd=220
# Ensure port is raw data friendly.
stty -F $pokeDev -echo -cooked
echo 3 0 0 | $poke $xaxis
echo 3 0 0 | $poke $yaxis

while true; do
	echo 5 $spd 0 2 | $poke $xaxis
	sleep $slp
	echo 5 $spd 0 2 | $poke $yaxis
	sleep $slp
	echo 5 $spd 0 0 | $poke $xaxis
	sleep $slp
	echo 5 $spd 0 0 | $poke $yaxis
	sleep $slp
done
