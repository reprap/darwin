;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.7.4 #4943 (Oct 27 2007) (UNIX)
; This file was generated Fri Jun 13 14:34:04 2008
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.module extruder2
	list	p=16f648a
	radix dec
	include "p16f648a.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_flashLED
	extern	_LEDon
	extern	_setFlash
	extern	_uartTransmit
	extern	_sendReply
	extern	_sendMessage
	extern	_sendDataByte
	extern	_endMessage
	extern	_sendMessageISR
	extern	_sendDataByteISR
	extern	_endMessageISR
	extern	_releaseLock
	extern	_serialInterruptHandler
	extern	_packetReady
	extern	_uartNotifyReceive
	extern	_serial_init
	extern	_delay_10us
	extern	_clearwdt
	extern	_CCP1CON_bits
	extern	_CMCON_bits
	extern	_EECON1_bits
	extern	_INTCON_bits
	extern	_OPTION_REG_bits
	extern	_PCON_bits
	extern	_PIE1_bits
	extern	_PIR1_bits
	extern	_PORTA_bits
	extern	_PORTB_bits
	extern	_RCSTA_bits
	extern	_STATUS_bits
	extern	_T1CON_bits
	extern	_T2CON_bits
	extern	_TRISA_bits
	extern	_TRISB_bits
	extern	_TXSTA_bits
	extern	_VRCON_bits
	extern	_buffer
	extern	_serialStatus
	extern	_INDF
	extern	_TMR0
	extern	_PCL
	extern	_STATUS
	extern	_FSR
	extern	_PORTA
	extern	_PORTB
	extern	_PCLATH
	extern	_INTCON
	extern	_PIR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_T1CON
	extern	_TMR2
	extern	_T2CON
	extern	_CCPR1L
	extern	_CCPR1H
	extern	_CCP1CON
	extern	_RCSTA
	extern	_TXREG
	extern	_RCREG
	extern	_CMCON
	extern	_OPTION_REG
	extern	_TRISA
	extern	_TRISB
	extern	_PIE1
	extern	_PCON
	extern	_PR2
	extern	_TXSTA
	extern	_SPBRG
	extern	_EEDATA
	extern	_EEADR
	extern	_EECON1
	extern	_EECON2
	extern	_VRCON

	extern PSAVE
	extern SSAVE
	extern WSAVE
	extern STK12
	extern STK11
	extern STK10
	extern STK09
	extern STK08
	extern STK07
	extern STK06
	extern STK05
	extern STK04
	extern STK03
	extern STK02
	extern STK01
	extern STK00
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_processCommand
	global	_checkTemperature
	global	_motorTick
	global	_timerTick
	global	_init2
	global	_extruder_stop
	global	_extruder_forward
	global	_extruder_reverse
	global	_heater_off
	global	_heater_on
	global	_change_log
	global	_set_cooler
	global	_pwmSet
	global	_solenoid_delay
	global	_solenoid
	global	_dummy
	global	_PWMPeriod

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_extruder2_0	udata
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
r0x101A	res	1
r0x101B	res	1
r0x101C	res	1
r0x101D	res	1
r0x101E	res	1
r0x1018	res	1
r0x1019	res	1
_currentPosition	res	2
_seekPosition	res	2
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_extruder2_0	idata
_PWMPeriod
	db	0xff


ID_extruder2_1	idata
_currentDirection
	db	0x00


ID_extruder2_2	idata
_seekSpeed
	db	0x00


ID_extruder2_3	idata
_seekNotify
	db	0xff


ID_extruder2_4	idata
_lastPortB
	db	0x00


ID_extruder2_5	idata
_lastPortA
	db	0x00


ID_extruder2_6	idata
_extrude_click
	db	0x00


ID_extruder2_7	idata
_material_click
	db	0x00


ID_extruder2_8	idata
_requestedHeat0
	db	0x00


ID_extruder2_9	idata
_requestedHeat1
	db	0x00


ID_extruder2_10	idata
_heatCounter
	db	0x00


ID_extruder2_11	idata
_pulseCounter1
	db	0x64


ID_extruder2_12	idata
_pulseCounter2
	db	0x14


