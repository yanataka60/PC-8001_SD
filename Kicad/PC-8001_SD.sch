EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr User 15748 10236
encoding utf-8
Sheet 1 1
Title "PC-8001_SD"
Date "2022-01-14"
Rev "Rev1.4"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	6700 3500 7000 3500
Wire Wire Line
	6500 4500 6500 1900
Wire Wire Line
	6500 1900 7000 1900
Wire Wire Line
	6400 2000 7000 2000
Wire Wire Line
	3850 2700 7000 2700
Wire Wire Line
	3850 2800 7000 2800
Wire Wire Line
	3850 2900 7000 2900
Wire Wire Line
	3850 3000 7000 3000
$Comp
L power:+5V #PWR05
U 1 1 61C53293
P 7400 1700
F 0 "#PWR05" H 7400 1550 50  0001 C CNN
F 1 "+5V" H 7415 1873 50  0000 C CNN
F 2 "" H 7400 1700 50  0001 C CNN
F 3 "" H 7400 1700 50  0001 C CNN
	1    7400 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 61CA5FA4
P 7400 3850
F 0 "#PWR06" H 7400 3600 50  0001 C CNN
F 1 "GND" H 7405 3677 50  0000 C CNN
F 2 "" H 7400 3850 50  0001 C CNN
F 3 "" H 7400 3850 50  0001 C CNN
	1    7400 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 61E99EF6
P 7050 3850
F 0 "C5" V 6900 3950 50  0000 C CNN
F 1 "0.1uF" V 6900 3700 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 7088 3700 50  0001 C CNN
F 3 "~" H 7050 3850 50  0001 C CNN
	1    7050 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7200 3850 7400 3850
Wire Wire Line
	7400 3800 7400 3850
Connection ~ 7400 3850
Wire Wire Line
	6900 3850 6900 3400
Wire Wire Line
	6900 1700 7400 1700
Wire Wire Line
	7000 3300 6900 3300
Connection ~ 6900 3300
Wire Wire Line
	6900 3300 6900 1700
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 626B92AA
P 2650 8050
F 0 "#FLG0101" H 2650 8125 50  0001 C CNN
F 1 "PWR_FLAG" H 2650 8223 50  0000 C CNN
F 2 "" H 2650 8050 50  0001 C CNN
F 3 "~" H 2650 8050 50  0001 C CNN
	1    2650 8050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 62901E30
P 2950 7950
F 0 "#PWR015" H 2950 7800 50  0001 C CNN
F 1 "+5V" H 2965 8123 50  0000 C CNN
F 2 "" H 2950 7950 50  0001 C CNN
F 3 "" H 2950 7950 50  0001 C CNN
	1    2950 7950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 7950 2950 8050
Wire Wire Line
	2650 8050 2950 8050
Connection ~ 2950 8050
$Comp
L Connector_Generic:Conn_02x25_Odd_Even J1
U 1 1 61ABAF01
P 2350 2400
F 0 "J1" H 2400 975 50  0000 C CNN
F 1 "PC-8001 BUS" H 2400 1066 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x25_P2.54mm_Horizontal" H 2350 2400 50  0001 C CNN
F 3 "~" H 2350 2400 50  0001 C CNN
	1    2350 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3100 3850 3100
$Comp
L Device:CP1 C6
U 1 1 61AFFCD6
P 2950 8200
F 0 "C6" H 3065 8246 50  0000 L CNN
F 1 "100uF" H 3065 8155 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 2950 8200 50  0001 C CNN
F 3 "~" H 2950 8200 50  0001 C CNN
	1    2950 8200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 61B04D1B
P 2950 8500
F 0 "#PWR013" H 2950 8250 50  0001 C CNN
F 1 "GND" H 2955 8327 50  0000 C CNN
F 2 "" H 2950 8500 50  0001 C CNN
F 3 "" H 2950 8500 50  0001 C CNN
	1    2950 8500
	1    0    0    -1  
$EndComp
Connection ~ 7400 1700
$Comp
L Memory_EPROM:27C64 U5
U 1 1 61A4CF3B
P 7400 2700
F 0 "U5" H 7200 3650 50  0000 C CNN
F 1 "2764" H 7600 3650 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_LongPads" H 7400 2700 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/11107M.pdf" H 7400 2700 50  0001 C CNN
	1    7400 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3400 6900 3400
Connection ~ 6900 3400
Wire Wire Line
	6900 3400 6900 3300
Wire Wire Line
	7900 5600 7900 2600
Wire Wire Line
	8750 2600 7900 2600
Connection ~ 7900 2600
Wire Wire Line
	7800 2600 7900 2600
Wire Wire Line
	6600 3600 6600 6900
Wire Wire Line
	6600 3600 7000 3600
Connection ~ 6600 6900
$Comp
L 74xx:74LS30 U3
U 1 1 620D1DFE
P 6100 5000
F 0 "U3" H 6450 5100 50  0000 C CNN
F 1 "74LS30" H 6400 4900 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 6100 5000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 6100 5000 50  0001 C CNN
	1    6100 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 4800 5800 4800
Wire Wire Line
	5550 4900 5800 4900
$Comp
L 74xx:74LS04 U1
U 1 1 6212ABE9
P 5000 5000
F 0 "U1" H 4800 5200 50  0000 C CNN
F 1 "74LS04" H 5050 5200 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5000 5000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5000 5000 50  0001 C CNN
	1    5000 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 5000 4000 5000
Wire Wire Line
	4000 5000 4000 5800
Wire Wire Line
	5800 5200 5800 5300
Connection ~ 5800 5300
Wire Wire Line
	5800 5300 5800 5400
$Comp
L power:+5V #PWR03
U 1 1 62174D5D
P 5550 5550
F 0 "#PWR03" H 5550 5400 50  0001 C CNN
F 1 "+5V" H 5565 5723 50  0000 C CNN
F 2 "" H 5550 5550 50  0001 C CNN
F 3 "" H 5550 5550 50  0001 C CNN
	1    5550 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 5400 5800 5600
Wire Wire Line
	5800 5600 5550 5600
