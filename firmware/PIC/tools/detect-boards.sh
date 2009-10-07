#!/bin/bash
# detect-boards.sh -- pokes each SNAP address used by  default firmware

if [ x"$1" = "-h" ]
then
    echo -e "%0: Usage is\n\n\t%0 [serial-device]\n\nExample: %0 /dev/ttyS1\n"
    exit 1
fi

# Where is poke?
POKE=`dirname $0`/poke
if [ ! -x "$POKE" ]
then
    echo "$0: ERROR: No poke at $POKE" ; exit 2
fi

# Addresses: 2 is X axis, 3 is Y axis, 4 is Z axis, 8 is extruder, 9 is support extruder
declare -a address
address[2]="X-axis Stepper motor controller"
address[3]="Y-axis Stepper motor controller"
address[4]="Z-axis Stepper motor controller"
address[8]="Main extruder controller"
address[9]="Support extruder controller"

allok=1
warning=0

for i in 2 3 4 8 # 9 # Note that 9 is not common yet
do
  # Can we poke it with command 0 and get an ACK back?
#  if echo 0 | $POKE -d $i -t ${1:-/dev/ttyS0} -v 2>/dev/null |grep -sq "ACK Received" 
  POKEOUTPUT=`echo 0 | $POKE -t ${1:-/dev/ttyS0} -v -d $i 2>&1 `
  if echo "$POKEOUTPUT" |grep -sq "ACK Received"
  then
      echo "${address[$i]} at address $i detected"
  elif echo "$POKEOUTPUT" |grep -sq "Got NAK"
  then
      echo "WARNING: ${address[$i]} at address $i detected but NAKing"
      warning=1
  elif echo "$POKEOUTPUT" |grep -sq "CRC"
  then
      echo "WARNING: ${address[$i]} at address $i detected but bad CRC"
      warning=1
  else
      echo "ERROR: ${address[$i]} at address $i NOT FOUND"
      allok=0
  fi
  sleep 0.1	# Small delay, probably unnecessary
done

# Output a summary if useful, then exit appropriately
echo ""
if [ $allok == 1 ]
then
    if [ $warning == 1 ]
    then
	echo "All boards detected, but a problem exists"
	exit 2
    else
	echo "All boards detected, looks good"
	exit 0
    fi
else
    exit 1
fi
