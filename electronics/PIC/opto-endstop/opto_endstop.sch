EESchema Schematic File Version 1
LIBS:power,Z:/JAVA programs von eD/electronics/RepRap_kicad_library/reprap,device,conn,linear,regul,74xx,cmos4000,adc-dac,memory,xilinx,special,microcontrollers,dsp,microchip,analog_switches,motorola,texas,intel,audio,interface,digital-audio,philips,display,cypress,siliconi,contrib,valves
EELAYER 43  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title ""
Date "26 mar 2007"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5750 2850
Wire Wire Line
	5750 2850 5500 2850
Wire Wire Line
	5500 2850 5500 2900
Wire Wire Line
	5500 3400 5500 3750
Connection ~ 5750 2950
Wire Wire Line
	6100 2950 5750 2950
Wire Wire Line
	5850 2550 5850 3750
Wire Wire Line
	5750 2550 5750 3750
Wire Wire Line
	5950 2550 5950 3750
Wire Wire Line
	6100 3450 5850 3450
Connection ~ 5850 3450
Wire Wire Line
	5600 3750 5600 3600
Wire Wire Line
	5600 3600 5950 3600
Connection ~ 5950 3600
$Comp
L R R1
U 1 1 4607F10A
P 6100 3200
F 0 "R1" V 6180 3200 50  0000 C C
F 1 "10K" V 6100 3200 50  0000 C C
	1    6100 3200
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 4607F105
P 5500 3150
F 0 "R2" V 5580 3150 50  0000 C C
F 1 "220R" V 5500 3150 50  0000 C C
	1    5500 3150
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 K1
U 1 1 4607F0A5
P 5850 2200
F 0 "K1" V 5800 2200 50  0000 C C
F 1 "CONN_3" V 5900 2200 40  0000 C C
	1    5850 2200
	0    -1   -1   0   
$EndComp
$Comp
L H21LOI U1
U 1 1 4607EFF4
P 5750 4150
F 0 "U1" H 5750 4150 60  0000 C C
F 1 "H21LOI" H 5750 4150 60  0000 C C
	1    5750 4150
	1    0    0    -1  
$EndComp
$EndSCHEMATC