Wire Wire Line
	5550 5600 5550 5550
Connection ~ 5800 5400
Wire Wire Line
	6400 5000 6700 5000
Wire Wire Line
	6700 5000 6700 3500
$Comp
L 74xx:74LS30 U3
U 2 1 621D8C3B
P 10050 8200
F 0 "U3" H 10280 8246 50  0000 L CNN
F 1 "74LS30" H 10280 8155 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 10050 8200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 10050 8200 50  0001 C CNN
	2    10050 8200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U2
U 1 1 621DA5E3
P 7250 6050
F 0 "U2" H 7250 6575 50  0000 C CNN
F 1 "74LS30" H 7250 6484 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 7250 6050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 7250 6050 50  0001 C CNN
	1    7250 6050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U2
U 2 1 621FB49F
P 8950 8200
F 0 "U2" H 9180 8246 50  0000 L CNN
F 1 "74LS30" H 9180 8155 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 8950 8200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 8950 8200 50  0001 C CNN
	2    8950 8200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 7 1 62200B27
P 7850 8200
F 0 "U1" H 8080 8246 50  0000 L CNN
F 1 "74LS04" H 8080 8155 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 7850 8200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 7850 8200 50  0001 C CNN
	7    7850 8200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 6 1 6232F73D
P 9300 3700
F 0 "U1" H 9500 3450 50  0000 C CNN
F 1 "74LS04" H 9150 3450 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 9300 3700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9300 3700 50  0001 C CNN
	6    9300 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 6550 6750 6550
Wire Wire Line
	6750 6550 6750 6350
Wire Wire Line
	6750 6350 6950 6350
Wire Wire Line
	7550 6050 7650 6050
Wire Wire Line
	7650 4000 7650 6050
$Comp
L power:+5V #PWR017
U 1 1 6252FE80
P 7300 6550
F 0 "#PWR017" H 7300 6400 50  0001 C CNN
F 1 "+5V" H 7315 6723 50  0000 C CNN
F 2 "" H 7300 6550 50  0001 C CNN
F 3 "" H 7300 6550 50  0001 C CNN
	1    7300 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 6450 6900 6450
Wire Wire Line
	6900 6450 6900 6650
Wire Wire Line
	6900 6650 7300 6650
Wire Wire Line
	7300 6650 7300 6550
$Comp
L Device:C C1
U 1 1 628C00D7
P 7400 8250
F 0 "C1" V 7250 8350 50  0000 C CNN
F 1 "0.1uF" V 7250 8100 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 7438 8100 50  0001 C CNN
F 3 "~" H 7400 8250 50  0001 C CNN
	1    7400 8250
	-1   0    0    1   
$EndComp
$Comp
L Device:C C2
U 1 1 628E1651
P 8500 8250
F 0 "C2" V 8350 8350 50  0000 C CNN
F 1 "0.1uF" V 8350 8100 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 8538 8100 50  0001 C CNN
F 3 "~" H 8500 8250 50  0001 C CNN
	1    8500 8250
	-1   0    0    1   
$EndComp
$Comp
L Device:C C3
U 1 1 62902A84
P 9650 8250
F 0 "C3" V 9500 8350 50  0000 C CNN
F 1 "0.1uF" V 9500 8100 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 9688 8100 50  0001 C CNN
F 3 "~" H 9650 8250 50  0001 C CNN
	1    9650 8250
	-1   0    0    1   
$EndComp
Wire Wire Line
	7400 8100 7400 7600
Wire Wire Line
	8950 7600 8950 7700
Wire Wire Line
	8950 7600 9650 7600
Wire Wire Line
	10050 7600 10050 7700
Connection ~ 8950 7600
Wire Wire Line
	7400 8400 7400 8800
Wire Wire Line
	7400 8800 7850 8800
Wire Wire Line
	7850 8800 7850 8700
Wire Wire Line
	7850 8800 8500 8800
Wire Wire Line
	8950 8800 8950 8700
Connection ~ 7850 8800
Wire Wire Line
	8950 8800 9650 8800
Wire Wire Line
	10050 8800 10050 8700
Connection ~ 8950 8800
Wire Wire Line
	9650 8400 9650 8800
Connection ~ 9650 8800
Wire Wire Line
	9650 8800 10050 8800
Wire Wire Line
	9650 8100 9650 7600
Connection ~ 9650 7600
Wire Wire Line
	9650 7600 10050 7600
Wire Wire Line
	8500 8400 8500 8800
Connection ~ 8500 8800
Wire Wire Line
	8500 8800 8950 8800
$Comp
L power:GND #PWR016
U 1 1 62BBAEEE
P 7400 8900
F 0 "#PWR016" H 7400 8650 50  0001 C CNN
F 1 "GND" H 7405 8727 50  0000 C CNN
F 2 "" H 7400 8900 50  0001 C CNN
F 3 "" H 7400 8900 50  0001 C CNN
	1    7400 8900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 62C0DD1E
P 7400 7500
F 0 "#PWR014" H 7400 7350 50  0001 C CNN
F 1 "+5V" H 7415 7673 50  0000 C CNN
F 2 "" H 7400 7500 50  0001 C CNN
F 3 "" H 7400 7500 50  0001 C CNN
	1    7400 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 7500 7400 7600
Connection ~ 7400 7600
Wire Wire Line
	7400 8800 7400 8900
Connection ~ 7400 8800
Wire Wire Line
	6400 2000 6400 4600
