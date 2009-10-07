#!/bin/sh
echo "Makes the X Stepper dance back & forth ad infinitum"
export pokeDev=/dev/ttyUSB0
# Add your "poke" command here.
export poke="./poke -d 2 -t $pokeDev -v "
# Ensure port is raw data friendly.
stty -F $pokeDev -echo -cooked
echo 3 0 0 | $poke
while true; do
	echo 5 200 30 1 | $poke
	sleep 2
	echo 5 200 0 0 | $poke
	sleep 2
done