ID_extruder2_13	idata
_solenoid_on
	db	0x00


ID_extruder2_14	idata
_temperatureLimit0
	db	0x00


ID_extruder2_15	idata
_temperatureLimit1
	db	0x00


ID_extruder2_16	idata
_lastTemperature
	db	0x00


ID_extruder2_17	idata
_lastTemperatureRef
	db	0x00


ID_extruder2_18	idata
_temperatureVRef
	db	0x03


ID_extruder2_19	idata
_portaval
	db	0x00

;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_extruder2	code
;***
;  pBlock Stats: dbName = C
;***
;entry:  _dummy	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_dummy	;Function start
; 2 exit points
;	.line	695; "extruder2.c"	INTCON = 0;
	BANKSEL	_INTCON
	CLRF	_INTCON
	RETURN	
; exit point of _dummy

;***
;  pBlock Stats: dbName = C
;***
;entry:  _processCommand	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _solenoid
;   _solenoid
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _solenoid
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _set_cooler
;   _pwmSet
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _solenoid
;   _solenoid
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _solenoid
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _set_cooler
;   _pwmSet
;2 compiler assigned registers:
;   r0x1018
;   r0x1019
;; Starting pCode block
_processCommand	;Function start
; 2 exit points
;	.line	542; "extruder2.c"	switch(buffer[0]) {
	BANKSEL	_buffer
	MOVF	(_buffer + 0),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BTFSC	STATUS,2
	GOTO	_00204_DS_
	MOVF	r0x1018,W
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00216_DS_
	MOVF	r0x1018,W
	XORLW	0x02
	BTFSC	STATUS,2
	GOTO	_00217_DS_
	MOVF	r0x1018,W
	XORLW	0x03
	BTFSC	STATUS,2
	GOTO	_00218_DS_
	MOVF	r0x1018,W
	XORLW	0x04
	BTFSC	STATUS,2
	GOTO	_00219_DS_
	MOVF	r0x1018,W
	XORLW	0x05
	BTFSC	STATUS,2
	GOTO	_00220_DS_
	MOVF	r0x1018,W
	XORLW	0x06
	BTFSC	STATUS,2
	GOTO	_00221_DS_
	MOVF	r0x1018,W
	XORLW	0x07
	BTFSC	STATUS,2
	GOTO	_00222_DS_
	MOVF	r0x1018,W
	XORLW	0x08
	BTFSC	STATUS,2
	GOTO	_00223_DS_
	MOVF	r0x1018,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00224_DS_
	MOVF	r0x1018,W
	XORLW	0x0a
	BTFSC	STATUS,2
	GOTO	_00225_DS_
	MOVF	r0x1018,W
	XORLW	0x0b
	BTFSC	STATUS,2
	GOTO	_00226_DS_
	MOVF	r0x1018,W
	XORLW	0x32
	BTFSC	STATUS,2
	GOTO	_00230_DS_
	MOVF	r0x1018,W
	XORLW	0x33
	BTFSC	STATUS,2
	GOTO	_00231_DS_
	MOVF	r0x1018,W
	XORLW	0x34
	BTFSC	STATUS,2
	GOTO	_00232_DS_
	MOVF	r0x1018,W
	XORLW	0x35
	BTFSC	STATUS,2
	GOTO	_00233_DS_
	MOVF	r0x1018,W
	XORLW	0xfe
	BTFSC	STATUS,2
	GOTO	_00205_DS_
	MOVF	r0x1018,W
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00215_DS_
	GOTO	_00235_DS_
_00204_DS_
;	.line	544; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	545; "extruder2.c"	sendDataByte(CMD_VERSION);  // Response type 0
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	546; "extruder2.c"	sendDataByte(MAJOR_VERSION_NUMBER);
	MOVLW	0x01
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	547; "extruder2.c"	sendDataByte(MINOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	548; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	549; "extruder2.c"	break;
	GOTO	_00235_DS_
_00205_DS_
;	.line	552; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	553; "extruder2.c"	sendDataByte(CMD_CHECKHOSTVERSION);    
	MOVLW	0xfe
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	554; "extruder2.c"	if(buffer[1] > OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BTFSC	STATUS,2
	GOTO	_00213_DS_
;	.line	555; "extruder2.c"	sendDataByte(0xff);    
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00214_DS_
_00213_DS_
;	.line	556; "extruder2.c"	else if (buffer[1] == OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	MOVF	r0x1018,W
	BTFSS	STATUS,2
	GOTO	_00210_DS_
;	.line	558; "extruder2.c"	if (buffer[2] >= OLDHOST_MINOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
;unsigned compare: left < lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	r0x1018,W
	BTFSS	STATUS,0
	GOTO	_00207_DS_
;genSkipc:3694: created from rifx:0xbf9ff510
;	.line	559; "extruder2.c"	sendDataByte(0xff);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00214_DS_
_00207_DS_
;	.line	561; "extruder2.c"	sendDataByte(0);    
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00214_DS_
_00210_DS_
;	.line	563; "extruder2.c"	sendDataByte(0);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
_00214_DS_
;	.line	564; "extruder2.c"	sendDataByte(OLDHOST_MAJOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	565; "extruder2.c"	sendDataByte(OLDHOST_MINOR_VERSION_NUMBER);
	MOVLW	0x08
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	566; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	567; "extruder2.c"	break;    
	GOTO	_00235_DS_
_00215_DS_
;	.line	570; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	571; "extruder2.c"	sendDataByte(CMD_GETMODULETYPE);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	572; "extruder2.c"	sendDataByte(SUPPORT_EXTRUDER_TYPE);
	MOVLW	0x02
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	573; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	574; "extruder2.c"	break;
	GOTO	_00235_DS_
_00216_DS_
;	.line	578; "extruder2.c"	solenoid(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	CALL	_solenoid
;	.line	581; "extruder2.c"	break;
	GOTO	_00235_DS_
_00217_DS_
;	.line	586; "extruder2.c"	solenoid(0);
	MOVLW	0x00
	CALL	_solenoid
;	.line	587; "extruder2.c"	break;
	GOTO	_00235_DS_
_00218_DS_
;	.line	591; "extruder2.c"	currentPosition.bytes[0] = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;	.line	592; "extruder2.c"	currentPosition.bytes[1] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
;	.line	593; "extruder2.c"	break;
	GOTO	_00235_DS_
_00219_DS_
;	.line	597; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	598; "extruder2.c"	sendDataByte(CMD_GETPOS);
	MOVLW	0x04
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	599; "extruder2.c"	sendDataByte(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	600; "extruder2.c"	sendDataByte(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	601; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	602; "extruder2.c"	break;
	GOTO	_00235_DS_
_00220_DS_
;	.line	606; "extruder2.c"	seekPosition.bytes[0] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 0)
;	.line	607; "extruder2.c"	seekPosition.bytes[1] = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 1)
;	.line	617; "extruder2.c"	break;
	GOTO	_00235_DS_
_00221_DS_
;	.line	623; "extruder2.c"	solenoid(0);
	MOVLW	0x00
	CALL	_solenoid
;	.line	624; "extruder2.c"	break;
	GOTO	_00235_DS_
_00222_DS_
;	.line	628; "extruder2.c"	seekNotify = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;	.line	629; "extruder2.c"	break;
	GOTO	_00235_DS_
_00223_DS_
;	.line	632; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	633; "extruder2.c"	sendDataByte(CMD_ISEMPTY);
	MOVLW	0x08
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	635; "extruder2.c"	sendDataByte(!RA5);   
	BANKSEL	r0x1018
	CLRF	r0x1018
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00001_DS_
	BANKSEL	r0x1018
	INCF	r0x1018,F
_00001_DS_
	BANKSEL	r0x1018
	MOVF	r0x1018,W
	MOVLW	0x00
	BTFSC	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1019
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	639; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	640; "extruder2.c"	break;
	GOTO	_00235_DS_
_00224_DS_
;	.line	643; "extruder2.c"	requestedHeat0 = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_requestedHeat0
	MOVWF	_requestedHeat0
;	.line	644; "extruder2.c"	requestedHeat1 = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	_requestedHeat1
	MOVWF	_requestedHeat1
;	.line	645; "extruder2.c"	temperatureLimit0 = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	_temperatureLimit0
	MOVWF	_temperatureLimit0
;	.line	646; "extruder2.c"	temperatureLimit1 = buffer[4];
	BANKSEL	_buffer
	MOVF	(_buffer + 4),W
	BANKSEL	_temperatureLimit1
	MOVWF	_temperatureLimit1
;	.line	647; "extruder2.c"	break;
	GOTO	_00235_DS_
_00225_DS_
;	.line	650; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	651; "extruder2.c"	sendDataByte(CMD_GETTEMP);
	MOVLW	0x0a
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	652; "extruder2.c"	sendDataByte(lastTemperature);
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	653; "extruder2.c"	sendDataByte(lastTemperatureRef);
	BANKSEL	_lastTemperatureRef
	MOVF	_lastTemperatureRef,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	654; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	655; "extruder2.c"	break;
	GOTO	_00235_DS_
_00226_DS_
;	.line	658; "extruder2.c"	set_cooler(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	CALL	_set_cooler
;	.line	660; "extruder2.c"	if(buffer[1] && !seekSpeed)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BTFSC	STATUS,2
	GOTO	_00235_DS_
	BANKSEL	_seekSpeed
	MOVF	_seekSpeed,W
	BTFSS	STATUS,2
	GOTO	_00235_DS_
;	.line	662; "extruder2.c"	seekSpeed = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekSpeed
	MOVWF	_seekSpeed
;	.line	663; "extruder2.c"	pwmSet();
	CALL	_pwmSet
;	.line	666; "extruder2.c"	break;
	GOTO	_00235_DS_
_00230_DS_
;	.line	671; "extruder2.c"	PWMPeriod = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_PWMPeriod
	MOVWF	_PWMPeriod
;	.line	672; "extruder2.c"	PR2 = PWMPeriod;
	MOVF	_PWMPeriod,W
	BANKSEL	_PR2
	MOVWF	_PR2
;	.line	673; "extruder2.c"	break;
	GOTO	_00235_DS_
_00231_DS_
;	.line	677; "extruder2.c"	T2CON = BIN(00000100) | (buffer[1] & 3);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	MOVLW	0x03
	ANDWF	r0x1018,F
	MOVLW	0x04
	IORWF	r0x1018,W
	BANKSEL	_T2CON
	MOVWF	_T2CON
;	.line	678; "extruder2.c"	break;
	GOTO	_00235_DS_
_00232_DS_
;	.line	681; "extruder2.c"	temperatureVRef = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_temperatureVRef
	MOVWF	_temperatureVRef
;	.line	682; "extruder2.c"	break;
	GOTO	_00235_DS_
_00233_DS_
;	.line	685; "extruder2.c"	OPTION_REG = (OPTION_REG & BIN(11111000)) | (buffer[1] & BIN(111));
	MOVLW	0xf8
	BANKSEL	_OPTION_REG
	ANDWF	_OPTION_REG,W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	0x07
	ANDWF	r0x1019,F
	MOVF	r0x1019,W
	IORWF	r0x1018,W
	BANKSEL	_OPTION_REG
	MOVWF	_OPTION_REG
_00235_DS_
;	.line	688; "extruder2.c"	}
	RETURN	
; exit point of _processCommand

;***
;  pBlock Stats: dbName = C
;***
;entry:  _checkTemperature	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_checkTemperature	;Function start
; 2 exit points
	BANKSEL _currentPosition
	RETURN	
; exit point of _checkTemperature

;***
;  pBlock Stats: dbName = C
;***
;entry:  _motorTick	;Function start
; 2 exit points
;has an exit
;functions called:
;   _change_log
;   _extruder_stop
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _change_log
;   _extruder_stop
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;4 compiler assigned registers:
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;; Starting pCode block
_motorTick	;Function start
; 2 exit points
;	.line	402; "extruder2.c"	RBIF = 0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,0
;	.line	404; "extruder2.c"	change_log();
	CALL	_change_log
;	.line	406; "extruder2.c"	if (extrude_click) {
	BANKSEL	_extrude_click
	MOVF	_extrude_click,W
	BTFSC	STATUS,2
	GOTO	_00191_DS_
;	.line	409; "extruder2.c"	if (currentDirection)
	BANKSEL	_currentDirection
	MOVF	_currentDirection,W
	BTFSC	STATUS,2
	GOTO	_00185_DS_
;	.line	410; "extruder2.c"	currentPosition.ival--;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	MOVLW	0xff
	ADDWF	r0x101B,F
	BTFSS	STATUS,0
	DECF	r0x101C,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x101B,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x101C
	MOVF	r0x101C,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
	GOTO	_00186_DS_
_00185_DS_
;	.line	412; "extruder2.c"	currentPosition.ival++;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	INCF	r0x101B,F
	BTFSC	STATUS,2
	INCF	r0x101C,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x101B,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x101C
	MOVF	r0x101C,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
_00186_DS_
;	.line	414; "extruder2.c"	if (seekSpeed != 0 && currentPosition.ival == seekPosition.ival) {
	MOVLW	0x00
	BANKSEL	_seekSpeed
	IORWF	_seekSpeed,W
	BTFSC	STATUS,2
	GOTO	_00191_DS_
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x101E
	MOVWF	r0x101E
	MOVF	r0x101D,W
	XORWF	r0x101B,W
	BTFSS	STATUS,2
	GOTO	_00191_DS_
	MOVF	r0x101E,W
;	.line	416; "extruder2.c"	extruder_stop();
	XORWF	r0x101C,W
;	.line	419; "extruder2.c"	if (material_click) {
	BTFSC	STATUS,2
	CALL	_extruder_stop
_00191_DS_
	MOVLW	0x00
	BANKSEL	_material_click
	IORWF	_material_click,W
	BTFSC	STATUS,2
	GOTO	_00195_DS_
;	.line	420; "extruder2.c"	if (sendMessageISR(seekNotify)) { //TODO: if sending is not possible, what todo?
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x101B
	MOVWF	r0x101B
	MOVF	r0x101B,W
	BTFSC	STATUS,2
	GOTO	_00195_DS_
;	.line	421; "extruder2.c"	sendDataByteISR(CMD_ISEMPTY);
	MOVLW	0x08
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	422; "extruder2.c"	sendDataByteISR(1);
	MOVLW	0x01
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	423; "extruder2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
_00195_DS_
	BANKSEL _currentPosition
	
	RETURN	
; exit point of _motorTick

;***
;  pBlock Stats: dbName = C
;***
;entry:  _timerTick	;Function start
; 2 exit points
;has an exit
;functions called:
;   _extruder_stop
;   _extruder_stop
;; Starting pCode block
_timerTick	;Function start
; 2 exit points
;	.line	369; "extruder2.c"	if(solenoid_on)
	BANKSEL	_solenoid_on
	MOVF	_solenoid_on,W
	BTFSC	STATUS,2
	GOTO	_00179_DS_
;	.line	371; "extruder2.c"	if(pulseCounter2 == 0)
	BANKSEL	_pulseCounter2
	MOVF	_pulseCounter2,W
	BTFSS	STATUS,2
	GOTO	_00176_DS_
;	.line	373; "extruder2.c"	if(pulseCounter1 == 0)
	BANKSEL	_pulseCounter1
	MOVF	_pulseCounter1,W
	BTFSS	STATUS,2
	GOTO	_00173_DS_
;	.line	375; "extruder2.c"	extruder_stop();
	CALL	_extruder_stop
;	.line	376; "extruder2.c"	solenoid_on = 0;
	BANKSEL	_solenoid_on
	CLRF	_solenoid_on
	GOTO	_00179_DS_
_00173_DS_
;	.line	379; "extruder2.c"	pulseCounter1--;
	BANKSEL	_pulseCounter1
	DECF	_pulseCounter1,F
;	.line	380; "extruder2.c"	pulseCounter2 = PC2;
	MOVLW	0x14
	BANKSEL	_pulseCounter2
	MOVWF	_pulseCounter2
	GOTO	_00179_DS_
_00176_DS_
;	.line	383; "extruder2.c"	pulseCounter2--;
	BANKSEL	_pulseCounter2
	DECF	_pulseCounter2,F
_00179_DS_
;	.line	386; "extruder2.c"	heatCounter++;
	BANKSEL	_heatCounter
	INCF	_heatCounter,F
;	.line	387; "extruder2.c"	TMR1H = HEATER_PWM_PERIOD;
	MOVLW	0xff
	BANKSEL	_TMR1H
	MOVWF	_TMR1H
;	.line	388; "extruder2.c"	TMR1L = 0;
	CLRF	_TMR1L
	BANKSEL _currentPosition
	RETURN	
; exit point of _timerTick

;***
;  pBlock Stats: dbName = C
;***
;entry:  _solenoid	;Function start
; 2 exit points
;has an exit
;functions called:
;   _extruder_forward
;   _extruder_reverse
;   _solenoid_delay
;   _extruder_forward
;   _extruder_reverse
;   _solenoid_delay
;1 compiler assigned register :
;   r0x101A
;; Starting pCode block
_solenoid	;Function start
; 2 exit points
;	.line	308; "extruder2.c"	void solenoid(byte on)
	BANKSEL	r0x101A
	MOVWF	r0x101A
;	.line	310; "extruder2.c"	if(on)
	MOVF	r0x101A,W
	BTFSC	STATUS,2
	GOTO	_00166_DS_
;	.line	311; "extruder2.c"	extruder_forward();
	CALL	_extruder_forward
	GOTO	_00167_DS_
_00166_DS_
;	.line	313; "extruder2.c"	extruder_reverse();
	CALL	_extruder_reverse
_00167_DS_
;	.line	314; "extruder2.c"	solenoid_delay();
	CALL	_solenoid_delay
	RETURN	
; exit point of _solenoid

;***
;  pBlock Stats: dbName = C
;***
;entry:  _solenoid_delay	;Function start
; 2 exit points
;has an exit
;functions called:
;   _pwmSet
;   _pwmSet
;; Starting pCode block
_solenoid_delay	;Function start
; 2 exit points
;	.line	297; "extruder2.c"	pwmSet();
	CALL	_pwmSet
;	.line	298; "extruder2.c"	pulseCounter1 = PC1;
	MOVLW	0x64
	BANKSEL	_pulseCounter1
	MOVWF	_pulseCounter1
;	.line	299; "extruder2.c"	pulseCounter2 = PC2; 
	MOVLW	0x14
	BANKSEL	_pulseCounter2
	MOVWF	_pulseCounter2
;	.line	300; "extruder2.c"	solenoid_on = 1;
	MOVLW	0x01
	BANKSEL	_solenoid_on
	MOVWF	_solenoid_on
	RETURN	
; exit point of _solenoid_delay

;***
;  pBlock Stats: dbName = C
;***
;entry:  _pwmSet	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_pwmSet	;Function start
; 2 exit points
;	.line	271; "extruder2.c"	CCP1CON = BIN(00111100);
	MOVLW	0x3c
	BANKSEL	_CCP1CON
	MOVWF	_CCP1CON
;	.line	273; "extruder2.c"	CCPR1L = 255;
	MOVLW	0xff
	MOVWF	_CCPR1L
;	.line	275; "extruder2.c"	PR2 = 0;
	BANKSEL	_PR2
	CLRF	_PR2
	RETURN	
; exit point of _pwmSet

;***
;  pBlock Stats: dbName = C
;***
;entry:  _init2	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_init2	;Function start
; 2 exit points
;	.line	244; "extruder2.c"	PWMPeriod = 255;
	MOVLW	0xff
	BANKSEL	_PWMPeriod
	MOVWF	_PWMPeriod
;	.line	245; "extruder2.c"	currentDirection = 0;
	BANKSEL	_currentDirection
	CLRF	_currentDirection
;	.line	246; "extruder2.c"	seekSpeed = 0;
	BANKSEL	_seekSpeed
	CLRF	_seekSpeed
;	.line	247; "extruder2.c"	seekNotify = 255;
	MOVLW	0xff
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;	.line	248; "extruder2.c"	lastPortB = 0;
	BANKSEL	_lastPortB
	CLRF	_lastPortB
;	.line	249; "extruder2.c"	lastPortA = 0;
	BANKSEL	_lastPortA
	CLRF	_lastPortA
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	250; "extruder2.c"	currentPosition.bytes[0] = 0;
	BANKSEL	_currentPosition
	CLRF	(_currentPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	251; "extruder2.c"	currentPosition.bytes[1] = 0;
	CLRF	(_currentPosition + 1)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	252; "extruder2.c"	seekPosition.bytes[0] = 0;
	BANKSEL	_seekPosition
	CLRF	(_seekPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	253; "extruder2.c"	seekPosition.bytes[1] = 0;
	CLRF	(_seekPosition + 1)
;	.line	254; "extruder2.c"	requestedHeat0 = 0;
	BANKSEL	_requestedHeat0
	CLRF	_requestedHeat0
;	.line	255; "extruder2.c"	requestedHeat1 = 0;
	BANKSEL	_requestedHeat1
	CLRF	_requestedHeat1
;	.line	256; "extruder2.c"	heatCounter = 0;
	BANKSEL	_heatCounter
	CLRF	_heatCounter
;	.line	257; "extruder2.c"	lastTemperature = 0;
	BANKSEL	_lastTemperature
	CLRF	_lastTemperature
;	.line	258; "extruder2.c"	lastTemperatureRef = 0;
	BANKSEL	_lastTemperatureRef
	CLRF	_lastTemperatureRef
;	.line	259; "extruder2.c"	temperatureVRef = 3;
	MOVLW	0x03
	BANKSEL	_temperatureVRef
	MOVWF	_temperatureVRef
;	.line	260; "extruder2.c"	portaval = 0;
	BANKSEL	_portaval
	CLRF	_portaval
;	.line	261; "extruder2.c"	solenoid_on = 0;
	BANKSEL	_solenoid_on
	CLRF	_solenoid_on
;	.line	262; "extruder2.c"	PORTA = portaval;
	BANKSEL	_PORTA
	CLRF	_PORTA
;	.line	263; "extruder2.c"	TMR1H = HEATER_PWM_PERIOD;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	264; "extruder2.c"	TMR1L = 0;
	CLRF	_TMR1L
	RETURN	
; exit point of _init2

;***
;  pBlock Stats: dbName = C
;***
;entry:  _set_cooler	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x101A
;; Starting pCode block
_set_cooler	;Function start
; 2 exit points
;	.line	166; "extruder2.c"	void set_cooler(byte b)
	BANKSEL	r0x101A
	MOVWF	r0x101A
;	.line	168; "extruder2.c"	if (b)
	MOVF	r0x101A,W
	BTFSC	STATUS,2
	GOTO	_00147_DS_
;	.line	169; "extruder2.c"	portaval |= BIN(00000001);
	BANKSEL	_portaval
	BSF	_portaval,0
	GOTO	_00148_DS_
_00147_DS_
;	.line	171; "extruder2.c"	portaval &= BIN(11111110);
	BANKSEL	_portaval
	BCF	_portaval,0
_00148_DS_
;	.line	172; "extruder2.c"	PORTA = portaval;
	BANKSEL	_portaval
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
	RETURN	
; exit point of _set_cooler

;***
;  pBlock Stats: dbName = C
;***
;entry:  _change_log	;Function start
; 2 exit points
;has an exit
;3 compiler assigned registers:
;   r0x101F
;   r0x1020
;   r0x1021
;; Starting pCode block
_change_log	;Function start
; 2 exit points
;	.line	141; "extruder2.c"	extrude_click = 0;
	BANKSEL	_extrude_click
	CLRF	_extrude_click
;	.line	142; "extruder2.c"	material_click = 0;
	BANKSEL	_material_click
	CLRF	_material_click
;	.line	143; "extruder2.c"	current = RB1;  // Store so it doesn't change half way through processing
	BANKSEL	r0x101F
	CLRF	r0x101F
	BANKSEL	_PORTB_bits
	BTFSS	_PORTB_bits,1
	GOTO	_00002_DS_
	BANKSEL	r0x101F
	INCF	r0x101F,F
_00002_DS_
;	.line	144; "extruder2.c"	changes = lastPortB ^ current;
	BANKSEL	_lastPortB
	MOVF	_lastPortB,W
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	r0x101F,W
	XORWF	r0x1020,F
;	.line	146; "extruder2.c"	if (changes) {
	MOVF	r0x1020,W
	BTFSC	STATUS,2
	GOTO	_00128_DS_
;	.line	148; "extruder2.c"	if (current) {
	MOVF	r0x101F,W
	BTFSC	STATUS,2
	GOTO	_00128_DS_
;	.line	149; "extruder2.c"	extrude_click = 1;
	MOVLW	0x01
	BANKSEL	_extrude_click
	MOVWF	_extrude_click
_00128_DS_
;	.line	152; "extruder2.c"	lastPortB = current;
	BANKSEL	r0x101F
	MOVF	r0x101F,W
	BANKSEL	_lastPortB
	MOVWF	_lastPortB
;	.line	154; "extruder2.c"	current = RA5;  // Store so it doesn't change half way through processing
	BANKSEL	r0x1021
	CLRF	r0x1021
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00003_DS_
	BANKSEL	r0x1021
	INCF	r0x1021,F
_00003_DS_
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	r0x101F
;	.line	155; "extruder2.c"	changes = lastPortA ^ current;  
	BANKSEL	_lastPortA
	MOVF	_lastPortA,W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	XORWF	r0x101F,W
	MOVWF	r0x1020
;	.line	156; "extruder2.c"	if (changes) {
	MOVF	r0x1020,W
	BTFSC	STATUS,2
	GOTO	_00133_DS_
;	.line	158; "extruder2.c"	if (!current && seekNotify != 255) {
	MOVF	r0x101F,W
	BTFSS	STATUS,2
	GOTO	_00133_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	159; "extruder2.c"	material_click = 1;
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00133_DS_
	MOVLW	0x01
	BANKSEL	_material_click
	MOVWF	_material_click
_00133_DS_
;	.line	162; "extruder2.c"	lastPortA = current;
	BANKSEL	r0x101F
	MOVF	r0x101F,W
	BANKSEL	_lastPortA
	MOVWF	_lastPortA
	RETURN	
; exit point of _change_log

;***
;  pBlock Stats: dbName = C
;***
;entry:  _heater_on	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_heater_on	;Function start
; 2 exit points
;	.line	132; "extruder2.c"	portaval |= BIN(00001000);
	BANKSEL	_portaval
	BSF	_portaval,3
;	.line	133; "extruder2.c"	PORTA = portaval;
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
	RETURN	
; exit point of _heater_on

;***
;  pBlock Stats: dbName = C
;***
;entry:  _heater_off	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_heater_off	;Function start
; 2 exit points
;	.line	127; "extruder2.c"	portaval &= BIN(11110111);
	BANKSEL	_portaval
	BCF	_portaval,3
;	.line	128; "extruder2.c"	PORTA = portaval;
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
	RETURN	
; exit point of _heater_off

;***
;  pBlock Stats: dbName = C
;***
;entry:  _extruder_reverse	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_extruder_reverse	;Function start
; 2 exit points
;	.line	122; "extruder2.c"	RB4 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,4
;	.line	123; "extruder2.c"	RB5 = 1;
	BSF	_PORTB_bits,5
	RETURN	
; exit point of _extruder_reverse

;***
;  pBlock Stats: dbName = C
;***
;entry:  _extruder_forward	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_extruder_forward	;Function start
; 2 exit points
;	.line	117; "extruder2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	118; "extruder2.c"	RB4 = 1;
	BSF	_PORTB_bits,4
	RETURN	
; exit point of _extruder_forward

;***
;  pBlock Stats: dbName = C
;***
;entry:  _extruder_stop	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_extruder_stop	;Function start
; 2 exit points
;	.line	112; "extruder2.c"	RB4 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,4
;	.line	113; "extruder2.c"	RB5 = 0;
	BCF	_PORTB_bits,5
	RETURN	
; exit point of _extruder_stop


;	code size estimation:
;	  450+  228 =   678 instructions ( 1812 byte)

	end