Text Label 2050 1200 0    50   ~ 0
Vcc
Text Label 2050 1300 0    50   ~ 0
D0
Text Label 2050 1400 0    50   ~ 0
D1
Text Label 2050 1500 0    50   ~ 0
D2
Text Label 2050 1600 0    50   ~ 0
D3
Text Label 2050 1700 0    50   ~ 0
D4
Text Label 2050 1800 0    50   ~ 0
D5
Text Label 2050 1900 0    50   ~ 0
D6
Text Label 2050 2000 0    50   ~ 0
D7
Text Label 2050 2100 0    50   ~ 0
A0
Text Label 2050 2200 0    50   ~ 0
A1
Text Label 2050 2300 0    50   ~ 0
A2
Text Label 2050 2400 0    50   ~ 0
A3
Text Label 2050 2500 0    50   ~ 0
A4
Text Label 2050 2600 0    50   ~ 0
A5
Text Label 2050 2700 0    50   ~ 0
A6
Text Label 2050 2800 0    50   ~ 0
A7
Text Label 2050 2900 0    50   ~ 0
~RD
Text Label 2050 3000 0    50   ~ 0
~WR
Text Label 1950 3100 0    50   ~ 0
~MREQ
Text Label 1950 3200 0    50   ~ 0
~IOREQ
Text Label 2650 1700 0    50   ~ 0
~ROMDS3
Text Label 2650 2100 0    50   ~ 0
A8
Text Label 2650 2200 0    50   ~ 0
A9
Text Label 2650 2300 0    50   ~ 0
A10
Text Label 2650 2400 0    50   ~ 0
A11
Text Label 2650 2500 0    50   ~ 0
A12
Text Label 2650 2600 0    50   ~ 0
A13
Text Label 2650 2700 0    50   ~ 0
A14
Text Label 2650 2800 0    50   ~ 0
A15
Text Label 2650 2900 0    50   ~ 0
~RESET
Text Label 2650 3500 0    50   ~ 0
GND
Text Label 2650 3600 0    50   ~ 0
GND
Wire Wire Line
	1950 2000 2150 2000
Wire Wire Line
	1950 1900 2150 1900
Wire Wire Line
	1950 1800 2150 1800
Wire Wire Line
	1950 1700 2150 1700
Wire Wire Line
	1950 1600 2150 1600
Wire Wire Line
	1950 1500 2150 1500
Wire Wire Line
	1950 1400 2150 1400
Wire Wire Line
	1950 1300 2150 1300
Connection ~ 6500 1900
Connection ~ 6400 2000
Wire Wire Line
	1950 2300 2150 2300
Wire Wire Line
	1950 2400 2150 2400
Wire Wire Line
	1950 2500 2150 2500
Wire Wire Line
	1950 2600 2150 2600
Wire Wire Line
	1950 2700 2150 2700
Wire Wire Line
	1950 2800 2150 2800
Wire Wire Line
	2650 2500 2800 2500
Wire Wire Line
	5450 6900 6600 6900
Wire Wire Line
	1950 2900 2150 2900
Wire Wire Line
	1950 3000 2150 3000
Wire Wire Line
	2650 2900 2800 2900
Wire Wire Line
	1950 3200 2150 3200
Wire Wire Line
	3650 5800 4000 5800
Wire Wire Line
	1950 3100 2150 3100
Wire Wire Line
	3850 2100 4100 2100
Wire Wire Line
	3850 2200 4200 2200
Wire Wire Line
	3850 2300 4300 2300
Wire Wire Line
	3850 2400 4400 2400
Wire Wire Line
	3850 2500 4500 2500
Wire Wire Line
	3850 2600 4600 2600
Wire Wire Line
	6950 6250 4100 6250
Wire Wire Line
	4100 6250 4100 2100
Connection ~ 4100 2100
Wire Wire Line
	4100 2100 7000 2100
Wire Wire Line
	6950 6150 4200 6150
Wire Wire Line
	4200 6150 4200 2200
Connection ~ 4200 2200
Wire Wire Line
	4200 2200 7000 2200
Wire Wire Line
	6950 6050 4300 6050
Wire Wire Line
	4300 6050 4300 2300
Connection ~ 4300 2300
Wire Wire Line
	4300 2300 7000 2300
Wire Wire Line
	6950 5950 4400 5950
Wire Wire Line
	4400 5950 4400 2400
Connection ~ 4400 2400
Wire Wire Line
	4400 2400 7000 2400
Wire Wire Line
	6950 5850 4500 5850
Wire Wire Line
	4500 5850 4500 2500
Connection ~ 4500 2500
Wire Wire Line
	4500 2500 7000 2500
Wire Wire Line
	4600 5750 4600 2600
Connection ~ 4600 2600
Wire Wire Line
	4600 2600 7000 2600
$Comp
L 74xx:74LS04 U1
U 4 1 63D902FA
P 6200 6550
F 0 "U1" H 6200 6867 50  0000 C CNN
F 1 "74LS04" H 6200 6776 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 6200 6550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 6200 6550 50  0001 C CNN
	4    6200 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2800 2800 2800
Wire Wire Line
	2650 2600 2800 2600
Wire Wire Line
	2650 2700 2800 2700
Wire Wire Line
	2650 2100 2800 2100
Wire Wire Line
	2650 2200 2800 2200
Wire Wire Line
	2650 2300 2800 2300
Wire Wire Line
	2650 2400 2800 2400
Wire Wire Line
	5300 5000 5800 5000
Wire Wire Line
	5300 5450 5350 5450
Wire Wire Line
	2650 3500 2800 3500
Wire Wire Line
	2650 3600 2800 3600
Wire Wire Line
	3650 7100 8900 7100
Wire Wire Line
	5450 7000 8800 7000
Wire Wire Line
	8900 3000 11600 3000
Wire Wire Line
	8900 3700 8900 7100
Connection ~ 8900 3700
Wire Wire Line
	9000 3700 8900 3700
Wire Wire Line
	9600 3700 9750 3700
Wire Wire Line
	8900 3000 8900 3700
Wire Wire Line
	11600 4400 11700 4400
Wire Wire Line
	11600 3000 11600 4400
Wire Wire Line
	11150 6200 13250 6200
Wire Wire Line
	11150 4600 11700 4600
Wire Wire Line
	11150 4700 11700 4700
Wire Wire Line
	11150 4800 11700 4800
Wire Wire Line
	11150 4900 11700 4900
Wire Wire Line
	11150 5000 11700 5000
Wire Wire Line
	11150 5100 11700 5100
Wire Wire Line
	11150 5200 11700 5200
Wire Wire Line
	11150 5300 11700 5300
