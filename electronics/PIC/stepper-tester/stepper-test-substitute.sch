EESchema Schematic File Version 1
LIBS:power,/home/ensab/workspace/electronics/RepRap_kicad_library/reprap,device,conn,linear,regul,74xx,cmos4000,adc-dac,memory,xilinx,special,microcontrollers,dsp,microchip,analog_switches,motorola,texas,intel,audio,interface,digital-audio,philips,display,cypress,siliconi,contrib,valves
EELAYER 43  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title ""
Date "24 may 2007"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 4750 4650
Wire Wire Line
	4750 4650 5500 4650
Connection ~ 4100 4500
Wire Wire Line
	4100 4350 4100 4800
Connection ~ 4100 3750
Wire Wire Line
	4100 3550 4100 4050
Connection ~ 4750 3900
Wire Wire Line
	4950 3900 4750 3900
Wire Wire Line
	5500 4650 5500 4450
Wire Wire Line
	5500 4450 5650 4450
Wire Wire Line
	5650 4350 5450 4350
Wire Wire Line
	5450 3900 5450 4250
Wire Wire Line
	5450 4250 5650 4250
Wire Wire Line
	5650 4150 5650 3550
Wire Wire Line
	5650 3550 4100 3550
Wire Wire Line
	4100 4350 4950 4350
Wire Wire Line
	4600 3750 4750 3750
Wire Wire Line
	4750 3750 4750 4050
Wire Wire Line
	4750 4050 4600 4050
Wire Wire Line
	4100 3750 4200 3750
Wire Wire Line
	4100 4050 4200 4050
Wire Wire Line
	4100 4500 4200 4500
Wire Wire Line
	4100 4800 4200 4800
Wire Wire Line
	4600 4500 4750 4500
Wire Wire Line
	4750 4500 4750 4800
Wire Wire Line
	4750 4800 4600 4800
$Comp
L LED D2
U 1 1 4655789B
P 4400 4800
F 0 "D2" H 4400 4900 50  0000 C C
F 1 "Green LED" H 4400 4700 50  0000 C C
	1    4400 4800
	-1   0    0    1   
$EndComp
$Comp
L LED D4
U 1 1 46557896
P 4400 4500
F 0 "D4" H 4400 4600 50  0000 C C
F 1 "Red LED" H 4400 4400 50  0000 C C
	1    4400 4500
	1    0    0    -1  
$EndComp
$Comp
L LED D1
U 1 1 46557889
P 4400 4050
F 0 "D1" H 4400 4150 50  0000 C C
F 1 "Green LED" H 4400 3950 50  0000 C C
	1    4400 4050
	-1   0    0    1   
$EndComp
$Comp
L LED D3
U 1 1 46557877
P 4400 3750
F 0 "D3" H 4400 3850 50  0000 C C
F 1 "Red LED" H 4400 3650 50  0000 C C
	1    4400 3750
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 46557848
P 5200 4350
F 0 "R2" V 5280 4350 50  0000 C C
F 1 "560 R" V 5200 4350 50  0000 C C
	1    5200 4350
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 4655783E
P 5200 3900
F 0 "R1" V 5280 3900 50  0000 C C
F 1 "560 R" V 5200 3900 50  0000 C C
	1    5200 3900
	0    1    1    0   
$EndComp
$Comp
L CONN_4 P1
U 1 1 46557814
P 6000 4300
F 0 "P1" V 5950 4300 50  0000 C C
F 1 "CONN_4" V 6050 4300 50  0000 C C
	1    6000 4300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