$Comp
L 74xx:74LS04 U1
U 3 1 6232C3F4
P 5000 4550
F 0 "U1" H 4850 4750 50  0000 C CNN
F 1 "74LS04" H 5100 4750 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5000 4550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5000 4550 50  0001 C CNN
	3    5000 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 6900 8700 6900
Wire Wire Line
	7900 5600 9750 5600
Wire Wire Line
	8000 5500 9750 5500
Wire Wire Line
	8100 5400 9750 5400
Wire Wire Line
	8200 5300 9750 5300
Wire Wire Line
	8300 5200 9750 5200
Wire Wire Line
	8400 5100 9750 5100
Wire Wire Line
	8500 5000 9750 5000
Wire Wire Line
	8600 4900 9750 4900
Wire Wire Line
	8800 4200 9750 4200
Wire Wire Line
	8800 7000 8800 4200
Wire Wire Line
	8700 4100 9750 4100
Wire Wire Line
	8700 6900 8700 4100
Wire Wire Line
	7650 4000 9750 4000
Wire Wire Line
	7800 2500 8000 2500
Wire Wire Line
	7800 2400 8100 2400
Wire Wire Line
	7800 2300 8200 2300
Wire Wire Line
	7800 2200 8300 2200
Wire Wire Line
	7800 2100 8400 2100
Wire Wire Line
	7800 2000 8500 2000
Wire Wire Line
	7800 1900 8600 1900
Connection ~ 8000 2500
Wire Wire Line
	8750 2500 8000 2500
Connection ~ 8100 2400
Wire Wire Line
	8750 2400 8100 2400
Connection ~ 8200 2300
Wire Wire Line
	8750 2300 8200 2300
Connection ~ 8300 2200
Wire Wire Line
	8750 2200 8300 2200
Connection ~ 8400 2100
Wire Wire Line
	8750 2100 8400 2100
Connection ~ 8500 2000
Wire Wire Line
	8750 2000 8500 2000
Connection ~ 8600 1900
Wire Wire Line
	8750 1900 8600 1900
Wire Wire Line
	8000 5500 8000 2500
Wire Wire Line
	8100 5400 8100 2400
Wire Wire Line
	8200 5300 8200 2300
Wire Wire Line
	8300 5200 8300 2200
Wire Wire Line
	8400 5100 8400 2100
Wire Wire Line
	8500 5000 8500 2000
Wire Wire Line
	8600 4900 8600 1900
Wire Wire Line
	6500 4500 9750 4500
Wire Wire Line
	6400 4600 9750 4600
Wire Wire Line
	13950 5000 12900 5000
Wire Wire Line
	13950 3300 13950 5000
Wire Wire Line
	12450 3300 13950 3300
Wire Wire Line
	12450 2300 12450 3300
Wire Wire Line
	13050 2300 12450 2300
Wire Wire Line
	13850 5100 12900 5100
Wire Wire Line
	13850 3400 13850 5100
Wire Wire Line
	12550 3400 13850 3400
Wire Wire Line
	12550 2400 12550 3400
Wire Wire Line
	13050 2400 12550 2400
Wire Wire Line
	13750 5200 12900 5200
Wire Wire Line
	13750 3500 13750 5200
Wire Wire Line
	12650 3500 13750 3500
Wire Wire Line
	12650 2500 12650 3500
Wire Wire Line
	13050 2500 12650 2500
Wire Wire Line
	13650 5300 12900 5300
Wire Wire Line
	13650 3600 13650 5300
Wire Wire Line
	12750 3600 13650 3600
Wire Wire Line
	12750 2600 12750 3600
Wire Wire Line
	13050 2600 12750 2600
Wire Wire Line
	11150 3700 13350 3700
Wire Wire Line
	11150 3800 13250 3800
Wire Wire Line
	11150 3900 11500 3900
Wire Wire Line
	11150 4000 11400 4000
$Comp
L Memory_RAM2:Micro_SD_Card_Kit J2
U 1 1 6188B7C4
P 13950 2200
F 0 "J2" H 13450 2900 50  0000 L CNN
F 1 "Micro_SD_Card_Kit" H 13950 2900 50  0000 L CNN
F 2 "Kicad:AE-microSD-LLCNV" H 15100 2500 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 13950 2200 50  0001 C CNN
	1    13950 2200
	1    0    0    -1  
$EndComp
NoConn ~ 13050 2000
NoConn ~ 13050 2100
NoConn ~ 13050 2700
$Comp
L power:+5V #PWR011
U 1 1 625CD0DA
P 12900 1750
F 0 "#PWR011" H 12900 1600 50  0001 C CNN
F 1 "+5V" H 12915 1923 50  0000 C CNN
F 2 "" H 12900 1750 50  0001 C CNN
F 3 "" H 12900 1750 50  0001 C CNN
	1    12900 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	12900 1750 12900 1900
Wire Wire Line
	12900 1900 13050 1900
$Comp
L power:GND #PWR012
U 1 1 625DAB5A
P 12900 2850
F 0 "#PWR012" H 12900 2600 50  0001 C CNN
F 1 "GND" H 12905 2677 50  0000 C CNN
F 2 "" H 12900 2850 50  0001 C CNN
F 3 "" H 12900 2850 50  0001 C CNN
	1    12900 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	13050 2200 12900 2200
Wire Wire Line
	12900 2200 12900 2850
Wire Wire Line
	13100 4500 13100 4200
Wire Wire Line
	12900 4500 13100 4500
NoConn ~ 11700 4200
NoConn ~ 11700 4300
NoConn ~ 11700 4500
NoConn ~ 12200 5700
NoConn ~ 12300 5700
NoConn ~ 12900 4400
NoConn ~ 12900 4200
NoConn ~ 11150 6100
NoConn ~ 11150 6000
NoConn ~ 11150 5900
NoConn ~ 11150 5800
NoConn ~ 11150 5600
NoConn ~ 11150 5500
NoConn ~ 11150 4400
NoConn ~ 11150 4300
NoConn ~ 11150 4200
NoConn ~ 11150 4100
$Comp
L power:+5V #PWR010
U 1 1 621E99AD
P 13100 4200
F 0 "#PWR010" H 13100 4050 50  0001 C CNN
F 1 "+5V" H 13115 4373 50  0000 C CNN
F 2 "" H 13100 4200 50  0001 C CNN
F 3 "" H 13100 4200 50  0001 C CNN
	1    13100 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	13000 4300 13000 5500
Wire Wire Line
	12900 4300 13000 4300
$Comp
L power:GND #PWR09
U 1 1 621A9C99
P 13000 5500
F 0 "#PWR09" H 13000 5250 50  0001 C CNN
F 1 "GND" H 13005 5327 50  0000 C CNN
F 2 "" H 13000 5500 50  0001 C CNN
F 3 "" H 13000 5500 50  0001 C CNN
	1    13000 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	12500 5900 12500 5700
Wire Wire Line
	11400 5900 12500 5900
Wire Wire Line
	11400 4000 11400 5900
Wire Wire Line
	12400 5800 12400 5700
Wire Wire Line
	11500 5800 12400 5800
Wire Wire Line
	11500 3900 11500 5800
Wire Wire Line
	13250 4600 12900 4600
Wire Wire Line
	13250 3800 13250 4600
Wire Wire Line
	13350 4700 12900 4700
Wire Wire Line
	13350 3700 13350 4700
Wire Wire Line
	13350 4800 12900 4800
Wire Wire Line
	13350 6300 13350 4800
Wire Wire Line
	11300 6300 13350 6300
Wire Wire Line
	11300 5700 11300 6300
Wire Wire Line
	11150 5700 11300 5700
Wire Wire Line
	13250 4900 12900 4900
Wire Wire Line
	13250 6200 13250 4900
Connection ~ 10450 3400
$Comp
L power:+5V #PWR07
U 1 1 61F63930
P 10450 3400
F 0 "#PWR07" H 10450 3250 50  0001 C CNN
F 1 "+5V" H 10465 3573 50  0000 C CNN
F 2 "" H 10450 3400 50  0001 C CNN
F 3 "" H 10450 3400 50  0001 C CNN
	1    10450 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 3400 10450 3400
Wire Wire Line
	9700 6650 9700 3400
Wire Wire Line
	9800 6650 9700 6650
Connection ~ 10450 6650
Wire Wire Line
	10450 6600 10450 6650
Wire Wire Line
	10450 6650 10450 6700
Wire Wire Line
	10100 6650 10450 6650
$Comp
L power:GND #PWR08
U 1 1 61F38F70
P 10450 6700
F 0 "#PWR08" H 10450 6450 50  0001 C CNN
F 1 "GND" H 10455 6527 50  0000 C CNN
F 2 "" H 10450 6700 50  0001 C CNN
F 3 "" H 10450 6700 50  0001 C CNN
	1    10450 6700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 61F2D5C6
P 9950 6650
F 0 "C4" V 9800 6750 50  0000 C CNN
F 1 "0.1uF" V 9800 6500 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 9988 6500 50  0001 C CNN
F 3 "~" H 9950 6650 50  0001 C CNN
	1    9950 6650
	0    -1   -1   0   
$EndComp
$Comp
L Interface:8255 U4
U 1 1 618A36EE
P 10450 5000
F 0 "U4" H 10050 6500 50  0000 C CNN
F 1 "8255" H 10850 6500 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 10450 5300 50  0001 C CNN
F 3 "http://aturing.umcs.maine.edu/~meadow/courses/cos335/Intel8255A.pdf" H 10450 5300 50  0001 C CNN
	1    10450 5000
	1    0    0    -1  
$EndComp
$Comp
L Arduino:Arduino_Pro_Mini U6
U 1 1 61A254A8
P 12300 4800
F 0 "U6" H 12300 5689 60  0000 C CNN
F 1 "Arduino_Pro_Mini_5V" H 12300 5583 60  0000 C CNN
F 2 "Kicad:Arduino_Pro_Mini" H 13100 4050 60  0001 C CNN
F 3 "https://www.sparkfun.com/products/11113" H 12500 3600 60  0001 C CNN
	1    12300 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 7600 8950 7600
Wire Wire Line
	8500 8100 8500 7600
Connection ~ 8500 7600
Connection ~ 7850 7600
Wire Wire Line
	7850 7600 7850 7700
Wire Wire Line
	7400 7600 7850 7600
Wire Wire Line
	7850 7600 8500 7600
Wire Wire Line
	5550 4700 5800 4700
Wire Wire Line
	3650 6550 5900 6550
Wire Wire Line
	3150 8050 2950 8050
Wire Wire Line
	1950 1200 2150 1200
Text Label 8750 1900 0    50   ~ 0
D0
Text Label 8750 2000 0    50   ~ 0
D1
Text Label 8750 2100 0    50   ~ 0
D2
Text Label 8750 2200 0    50   ~ 0
D3
Text Label 8750 2300 0    50   ~ 0
D4
Text Label 8750 2400 0    50   ~ 0
D5
Text Label 8750 2500 0    50   ~ 0
D6
Text Label 8750 2600 0    50   ~ 0
D7
Wire Wire Line
	6400 2000 6150 2000
Wire Wire Line
	1950 2200 2150 2200
Wire Wire Line
	6500 1900 6150 1900
Wire Wire Line
	1950 2100 2150 2100
Text Label 6150 1900 0    50   ~ 0
A0
Text Label 6150 2000 0    50   ~ 0
A1
Text Label 3850 2100 0    50   ~ 0
A2
Text Label 3850 2200 0    50   ~ 0
A3
Text Label 3850 2300 0    50   ~ 0
A4
Text Label 3850 2400 0    50   ~ 0
A5
Text Label 3850 2500 0    50   ~ 0
A6
Text Label 3850 2600 0    50   ~ 0
A7
Text Label 5450 6900 0    50   ~ 0
~RD
Text Label 5450 7000 0    50   ~ 0
~WR
Text Label 3150 8050 0    50   ~ 0
Vcc
Text Label 3650 5800 0    50   ~ 0
~MREQ
Text Label 3650 6550 0    50   ~ 0
~IOREQ
Text Label 3850 2700 0    50   ~ 0
A8
Text Label 3850 2800 0    50   ~ 0
A9
Text Label 3850 2900 0    50   ~ 0
A10
Text Label 3850 3000 0    50   ~ 0
A11
Text Label 3850 3100 0    50   ~ 0
A12
Text Label 5550 4900 0    50   ~ 0
A13
Text Label 5550 4800 0    50   ~ 0
A14
Text Label 3650 4550 0    50   ~ 0
A15
Text Label 3650 7100 0    50   ~ 0
~RESET
$Comp
L Connector_Generic:Conn_01x25 J3
U 1 1 62A95900
P 1550 2400
F 0 "J3" H 1500 950 50  0000 L CNN
F 1 "Conn_01x25" H 1350 1050 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x25_P2.54mm_Vertical" H 1550 2400 50  0001 C CNN
F 3 "~" H 1550 2400 50  0001 C CNN
	1    1550 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 2100 1350 2100
Wire Wire Line
	1150 2200 1350 2200
Wire Wire Line
	1150 1200 1350 1200
Wire Wire Line
	1150 3100 1350 3100
Wire Wire Line
	1150 3200 1350 3200
Wire Wire Line
	1150 3000 1350 3000
Wire Wire Line
	1150 2900 1350 2900
Wire Wire Line
	1150 2800 1350 2800
Wire Wire Line
	1150 2700 1350 2700
Wire Wire Line
	1150 2600 1350 2600
Wire Wire Line
	1150 2500 1350 2500
Wire Wire Line
	1150 2400 1350 2400
Wire Wire Line
	1150 2300 1350 2300
Wire Wire Line
	1150 1300 1350 1300
Wire Wire Line
	1150 1400 1350 1400
Wire Wire Line
	1150 1500 1350 1500
Wire Wire Line
	1150 1600 1350 1600
Wire Wire Line
	1150 1700 1350 1700
Wire Wire Line
	1150 1800 1350 1800
Wire Wire Line
	1150 1900 1350 1900
Wire Wire Line
	1150 2000 1350 2000
Text Label 1150 3200 0    50   ~ 0
~IOREQ
Text Label 1150 3100 0    50   ~ 0
~MREQ
Text Label 1250 3000 0    50   ~ 0
~WR
Text Label 1250 2900 0    50   ~ 0
~RD
Text Label 1250 2800 0    50   ~ 0
A7
Text Label 1250 2700 0    50   ~ 0
A6
Text Label 1250 2600 0    50   ~ 0
A5
Text Label 1250 2500 0    50   ~ 0
A4
Text Label 1250 2400 0    50   ~ 0
A3
Text Label 1250 2300 0    50   ~ 0
A2
Text Label 1250 2200 0    50   ~ 0
A1
Text Label 1250 2100 0    50   ~ 0
A0
Text Label 1250 2000 0    50   ~ 0
D7
Text Label 1250 1900 0    50   ~ 0
D6
Text Label 1250 1800 0    50   ~ 0
D5
Text Label 1250 1700 0    50   ~ 0
D4
Text Label 1250 1600 0    50   ~ 0
D3
Text Label 1250 1500 0    50   ~ 0
D2
Text Label 1250 1400 0    50   ~ 0
D1
Text Label 1250 1300 0    50   ~ 0
D0
Text Label 1250 1200 0    50   ~ 0
Vcc
Wire Wire Line
	2350 8250 2350 8400
$Comp
L power:PWR_FLAG #FLG01
U 1 1 61C4340B
P 2350 8250
F 0 "#FLG01" H 2350 8325 50  0001 C CNN
F 1 "PWR_FLAG" H 2600 8350 50  0000 C CNN
F 2 "" H 2350 8250 50  0001 C CNN
F 3 "~" H 2350 8250 50  0001 C CNN
	1    2350 8250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 8400 2950 8400
Wire Wire Line
	2950 8400 2950 8350
Wire Wire Line
	2950 8400 2950 8500
Connection ~ 2950 8400
Wire Wire Line
	2650 1700 2800 1700
Text Label 1700 5550 0    50   ~ 0
~ROMDS3
Wire Wire Line
	4700 5450 4350 5450
$Comp
L 74xx:74LS04 U1
U 2 1 6232A904
P 5000 5450
F 0 "U1" H 4800 5650 50  0000 C CNN
F 1 "74LS04" H 5050 5650 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5000 5450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5000 5450 50  0001 C CNN
	2    5000 5450
	1    0    0    -1  
$EndComp
$Comp
L Memory_RAM2:SLIDE_SWITCH_3P S1
U 1 1 62C0A0CD
P 5150 3450
F 0 "S1" H 5150 3515 50  0000 C CNN
F 1 "SLIDE_SWITCH_3P" H 5150 3424 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 5150 3475 50  0001 C CNN
F 3 "" H 5150 3475 50  0001 C CNN
	1    5150 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 5450 4350 4000
Wire Wire Line
	4350 4000 5150 4000
Wire Wire Line
	5150 4000 5150 3800
Wire Wire Line
	2300 5550 1700 5550
Wire Wire Line
	4950 3650 4850 3650
Wire Wire Line
	4850 3650 4850 3750
Wire Wire Line
	5350 3650 5600 3650
Wire Wire Line
	5600 3650 5600 3550
$Comp
L power:GND #PWR01
U 1 1 62C5E736
P 4850 3750
F 0 "#PWR01" H 4850 3500 50  0001 C CNN
F 1 "GND" H 4855 3577 50  0000 C CNN
F 2 "" H 4850 3750 50  0001 C CNN
F 3 "" H 4850 3750 50  0001 C CNN
	1    4850 3750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR018
U 1 1 62C87E97
P 5600 3550
F 0 "#PWR018" H 5600 3400 50  0001 C CNN
F 1 "+5V" H 5615 3723 50  0000 C CNN
F 2 "" H 5600 3550 50  0001 C CNN
F 3 "" H 5600 3550 50  0001 C CNN
	1    5600 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4550 5550 4550
Wire Wire Line
	5550 4550 5550 4700
Wire Wire Line
	4700 4550 3650 4550
$Comp
L Connector_Generic:Conn_01x06 J4
U 1 1 631763B9
P 14900 3500
F 0 "J4" H 14550 3050 50  0000 L CNN
F 1 "MicroSD Card Adapter" H 14300 2950 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 14900 3500 50  0001 C CNN
F 3 "~" H 14900 3500 50  0001 C CNN
	1    14900 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	14700 3300 14450 3300
Wire Wire Line
	14700 3400 14450 3400
Wire Wire Line
	14700 3500 14450 3500
Wire Wire Line
	14700 3600 14450 3600
Wire Wire Line
	14700 3700 14450 3700
Wire Wire Line
	14700 3800 14450 3800
Text Label 14450 3300 0    50   ~ 0
GND
Text Label 14450 3400 0    50   ~ 0
+5V
Text Label 14450 3500 0    50   ~ 0
MISO
Text Label 14450 3600 0    50   ~ 0
MOSI
Text Label 14450 3700 0    50   ~ 0
SCK
Text Label 14450 3800 0    50   ~ 0
CS
Text Label 12450 2300 0    50   ~ 0
SCK
Text Label 12550 2400 0    50   ~ 0
MISO
Text Label 12650 2500 0    50   ~ 0
MOSI
Text Label 12750 2600 0    50   ~ 0
CS
$Comp
L Switch:SW_Push_DPDT S2
U 1 1 6325E19E
P 2500 5750
F 0 "S2" H 2500 6235 50  0000 C CNN
F 1 "SLIDE SWITCH" H 2500 6144 50  0000 C CNN
F 2 "Button_Switch_THT:SW_CuK_JS202011CQN_DPDT_Straight" H 2500 5950 50  0001 C CNN
F 3 "~" H 2500 5950 50  0001 C CNN
	1    2500 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 5450 2700 5450
Connection ~ 4350 5450
Wire Wire Line
	2700 5650 2850 5650
Wire Wire Line
	2850 5650 2850 6050
Wire Wire Line
	2850 6050 2700 6050
Wire Wire Line
	5800 5100 5450 5100
Wire Wire Line
	5450 5100 5450 6350
Wire Wire Line
	5450 6350 2100 6350
Wire Wire Line
	2100 6350 2100 5950
Wire Wire Line
	2100 5950 2300 5950
Wire Wire Line
	2700 5850 3000 5850
Wire Wire Line
	3000 5850 3000 6300
Wire Wire Line
	3000 6300 5350 6300
Wire Wire Line
	5350 6300 5350 5450
$Comp
L Connector_Generic:Conn_02x25_Odd_Even J5
U 1 1 64C76B34
P 1200 7100
F 0 "J5" H 1250 5675 50  0000 C CNN
F 1 "PC-8001 BUS" H 1250 5766 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x25_P2.54mm_Vertical" H 1200 7100 50  0001 C CNN
F 3 "~" H 1200 7100 50  0001 C CNN
	1    1200 7100
	1    0    0    -1  
$EndComp
Text Label 900  5900 0    50   ~ 0
Vcc
Text Label 900  6000 0    50   ~ 0
D0
Text Label 900  6100 0    50   ~ 0
D1
Text Label 900  6200 0    50   ~ 0
D2
Text Label 900  6300 0    50   ~ 0
D3
Text Label 900  6400 0    50   ~ 0
D4
Text Label 900  6500 0    50   ~ 0
D5
Text Label 900  6600 0    50   ~ 0
D6
Text Label 900  6700 0    50   ~ 0
D7
Text Label 900  6800 0    50   ~ 0
A0
Text Label 900  6900 0    50   ~ 0
A1
Text Label 900  7000 0    50   ~ 0
A2
Text Label 900  7100 0    50   ~ 0
A3
Text Label 900  7200 0    50   ~ 0
A4
Text Label 900  7300 0    50   ~ 0
A5
Text Label 900  7400 0    50   ~ 0
A6
Text Label 900  7500 0    50   ~ 0
A7
Text Label 900  7600 0    50   ~ 0
~RD
Text Label 900  7700 0    50   ~ 0
~WR
Text Label 800  7800 0    50   ~ 0
~MREQ
Text Label 800  7900 0    50   ~ 0
~IOREQ
Text Label 1500 6400 0    50   ~ 0
~ROMDS3
Text Label 1500 6800 0    50   ~ 0
A8
Text Label 1500 6900 0    50   ~ 0
A9
Text Label 1500 7000 0    50   ~ 0
A10
Text Label 1500 7100 0    50   ~ 0
A11
Text Label 1500 7200 0    50   ~ 0
A12
Text Label 1500 7300 0    50   ~ 0
A13
Text Label 1500 7400 0    50   ~ 0
A14
Text Label 1500 7500 0    50   ~ 0
A15
Text Label 1500 7600 0    50   ~ 0
~RESET
Text Label 1500 8200 0    50   ~ 0
GND
Text Label 1500 8300 0    50   ~ 0
GND
Wire Wire Line
	800  6700 1000 6700
Wire Wire Line
	800  6600 1000 6600
Wire Wire Line
	800  6500 1000 6500
Wire Wire Line
	800  6400 1000 6400
Wire Wire Line
	800  6300 1000 6300
Wire Wire Line
	800  6200 1000 6200
Wire Wire Line
	800  6100 1000 6100
Wire Wire Line
	800  6000 1000 6000
Wire Wire Line
	800  7000 1000 7000
Wire Wire Line
	800  7100 1000 7100
Wire Wire Line
	800  7200 1000 7200
Wire Wire Line
	800  7300 1000 7300
Wire Wire Line
	800  7400 1000 7400
Wire Wire Line
	800  7500 1000 7500
Wire Wire Line
	1500 7200 1650 7200
Wire Wire Line
	800  7600 1000 7600
Wire Wire Line
	800  7700 1000 7700
Wire Wire Line
	1500 7600 1650 7600
Wire Wire Line
	800  7900 1000 7900
Wire Wire Line
	800  7800 1000 7800
Wire Wire Line
	1500 7500 1650 7500
Wire Wire Line
	1500 7300 1650 7300
Wire Wire Line
	1500 7400 1650 7400
Wire Wire Line
	1500 6800 1650 6800
Wire Wire Line
	1500 6900 1650 6900
Wire Wire Line
	1500 7000 1650 7000
Wire Wire Line
	1500 7100 1650 7100
Wire Wire Line
	1500 8200 1650 8200
Wire Wire Line
	1500 8300 1650 8300
Wire Wire Line
	800  5900 1000 5900
Wire Wire Line
	800  6900 1000 6900
Wire Wire Line
	800  6800 1000 6800
Wire Wire Line
	1500 6400 1650 6400
NoConn ~ 4800 7950
Wire Wire Line
	4050 7950 4050 8550
$Comp
L power:GND #PWR04
U 1 1 641869BE
P 4050 8550
F 0 "#PWR04" H 4050 8300 50  0001 C CNN
F 1 "GND" H 4055 8377 50  0000 C CNN
F 2 "" H 4050 8550 50  0001 C CNN
F 3 "" H 4050 8550 50  0001 C CNN
	1    4050 8550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 7950 4050 7950
Wire Wire Line
	6950 5750 4600 5750
$Comp
L 74xx:74LS04 U1
U 5 1 63D917E4
P 4500 7950
F 0 "U1" H 4500 8267 50  0000 C CNN
F 1 "74LS04" H 4500 8176 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4500 7950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 4500 7950 50  0001 C CNN
	5    4500 7950
	1    0    0    -1  
$EndComp
Text Label 2650 1200 0    50   ~ 0
+12V
Wire Wire Line
	2650 1200 2800 1200
Text Label 2650 1300 0    50   ~ 0
-12V
Wire Wire Line
	2650 1300 2800 1300
Text Label 2650 1400 0    50   ~ 0
~ROMDS0
Wire Wire Line
	2650 1400 2800 1400
Text Label 2650 1500 0    50   ~ 0
~ROMDS1
Wire Wire Line
	2650 1500 2800 1500
Text Label 2650 1600 0    50   ~ 0
~ROMDS2
Wire Wire Line
	2650 1600 2800 1600
Text Label 2650 1800 0    50   ~ 0
~INT
Wire Wire Line
	2650 1800 2800 1800
Text Label 2650 1900 0    50   ~ 0
~NMI
Wire Wire Line
	2650 1900 2800 1900
Text Label 2650 2000 0    50   ~ 0
~EXTON
Wire Wire Line
	2650 2000 2800 2000
Text Label 2650 3000 0    50   ~ 0
~WAIT
Wire Wire Line
	2650 3000 2800 3000
Text Label 2650 3100 0    50   ~ 0
~WE
Wire Wire Line
	2650 3100 2800 3100
Text Label 2650 3200 0    50   ~ 0
~MUX
Wire Wire Line
	2650 3200 2800 3200
Text Label 2650 3300 0    50   ~ 0
~RAS0
Wire Wire Line
	2650 3300 2800 3300
Text Label 2650 3400 0    50   ~ 0
~RAS1
Wire Wire Line
	2650 3400 2800 3400
Text Label 1950 3300 0    50   ~ 0
~RFSH
Wire Wire Line
	1950 3300 2150 3300
Text Label 1950 3400 0    50   ~ 0
~M1
Wire Wire Line
	1950 3400 2150 3400
Text Label 1950 3500 0    50   ~ 0
SCLOCK
Wire Wire Line
	1950 3500 2150 3500
Text Label 1950 3600 0    50   ~ 0
PHAI
Wire Wire Line
	1950 3600 2150 3600
Text Label 1150 3300 0    50   ~ 0
~RFSH
Wire Wire Line
	1150 3300 1350 3300
Text Label 1150 3400 0    50   ~ 0
~M1
Wire Wire Line
	1150 3400 1350 3400
Text Label 1150 3500 0    50   ~ 0
SCLOCK
Wire Wire Line
	1150 3500 1350 3500
Text Label 1150 3600 0    50   ~ 0
PHAI
Wire Wire Line
	1150 3600 1350 3600
Text Label 800  8000 0    50   ~ 0
~RFSH
Wire Wire Line
	800  8000 1000 8000
Text Label 800  8100 0    50   ~ 0
~M1
Wire Wire Line
	800  8100 1000 8100
Text Label 800  8200 0    50   ~ 0
SCLOCK
Wire Wire Line
	800  8200 1000 8200
Text Label 800  8300 0    50   ~ 0
PHAI
Wire Wire Line
	800  8300 1000 8300
Text Label 1500 5900 0    50   ~ 0
+12V
Wire Wire Line
	1500 5900 1650 5900
Text Label 1500 6000 0    50   ~ 0
-12V
Wire Wire Line
	1500 6000 1650 6000
Text Label 1500 6100 0    50   ~ 0
~ROMDS0
Wire Wire Line
	1500 6100 1650 6100
Text Label 1500 6200 0    50   ~ 0
~ROMDS1
Wire Wire Line
	1500 6200 1650 6200
Text Label 1500 6300 0    50   ~ 0
~ROMDS2
Wire Wire Line
	1500 6300 1650 6300
Text Label 1500 6500 0    50   ~ 0
~INT
Wire Wire Line
	1500 6500 1650 6500
Text Label 1500 6600 0    50   ~ 0
~NMI
Wire Wire Line
	1500 6600 1650 6600
Text Label 1500 6700 0    50   ~ 0
~EXTON
Wire Wire Line
	1500 6700 1650 6700
Text Label 1500 7700 0    50   ~ 0
~WAIT
Wire Wire Line
	1500 7700 1650 7700
Text Label 1500 7800 0    50   ~ 0
~WE
Wire Wire Line
	1500 7800 1650 7800
Text Label 1500 7900 0    50   ~ 0
~MUX
Wire Wire Line
	1500 7900 1650 7900
Text Label 1500 8000 0    50   ~ 0
~RAS0
Wire Wire Line
	1500 8000 1650 8000
Text Label 1500 8100 0    50   ~ 0
~RAS1
Wire Wire Line
	1500 8100 1650 8100
$EndSCHEMATC
