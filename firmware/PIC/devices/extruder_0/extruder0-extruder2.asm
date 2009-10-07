;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.7.4 #4943 (Oct 27 2007) (UNIX)
; This file was generated Fri Jun 13 14:34:03 2008
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
	extern	_interruptTemp
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
	global	_pwmSet
	global	_init2
	global	_extruder_stop
	global	_extruder_forward
	global	_extruder_reverse
	global	_heater_off
	global	_heater_on
	global	_change_log
	global	_set_cooler
	global	_solenoid_delay
	global	_solenoid
	global	_setSpeed
	global	_dummy
	global	_PWMPeriod

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_extruder2_0	udata
_PWMPeriod	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_extruder2_0	udata
r0x1026	res	1
r0x1027	res	1
r0x101E	res	1
r0x101F	res	1
r0x1022	res	1
r0x1023	res	1
r0x1024	res	1
r0x1025	res	1
r0x1020	res	1
r0x1021	res	1
r0x1019	res	1
r0x101A	res	1
r0x101B	res	1
r0x101C	res	1
r0x101D	res	1
_portaval	res	1
_extrude_click	res	1
_material_click	res	1
_lastPortA	res	1
_seekNotify	res	1
_currentDirection	res	1
_seekSpeed	res	1
_lastPortB	res	1
_requestedHeat0	res	1
_requestedHeat1	res	1
_temperatureLimit0	res	1
_temperatureLimit1	res	1
_heatCounter	res	1
_lastTemperature	res	1
_temperatureVRef	res	1
_temperatureNotUpdatedCounter	res	1
_currentPosition	res	2
_seekPosition	res	2
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_extruder2_0	idata
_pulseCounter1
	db	0x64


ID_extruder2_1	idata
_pulseCounter2
	db	0x14


ID_extruder2_2	idata
_solenoid_on
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
;	.line	764; "extruder2.c"	INTCON = 0;
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
;   _setSpeed
;   _setSpeed
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setSpeed
;   _setSpeed
;   _extruder_stop
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
;   _sendReply
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
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
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
;   _setSpeed
;   _setSpeed
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setSpeed
;   _setSpeed
;   _extruder_stop
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
;   _sendReply
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
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _solenoid
;   _solenoid
;5 compiler assigned registers:
;   r0x1019
;   r0x101A
;   r0x101B
;   r0x101C
;   r0x101D
;; Starting pCode block
_processCommand	;Function start
; 2 exit points
;	.line	574; "extruder2.c"	switch(buffer[0]) {
	BANKSEL	_buffer
	MOVF	(_buffer + 0),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BTFSC	STATUS,2
	GOTO	_00273_DS_
	MOVF	r0x1019,W
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00285_DS_
	MOVF	r0x1019,W
	XORLW	0x02
	BTFSC	STATUS,2
	GOTO	_00286_DS_
	MOVF	r0x1019,W
	XORLW	0x03
	BTFSC	STATUS,2
	GOTO	_00287_DS_
	MOVF	r0x1019,W
	XORLW	0x04
	BTFSC	STATUS,2
	GOTO	_00288_DS_
	MOVF	r0x1019,W
	XORLW	0x05
	BTFSC	STATUS,2
	GOTO	_00289_DS_
	MOVF	r0x1019,W
	XORLW	0x06
	BTFSC	STATUS,2
	GOTO	_00295_DS_
	MOVF	r0x1019,W
	XORLW	0x07
	BTFSC	STATUS,2
	GOTO	_00296_DS_
	MOVF	r0x1019,W
	XORLW	0x08
	BTFSC	STATUS,2
	GOTO	_00297_DS_
	MOVF	r0x1019,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00298_DS_
	MOVF	r0x1019,W
	XORLW	0x0a
	BTFSC	STATUS,2
	GOTO	_00299_DS_
	MOVF	r0x1019,W
	XORLW	0x0b
	BTFSC	STATUS,2
	GOTO	_00300_DS_
	MOVF	r0x1019,W
	XORLW	0x0c
	BTFSC	STATUS,2
	GOTO	_00307_DS_
	MOVF	r0x1019,W
	XORLW	0x0d
	BTFSC	STATUS,2
	GOTO	_00308_DS_
	MOVF	r0x1019,W
	XORLW	0x32
	BTFSC	STATUS,2
	GOTO	_00301_DS_
	MOVF	r0x1019,W
	XORLW	0x33
	BTFSC	STATUS,2
	GOTO	_00302_DS_
	MOVF	r0x1019,W
	XORLW	0x34
	BTFSC	STATUS,2
	GOTO	_00303_DS_
	MOVF	r0x1019,W
	XORLW	0x35
	BTFSC	STATUS,2
	GOTO	_00304_DS_
	MOVF	r0x1019,W
	XORLW	0x36
	BTFSC	STATUS,2
	GOTO	_00305_DS_
	MOVF	r0x1019,W
	XORLW	0x37
	BTFSC	STATUS,2
	GOTO	_00306_DS_
	MOVF	r0x1019,W
	XORLW	0xfe
	BTFSC	STATUS,2
	GOTO	_00274_DS_
	MOVF	r0x1019,W
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00284_DS_
	GOTO	_00309_DS_
_00273_DS_
;	.line	576; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	577; "extruder2.c"	sendDataByte(CMD_VERSION);  // Response type 0
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	578; "extruder2.c"	sendDataByte(MAJOR_VERSION_NUMBER);
	MOVLW	0x01
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	579; "extruder2.c"	sendDataByte(MINOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	580; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	581; "extruder2.c"	break;
	GOTO	_00309_DS_
_00274_DS_
;	.line	584; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	585; "extruder2.c"	sendDataByte(CMD_CHECKHOSTVERSION);    
	MOVLW	0xfe
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	586; "extruder2.c"	if(buffer[1] > OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BTFSC	STATUS,2
	GOTO	_00282_DS_
;	.line	587; "extruder2.c"	sendDataByte(0xff);    
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00283_DS_
_00282_DS_
;	.line	588; "extruder2.c"	else if (buffer[1] == OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVF	r0x1019,W
	BTFSS	STATUS,2
	GOTO	_00279_DS_
;	.line	590; "extruder2.c"	if (buffer[2] >= OLDHOST_MINOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
;unsigned compare: left < lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	r0x1019,W
	BTFSS	STATUS,0
	GOTO	_00276_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;	.line	591; "extruder2.c"	sendDataByte(0xff);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00283_DS_
_00276_DS_
;	.line	593; "extruder2.c"	sendDataByte(0);    
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00283_DS_
_00279_DS_
;	.line	595; "extruder2.c"	sendDataByte(0);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
_00283_DS_
;	.line	596; "extruder2.c"	sendDataByte(OLDHOST_MAJOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	597; "extruder2.c"	sendDataByte(OLDHOST_MINOR_VERSION_NUMBER);
	MOVLW	0x08
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	598; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	599; "extruder2.c"	break;    
	GOTO	_00309_DS_
_00284_DS_
;	.line	602; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	603; "extruder2.c"	sendDataByte(CMD_GETMODULETYPE);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	604; "extruder2.c"	sendDataByte(THERMOPLASTIC_EXTRUDER_TYPE);
	MOVLW	0x01
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	605; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	606; "extruder2.c"	break;
	GOTO	_00309_DS_
_00285_DS_
;	.line	610; "extruder2.c"	seekSpeed = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekSpeed
	MOVWF	_seekSpeed
;	.line	611; "extruder2.c"	setSpeed(0);
	MOVLW	0x00
	CALL	_setSpeed
;	.line	612; "extruder2.c"	break;
	GOTO	_00309_DS_
_00286_DS_
;	.line	615; "extruder2.c"	seekSpeed = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekSpeed
	MOVWF	_seekSpeed
;	.line	616; "extruder2.c"	setSpeed(1);
	MOVLW	0x01
	CALL	_setSpeed
;	.line	617; "extruder2.c"	break;
	GOTO	_00309_DS_
_00287_DS_
;	.line	621; "extruder2.c"	currentPosition.bytes[0] = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;	.line	622; "extruder2.c"	currentPosition.bytes[1] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
;	.line	623; "extruder2.c"	break;
	GOTO	_00309_DS_
_00288_DS_
;	.line	627; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	628; "extruder2.c"	sendDataByte(CMD_GETPOS);
	MOVLW	0x04
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	629; "extruder2.c"	sendDataByte(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	630; "extruder2.c"	sendDataByte(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	631; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	632; "extruder2.c"	break;
	GOTO	_00309_DS_
_00289_DS_
;	.line	636; "extruder2.c"	seekPosition.bytes[0] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 0)
;	.line	637; "extruder2.c"	seekPosition.bytes[1] = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 1)
;	.line	639; "extruder2.c"	if (seekPosition.ival != currentPosition.ival) {
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x101A
	MOVWF	r0x101A
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	MOVF	r0x101B,W
	XORWF	r0x1019,W
	BTFSS	STATUS,2
	GOTO	_00362_DS_
	MOVF	r0x101C,W
;	.line	640; "extruder2.c"	seekSpeed = buffer[1];
	XORWF	r0x101A,W
	BTFSC	STATUS,2
	GOTO	_00309_DS_
_00362_DS_
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekSpeed
	MOVWF	_seekSpeed
;	.line	641; "extruder2.c"	if (currentPosition.ival > seekPosition.ival)
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
;;100	MOVF	(_currentPosition + 1),W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	ADDLW	0x80
	MOVWF	r0x101D
;;99	MOVF	r0x101A,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101A
	MOVWF	r0x101A
	ADDLW	0x80
	SUBWF	r0x101D,W
	BTFSS	STATUS,2
	GOTO	_00363_DS_
	MOVF	r0x1019,W
	SUBWF	r0x101B,W
_00363_DS_
	BTFSC	STATUS,0
	GOTO	_00291_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;	.line	642; "extruder2.c"	setSpeed(1);
	MOVLW	0x01
	CALL	_setSpeed
	GOTO	_00309_DS_
_00291_DS_
;	.line	644; "extruder2.c"	setSpeed(0);
	MOVLW	0x00
	CALL	_setSpeed
;	.line	647; "extruder2.c"	break;
	GOTO	_00309_DS_
_00295_DS_
;	.line	652; "extruder2.c"	extruder_stop();
	CALL	_extruder_stop
;	.line	653; "extruder2.c"	break;
	GOTO	_00309_DS_
_00296_DS_
;	.line	657; "extruder2.c"	seekNotify = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;	.line	658; "extruder2.c"	break;
	GOTO	_00309_DS_
_00297_DS_
;	.line	661; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	662; "extruder2.c"	sendDataByte(CMD_ISEMPTY);
	MOVLW	0x08
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	664; "extruder2.c"	sendDataByte(!RA5);   
	BANKSEL	r0x1019
	CLRF	r0x1019
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00001_DS_
	BANKSEL	r0x1019
	INCF	r0x1019,F
_00001_DS_
	BANKSEL	r0x1019
	MOVF	r0x1019,W
	MOVLW	0x00
	BTFSC	STATUS,2
	MOVLW	0x01
	MOVWF	r0x101A
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	668; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	669; "extruder2.c"	break;
	GOTO	_00309_DS_
_00298_DS_
;	.line	672; "extruder2.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	673; "extruder2.c"	requestedHeat0 = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_requestedHeat0
	MOVWF	_requestedHeat0
;	.line	674; "extruder2.c"	requestedHeat1 = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	_requestedHeat1
	MOVWF	_requestedHeat1
;	.line	675; "extruder2.c"	temperatureLimit0 = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	_temperatureLimit0
	MOVWF	_temperatureLimit0
;	.line	676; "extruder2.c"	temperatureLimit1 = buffer[4];
	BANKSEL	_buffer
	MOVF	(_buffer + 4),W
	BANKSEL	_temperatureLimit1
	MOVWF	_temperatureLimit1
;	.line	677; "extruder2.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	678; "extruder2.c"	break;
	GOTO	_00309_DS_
_00299_DS_
;	.line	681; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	682; "extruder2.c"	sendDataByte(CMD_GETTEMP);
	MOVLW	0x0a
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	683; "extruder2.c"	sendDataByte(lastTemperature);
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	684; "extruder2.c"	sendDataByte(0);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	685; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	686; "extruder2.c"	break;
	GOTO	_00309_DS_
_00300_DS_
;	.line	689; "extruder2.c"	set_cooler(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	CALL	_set_cooler
;	.line	697; "extruder2.c"	break;
	GOTO	_00309_DS_
_00301_DS_
;	.line	702; "extruder2.c"	PWMPeriod = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_PWMPeriod
	MOVWF	_PWMPeriod
;	.line	703; "extruder2.c"	PR2 = PWMPeriod;
	MOVF	_PWMPeriod,W
	BANKSEL	_PR2
	MOVWF	_PR2
;	.line	704; "extruder2.c"	break;
	GOTO	_00309_DS_
_00302_DS_
;	.line	708; "extruder2.c"	T2CON = BIN(00000100) | (buffer[1] & 3);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	0x03
	ANDWF	r0x1019,F
	MOVLW	0x04
	IORWF	r0x1019,W
	BANKSEL	_T2CON
	MOVWF	_T2CON
;	.line	709; "extruder2.c"	break;
	GOTO	_00309_DS_
_00303_DS_
;	.line	712; "extruder2.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	713; "extruder2.c"	temperatureVRef = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_temperatureVRef
	MOVWF	_temperatureVRef
;	.line	714; "extruder2.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	715; "extruder2.c"	break;
	GOTO	_00309_DS_
_00304_DS_
;	.line	718; "extruder2.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	719; "extruder2.c"	OPTION_REG = (OPTION_REG & BIN(11111000)) | (buffer[1] & BIN(111));
	MOVLW	0xf8
	BANKSEL	_OPTION_REG
	ANDWF	_OPTION_REG,W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVLW	0x07
	ANDWF	r0x101A,F
	MOVF	r0x101A,W
	IORWF	r0x1019,W
	BANKSEL	_OPTION_REG
	MOVWF	_OPTION_REG
;	.line	720; "extruder2.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	721; "extruder2.c"	break;
	GOTO	_00309_DS_
_00305_DS_
;	.line	724; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	725; "extruder2.c"	sendDataByte(CMD_GETDEBUGINFO);
	MOVLW	0x36
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	726; "extruder2.c"	sendDataByte(heatCounter);
	BANKSEL	_heatCounter
	MOVF	_heatCounter,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	727; "extruder2.c"	sendDataByte(PORTA);
	BANKSEL	_PORTA
	MOVF	_PORTA,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	728; "extruder2.c"	sendDataByte(TRISA);
	BANKSEL	_TRISA
	MOVF	_TRISA,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	729; "extruder2.c"	sendDataByte(OPTION_REG);
	BANKSEL	_OPTION_REG
	MOVF	_OPTION_REG,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	730; "extruder2.c"	sendDataByte(temperatureVRef);
	BANKSEL	_temperatureVRef
	MOVF	_temperatureVRef,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	731; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	732; "extruder2.c"	break;
	GOTO	_00309_DS_
_00306_DS_
;	.line	735; "extruder2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	736; "extruder2.c"	sendDataByte(CMD_GETTEMPINFO);
	MOVLW	0x37
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	737; "extruder2.c"	sendDataByte(requestedHeat0);
	BANKSEL	_requestedHeat0
	MOVF	_requestedHeat0,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	738; "extruder2.c"	sendDataByte(requestedHeat1);
	BANKSEL	_requestedHeat1
	MOVF	_requestedHeat1,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	739; "extruder2.c"	sendDataByte(temperatureLimit0);
	BANKSEL	_temperatureLimit0
	MOVF	_temperatureLimit0,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	740; "extruder2.c"	sendDataByte(temperatureLimit1);
	BANKSEL	_temperatureLimit1
	MOVF	_temperatureLimit1,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	741; "extruder2.c"	sendDataByte(lastTemperature);
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	742; "extruder2.c"	sendDataByte(temperatureNotUpdatedCounter);
	BANKSEL	_temperatureNotUpdatedCounter
	MOVF	_temperatureNotUpdatedCounter,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	743; "extruder2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	744; "extruder2.c"	break;
	GOTO	_00309_DS_
_00307_DS_
;	.line	747; "extruder2.c"	solenoid(1);
	MOVLW	0x01
	CALL	_solenoid
;	.line	748; "extruder2.c"	break;
	GOTO	_00309_DS_
_00308_DS_
;	.line	751; "extruder2.c"	solenoid(0);
	MOVLW	0x00
	CALL	_solenoid
_00309_DS_
	BANKSEL _currentPosition
	RETURN	
; exit point of _processCommand

;***
;  pBlock Stats: dbName = C
;***
;entry:  _checkTemperature	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;2 compiler assigned registers:
;   r0x1020
;   r0x1021
;; Starting pCode block
_checkTemperature	;Function start
; 2 exit points
;	.line	489; "extruder2.c"	for (i=temperatureNotUpdatedCounter; i>0; i--) {
	BANKSEL	_temperatureNotUpdatedCounter
	MOVF	_temperatureNotUpdatedCounter,W
	BANKSEL	r0x1020
	MOVWF	r0x1020
_00261_DS_
	MOVLW	0x00
	BANKSEL	r0x1020
	IORWF	r0x1020,W
	BTFSC	STATUS,2
	GOTO	_00267_DS_
	MOVLW	0x01
	MOVWF	r0x1021
	GOTO	_00268_DS_
_00267_DS_
	BANKSEL	r0x1021
	CLRF	r0x1021
_00268_DS_
	MOVLW	0x00
	BANKSEL	r0x1021
	IORWF	r0x1021,W
	BTFSC	STATUS,2
	GOTO	_00264_DS_
	nop
	
;	.line	489; "extruder2.c"	for (i=temperatureNotUpdatedCounter; i>0; i--) {
	BANKSEL	r0x1020
	DECF	r0x1020,F
	GOTO	_00261_DS_
_00264_DS_
;	.line	498; "extruder2.c"	T0CS = 0;
	BANKSEL	_OPTION_REG_bits
	BCF	_OPTION_REG_bits,5
;	.line	499; "extruder2.c"	PSA = 0;
	BCF	_OPTION_REG_bits,3
;	.line	500; "extruder2.c"	CMCON = BIN(00000010);
	MOVLW	0x02
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	503; "extruder2.c"	VRCON = BIN(10000000) | temperatureVRef;
	MOVLW	0x80
	BANKSEL	_temperatureVRef
	IORWF	_temperatureVRef,W
	BANKSEL	_VRCON
	MOVWF	_VRCON
;	.line	504; "extruder2.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	508; "extruder2.c"	GIE = 0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	509; "extruder2.c"	T0IF = 0;
	BCF	_INTCON_bits,2
;	.line	510; "extruder2.c"	portaval &= BIN(00111101);
	MOVLW	0x3d
	BANKSEL	_portaval
	ANDWF	_portaval,F
;	.line	511; "extruder2.c"	portaval |= BIN(10000000);
	BSF	_portaval,7
;	.line	512; "extruder2.c"	TRISA = BIN(01000010) | PORTATRIS;
	MOVLW	0x62
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	513; "extruder2.c"	PORTA = portaval;  //must be set after TRISA
	BANKSEL	_portaval
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
;	.line	514; "extruder2.c"	TMR0 = 0; 
	CLRF	_TMR0
;	.line	515; "extruder2.c"	interruptTemp = 0;
	BANKSEL	_interruptTemp
	CLRF	_interruptTemp
;	.line	516; "extruder2.c"	GIE = 1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
_00248_DS_
;	.line	522; "extruder2.c"	while (C2OUT) 
	BANKSEL	_CMCON_bits
	BTFSC	_CMCON_bits,7
	GOTO	_00248_DS_
;	.line	524; "extruder2.c"	GIE = 0;
	BCF	_INTCON_bits,7
;	.line	525; "extruder2.c"	tmpLastTemperature = TMR0;
	MOVF	_TMR0,W
	BANKSEL	r0x1020
	MOVWF	r0x1020
;	.line	526; "extruder2.c"	if (T0IF) {
	BANKSEL	_INTCON_bits
	BTFSS	_INTCON_bits,2
	GOTO	_00252_DS_
;	.line	527; "extruder2.c"	tmpLastTemperature = 255;
	MOVLW	0xff
	BANKSEL	r0x1020
	MOVWF	r0x1020
_00252_DS_
;	.line	529; "extruder2.c"	if (interruptTemp == 1) {
	BANKSEL	_interruptTemp
	MOVF	_interruptTemp,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00254_DS_
;	.line	530; "extruder2.c"	temperatureNotUpdatedCounter++;
	BANKSEL	_temperatureNotUpdatedCounter
	INCF	_temperatureNotUpdatedCounter,F
	GOTO	_00255_DS_
_00254_DS_
;	.line	532; "extruder2.c"	lastTemperature = tmpLastTemperature;
	BANKSEL	r0x1020
	MOVF	r0x1020,W
	BANKSEL	_lastTemperature
	MOVWF	_lastTemperature
;	.line	533; "extruder2.c"	temperatureNotUpdatedCounter = 0;
	BANKSEL	_temperatureNotUpdatedCounter
	CLRF	_temperatureNotUpdatedCounter
_00255_DS_
;	.line	535; "extruder2.c"	GIE = 1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	537; "extruder2.c"	if (temperatureNotUpdatedCounter == 255)
	BANKSEL	_temperatureNotUpdatedCounter
	MOVF	_temperatureNotUpdatedCounter,W
;	.line	538; "extruder2.c"	temperatureNotUpdatedCounter--;  //to prevent an overflow
	XORLW	0xff
;	.line	540; "extruder2.c"	delay_10us(); //to handle interrupts
	BTFSC	STATUS,2
	DECF	_temperatureNotUpdatedCounter,F
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	545; "extruder2.c"	GIE = 0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	546; "extruder2.c"	portaval &= BIN(00111101);
	MOVLW	0x3d
	BANKSEL	_portaval
	ANDWF	_portaval,F
;	.line	547; "extruder2.c"	TRISA = BIN(00000000) | PORTATRIS;
	MOVLW	0x20
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	548; "extruder2.c"	PORTA = portaval;
	BANKSEL	_portaval
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
;	.line	549; "extruder2.c"	GIE = 1;
	BSF	_INTCON_bits,7
;	.line	552; "extruder2.c"	VRCON = BIN(10100000); //should be 1010xxxx to not output value
	MOVLW	0xa0
	BANKSEL	_VRCON
	MOVWF	_VRCON
;	.line	555; "extruder2.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
_00258_DS_
;	.line	557; "extruder2.c"	while (!C2OUT)
	BANKSEL	_CMCON_bits
	BTFSS	_CMCON_bits,7
	GOTO	_00258_DS_
;	.line	560; "extruder2.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	561; "extruder2.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	563; "extruder2.c"	TRISA = BIN(11000010) | PORTATRIS;
	MOVLW	0xe2
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	564; "extruder2.c"	VRCON = 0;  // Turn off vref
	CLRF	_VRCON
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
;   r0x1022
;   r0x1023
;   r0x1024
;   r0x1025
;; Starting pCode block
_motorTick	;Function start
; 2 exit points
;	.line	440; "extruder2.c"	RBIF = 0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,0
;	.line	442; "extruder2.c"	change_log();  //not correct for UNIVERSIAL_PCB
	CALL	_change_log
;	.line	444; "extruder2.c"	if (extrude_click) {
	BANKSEL	_extrude_click
	MOVF	_extrude_click,W
	BTFSC	STATUS,2
	GOTO	_00239_DS_
;	.line	447; "extruder2.c"	if (currentDirection)
	BANKSEL	_currentDirection
	MOVF	_currentDirection,W
	BTFSC	STATUS,2
	GOTO	_00233_DS_
;	.line	448; "extruder2.c"	currentPosition.ival--;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1022
	MOVWF	r0x1022
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1023
	MOVWF	r0x1023
	MOVLW	0xff
	ADDWF	r0x1022,F
	BTFSS	STATUS,0
	DECF	r0x1023,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x1022,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
	GOTO	_00234_DS_
_00233_DS_
;	.line	450; "extruder2.c"	currentPosition.ival++;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1022
	MOVWF	r0x1022
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1023
	MOVWF	r0x1023
	INCF	r0x1022,F
	BTFSC	STATUS,2
	INCF	r0x1023,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x1022,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
_00234_DS_
;	.line	452; "extruder2.c"	if ((seekSpeed != 0) && (currentPosition.ival == seekPosition.ival)) {
	MOVLW	0x00
	BANKSEL	_seekSpeed
	IORWF	_seekSpeed,W
	BTFSC	STATUS,2
	GOTO	_00239_DS_
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1022
	MOVWF	r0x1022
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1023
	MOVWF	r0x1023
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x1024
	MOVWF	r0x1024
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVF	r0x1024,W
	XORWF	r0x1022,W
	BTFSS	STATUS,2
	GOTO	_00239_DS_
	MOVF	r0x1025,W
;	.line	454; "extruder2.c"	extruder_stop();
	XORWF	r0x1023,W
;	.line	458; "extruder2.c"	if (material_click) {
	BTFSC	STATUS,2
	CALL	_extruder_stop
_00239_DS_
	MOVLW	0x00
	BANKSEL	_material_click
	IORWF	_material_click,W
	BTFSC	STATUS,2
	GOTO	_00243_DS_
;	.line	459; "extruder2.c"	if (sendMessageISR(seekNotify)) { 
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x1022
	MOVWF	r0x1022
	MOVF	r0x1022,W
	BTFSC	STATUS,2
	GOTO	_00243_DS_
;	.line	463; "extruder2.c"	sendDataByteISR(CMD_ISEMPTY);
	MOVLW	0x08
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	464; "extruder2.c"	sendDataByteISR(1);
	MOVLW	0x01
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	465; "extruder2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
_00243_DS_
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
;   _heater_off
;   _heater_off
;   _heater_off
;   _heater_off
;   _heater_on
;   _heater_off
;   _heater_off
;   _heater_off
;   _heater_off
;   _heater_on
;; Starting pCode block
_timerTick	;Function start
; 2 exit points
;unsigned compare: left < lit(0x10=16), size=1
;	.line	385; "extruder2.c"	if ((lastTemperature < 0x10) || (temperatureNotUpdatedCounter > 100)) { 
	MOVLW	0x10
	BANKSEL	_lastTemperature
	SUBWF	_lastTemperature,W
	BTFSS	STATUS,0
	GOTO	_00194_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;swapping arguments (AOP_TYPEs 1/3)
;unsigned compare: left >= lit(0x65=101), size=1
	MOVLW	0x65
	BANKSEL	_temperatureNotUpdatedCounter
	SUBWF	_temperatureNotUpdatedCounter,W
	BTFSS	STATUS,0
	GOTO	_00195_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
_00194_DS_
;	.line	388; "extruder2.c"	heater_off();  
	CALL	_heater_off
	GOTO	_00196_DS_
_00195_DS_
;	.line	389; "extruder2.c"	} else if (lastTemperature <= temperatureLimit1) {
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	BANKSEL	_temperatureLimit1
	SUBWF	_temperatureLimit1,W
	BTFSS	STATUS,0
	GOTO	_00192_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;	.line	391; "extruder2.c"	heater_off();
	CALL	_heater_off
	GOTO	_00196_DS_
_00192_DS_
;	.line	392; "extruder2.c"	} else if ((lastTemperature <= temperatureLimit0) &&
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	BANKSEL	_temperatureLimit0
	SUBWF	_temperatureLimit0,W
	BTFSS	STATUS,0
	GOTO	_00187_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;	.line	393; "extruder2.c"	(heatCounter >= requestedHeat1) && (requestedHeat1 != 255)) {
	BANKSEL	_requestedHeat1
	MOVF	_requestedHeat1,W
	BANKSEL	_heatCounter
	SUBWF	_heatCounter,W
	BTFSS	STATUS,0
	GOTO	_00187_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
	BANKSEL	_requestedHeat1
	MOVF	_requestedHeat1,W
;	.line	395; "extruder2.c"	heater_off();
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00187_DS_
	CALL	_heater_off
	GOTO	_00196_DS_
_00187_DS_
;	.line	396; "extruder2.c"	} else if ((lastTemperature > temperatureLimit0) &&
	BANKSEL	_lastTemperature
	MOVF	_lastTemperature,W
	BANKSEL	_temperatureLimit0
	SUBWF	_temperatureLimit0,W
	BTFSC	STATUS,0
	GOTO	_00182_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
;	.line	397; "extruder2.c"	(heatCounter >= requestedHeat0) && (requestedHeat0 != 255)) {
	BANKSEL	_requestedHeat0
	MOVF	_requestedHeat0,W
	BANKSEL	_heatCounter
	SUBWF	_heatCounter,W
	BTFSS	STATUS,0
	GOTO	_00182_DS_
;genSkipc:3694: created from rifx:0xbf8b93d0
	BANKSEL	_requestedHeat0
	MOVF	_requestedHeat0,W
;	.line	399; "extruder2.c"	heater_off();
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00182_DS_
	CALL	_heater_off
	GOTO	_00196_DS_
_00182_DS_
;	.line	402; "extruder2.c"	heater_on();
	CALL	_heater_on
_00196_DS_
;	.line	404; "extruder2.c"	heatCounter++;
	BANKSEL	_heatCounter
	INCF	_heatCounter,F
;	.line	405; "extruder2.c"	TMR1H = HEATER_PWM_PERIOD;
	MOVLW	0xff
	BANKSEL	_TMR1H
	MOVWF	_TMR1H
;	.line	406; "extruder2.c"	TMR1L = 0;
	CLRF	_TMR1L
;	.line	408; "extruder2.c"	if(solenoid_on)
	BANKSEL	_solenoid_on
	MOVF	_solenoid_on,W
	BTFSC	STATUS,2
	GOTO	_00205_DS_
;	.line	410; "extruder2.c"	if(pulseCounter2 == 0)
	BANKSEL	_pulseCounter2
	MOVF	_pulseCounter2,W
	BTFSS	STATUS,2
	GOTO	_00202_DS_
;	.line	412; "extruder2.c"	if(pulseCounter1 == 0)
	BANKSEL	_pulseCounter1
	MOVF	_pulseCounter1,W
	BTFSS	STATUS,2
	GOTO	_00199_DS_
;	.line	414; "extruder2.c"	portaval &= BIN(11111010);
	MOVLW	0xfa
	BANKSEL	_portaval
	ANDWF	_portaval,F
;	.line	415; "extruder2.c"	PORTA = portaval;
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
;	.line	416; "extruder2.c"	solenoid_on = 0;
	BANKSEL	_solenoid_on
	CLRF	_solenoid_on
	GOTO	_00205_DS_
_00199_DS_
;	.line	419; "extruder2.c"	pulseCounter1--;
	BANKSEL	_pulseCounter1
	DECF	_pulseCounter1,F
;	.line	420; "extruder2.c"	pulseCounter2 = PC2;
	MOVLW	0x14
	BANKSEL	_pulseCounter2
	MOVWF	_pulseCounter2
	GOTO	_00205_DS_
_00202_DS_
;	.line	423; "extruder2.c"	pulseCounter2--;
	BANKSEL	_pulseCounter2
	DECF	_pulseCounter2,F
_00205_DS_
	BANKSEL _currentPosition
	RETURN	
; exit point of _timerTick

;***
;  pBlock Stats: dbName = C
;***
;entry:  _setSpeed	;Function start
; 2 exit points
;has an exit
;functions called:
;   _extruder_stop
;   _extruder_forward
;   _extruder_reverse
;   _pwmSet
;   _extruder_stop
;   _extruder_forward
;   _extruder_reverse
;   _pwmSet
;1 compiler assigned register :
;   r0x101E
;; Starting pCode block
_setSpeed	;Function start
; 2 exit points
;	.line	354; "extruder2.c"	void setSpeed(byte direction)
	BANKSEL	r0x101E
	MOVWF	r0x101E
;	.line	356; "extruder2.c"	if (seekSpeed == 0) 
	BANKSEL	_seekSpeed
	MOVF	_seekSpeed,W
	BTFSS	STATUS,2
	GOTO	_00174_DS_
;	.line	358; "extruder2.c"	extruder_stop();
	CALL	_extruder_stop
;	.line	359; "extruder2.c"	return;
	GOTO	_00176_DS_
_00174_DS_
;	.line	362; "extruder2.c"	if (direction == 0) 
	MOVLW	0x00
	BANKSEL	r0x101E
	IORWF	r0x101E,W
	BTFSS	STATUS,2
	GOTO	_00171_DS_
;	.line	363; "extruder2.c"	extruder_forward();
	CALL	_extruder_forward
	GOTO	_00175_DS_
_00171_DS_
;	.line	365; "extruder2.c"	extruder_reverse();
	CALL	_extruder_reverse
_00175_DS_
;	.line	367; "extruder2.c"	pwmSet(0);    
	MOVLW	0x00
	CALL	_pwmSet
;	.line	368; "extruder2.c"	currentDirection = direction;
	BANKSEL	r0x101E
	MOVF	r0x101E,W
	BANKSEL	_currentDirection
	MOVWF	_currentDirection
	BANKSEL _currentPosition
	
_00176_DS_
	RETURN	
; exit point of _setSpeed

;***
;  pBlock Stats: dbName = C
;***
;entry:  _pwmSet	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x101F
;; Starting pCode block
_pwmSet	;Function start
; 2 exit points
;	.line	326; "extruder2.c"	void pwmSet(byte fastOverRide)
	BANKSEL	r0x101F
	MOVWF	r0x101F
;	.line	328; "extruder2.c"	CCP1CON = BIN(00111100);
	MOVLW	0x3c
	BANKSEL	_CCP1CON
	MOVWF	_CCP1CON
;	.line	329; "extruder2.c"	CCPR1L = seekSpeed;
	BANKSEL	_seekSpeed
	MOVF	_seekSpeed,W
	BANKSEL	_CCPR1L
	MOVWF	_CCPR1L
;	.line	330; "extruder2.c"	if (fastOverRide || seekSpeed == 255)
	BANKSEL	r0x101F
	MOVF	r0x101F,W
	BTFSS	STATUS,2
	GOTO	_00163_DS_
	BANKSEL	_seekSpeed
	MOVF	_seekSpeed,W
	XORLW	0xff
	BTFSS	STATUS,2
	GOTO	_00164_DS_
_00163_DS_
;	.line	331; "extruder2.c"	PR2 = 0;
	BANKSEL	_PR2
	CLRF	_PR2
	GOTO	_00165_DS_
_00164_DS_
;	.line	333; "extruder2.c"	PR2 = PWMPeriod;
	BANKSEL	_PWMPeriod
	MOVF	_PWMPeriod,W
	BANKSEL	_PR2
	MOVWF	_PR2
_00165_DS_
	BANKSEL _currentPosition
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
;	.line	298; "extruder2.c"	PWMPeriod = 255;
	MOVLW	0xff
	BANKSEL	_PWMPeriod
	MOVWF	_PWMPeriod
;	.line	299; "extruder2.c"	currentDirection = 0;
	BANKSEL	_currentDirection
	CLRF	_currentDirection
;	.line	300; "extruder2.c"	seekSpeed = 0;
	BANKSEL	_seekSpeed
	CLRF	_seekSpeed
;	.line	301; "extruder2.c"	seekNotify = 255;
	MOVLW	0xff
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;	.line	302; "extruder2.c"	lastPortB = 0;
	BANKSEL	_lastPortB
	CLRF	_lastPortB
;	.line	303; "extruder2.c"	lastPortA = 0;
	BANKSEL	_lastPortA
	CLRF	_lastPortA
;	.line	304; "extruder2.c"	extrude_click = 0;
	BANKSEL	_extrude_click
	CLRF	_extrude_click
;	.line	305; "extruder2.c"	material_click = 0;
	BANKSEL	_material_click
	CLRF	_material_click
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	306; "extruder2.c"	currentPosition.bytes[0] = 0;
	BANKSEL	_currentPosition
	CLRF	(_currentPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	307; "extruder2.c"	currentPosition.bytes[1] = 0;
	CLRF	(_currentPosition + 1)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	308; "extruder2.c"	seekPosition.bytes[0] = 0;
	BANKSEL	_seekPosition
	CLRF	(_seekPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	309; "extruder2.c"	seekPosition.bytes[1] = 0;
	CLRF	(_seekPosition + 1)
;	.line	310; "extruder2.c"	requestedHeat0 = 0;
	BANKSEL	_requestedHeat0
	CLRF	_requestedHeat0
;	.line	311; "extruder2.c"	requestedHeat1 = 0;
	BANKSEL	_requestedHeat1
	CLRF	_requestedHeat1
;	.line	312; "extruder2.c"	temperatureLimit0 = 0;
	BANKSEL	_temperatureLimit0
	CLRF	_temperatureLimit0
;	.line	313; "extruder2.c"	temperatureLimit1 = 0;
	BANKSEL	_temperatureLimit1
	CLRF	_temperatureLimit1
;	.line	314; "extruder2.c"	heatCounter = 0;
	BANKSEL	_heatCounter
	CLRF	_heatCounter
;	.line	315; "extruder2.c"	lastTemperature = 255;
	MOVLW	0xff
	BANKSEL	_lastTemperature
	MOVWF	_lastTemperature
;	.line	316; "extruder2.c"	temperatureVRef = 0; //set to 0, should be set by the host software
	BANKSEL	_temperatureVRef
	CLRF	_temperatureVRef
;	.line	317; "extruder2.c"	portaval = 0;
	BANKSEL	_portaval
	CLRF	_portaval
;	.line	318; "extruder2.c"	PORTA = portaval;
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
;	.line	319; "extruder2.c"	TMR1H = HEATER_PWM_PERIOD;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	320; "extruder2.c"	TMR1L = 0;
	CLRF	_TMR1L
;	.line	321; "extruder2.c"	temperatureNotUpdatedCounter=0;
	BANKSEL	_temperatureNotUpdatedCounter
	CLRF	_temperatureNotUpdatedCounter
	RETURN	
; exit point of _init2

;***
;  pBlock Stats: dbName = C
;***
;entry:  _solenoid	;Function start
; 2 exit points
;has an exit
;functions called:
;   _solenoid_delay
;   _solenoid_delay
;1 compiler assigned register :
;   r0x101E
;; Starting pCode block
_solenoid	;Function start
; 2 exit points
;	.line	207; "extruder2.c"	void solenoid(byte on)
	BANKSEL	r0x101E
	MOVWF	r0x101E
;	.line	209; "extruder2.c"	portaval &= BIN(11111010);
	MOVLW	0xfa
	BANKSEL	_portaval
	ANDWF	_portaval,F
;	.line	210; "extruder2.c"	if(on)
	BANKSEL	r0x101E
	MOVF	r0x101E,W
	BTFSC	STATUS,2
	GOTO	_00153_DS_
;	.line	211; "extruder2.c"	portaval |= BIN(00000001);
	BANKSEL	_portaval
	BSF	_portaval,0
	GOTO	_00154_DS_
_00153_DS_
;	.line	213; "extruder2.c"	portaval |= BIN(00000100);
	BANKSEL	_portaval
	BSF	_portaval,2
_00154_DS_
;	.line	214; "extruder2.c"	PORTA = portaval;	
	BANKSEL	_portaval
	MOVF	_portaval,W
	BANKSEL	_PORTA
	MOVWF	_PORTA
;	.line	215; "extruder2.c"	solenoid_delay();
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
;	.line	196; "extruder2.c"	pwmSet(1);
	MOVLW	0x01
	PAGESEL	_pwmSet
	CALL	_pwmSet
	PAGESEL	$
;	.line	197; "extruder2.c"	pulseCounter1 = PC1;
	MOVLW	0x64
	BANKSEL	_pulseCounter1
	MOVWF	_pulseCounter1
;	.line	198; "extruder2.c"	pulseCounter2 = PC2; 
	MOVLW	0x14
	BANKSEL	_pulseCounter2
	MOVWF	_pulseCounter2
;	.line	199; "extruder2.c"	solenoid_on = 1;
	MOVLW	0x01
	BANKSEL	_solenoid_on
	MOVWF	_solenoid_on
	RETURN	
; exit point of _solenoid_delay

;***
;  pBlock Stats: dbName = C
;***
;entry:  _set_cooler	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x101E
;; Starting pCode block
_set_cooler	;Function start
; 2 exit points
;	.line	177; "extruder2.c"	void set_cooler(byte b)
	BANKSEL	r0x101E
	MOVWF	r0x101E
;	.line	179; "extruder2.c"	if (b)
	MOVF	r0x101E,W
	BTFSC	STATUS,2
	GOTO	_00141_DS_
;	.line	180; "extruder2.c"	RB6 = 1;
	BANKSEL	_PORTB_bits
	BSF	_PORTB_bits,6
	GOTO	_00143_DS_
_00141_DS_
;	.line	183; "extruder2.c"	RB6 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,6
_00143_DS_
	RETURN	
; exit point of _set_cooler

;***
;  pBlock Stats: dbName = C
;***
;entry:  _change_log	;Function start
; 2 exit points
;has an exit
;2 compiler assigned registers:
;   r0x1026
;   r0x1027
;; Starting pCode block
_change_log	;Function start
; 2 exit points
;	.line	150; "extruder2.c"	extrude_click = 0;
	BANKSEL	_extrude_click
	CLRF	_extrude_click
;	.line	151; "extruder2.c"	material_click = 0;
	BANKSEL	_material_click
	CLRF	_material_click
;	.line	165; "extruder2.c"	current = RA5;  // Store so it doesn't change half way through processing
	BANKSEL	r0x1026
	CLRF	r0x1026
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00002_DS_
	BANKSEL	r0x1026
	INCF	r0x1026,F
_00002_DS_
;	.line	166; "extruder2.c"	changes = lastPortA ^ current;  
	BANKSEL	_lastPortA
	MOVF	_lastPortA,W
	BANKSEL	r0x1027
	MOVWF	r0x1027
	MOVF	r0x1026,W
	XORWF	r0x1027,F
;	.line	167; "extruder2.c"	if (changes) {
	MOVF	r0x1027,W
	BTFSC	STATUS,2
	GOTO	_00129_DS_
;	.line	169; "extruder2.c"	if (!current && seekNotify != 255) {
	MOVF	r0x1026,W
	BTFSS	STATUS,2
	GOTO	_00129_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	170; "extruder2.c"	material_click = 1;
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00129_DS_
	MOVLW	0x01
	BANKSEL	_material_click
	MOVWF	_material_click
_00129_DS_
;	.line	173; "extruder2.c"	lastPortA = current;
	BANKSEL	r0x1026
	MOVF	r0x1026,W
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
;	.line	141; "extruder2.c"	portaval |= BIN(00001000);
	BANKSEL	_portaval
	BSF	_portaval,3
;	.line	142; "extruder2.c"	PORTA = portaval;
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
;	.line	136; "extruder2.c"	portaval &= BIN(11110111);
	BANKSEL	_portaval
	BCF	_portaval,3
;	.line	137; "extruder2.c"	PORTA = portaval;
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
;	.line	131; "extruder2.c"	RB4 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,4
;	.line	132; "extruder2.c"	RB5 = 1;
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
;	.line	126; "extruder2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	127; "extruder2.c"	RB4 = 1;
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
;	.line	121; "extruder2.c"	RB4 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,4
;	.line	122; "extruder2.c"	RB5 = 0;
	BCF	_PORTB_bits,5
	RETURN	
; exit point of _extruder_stop


;	code size estimation:
;	  685+  366 =  1051 instructions ( 2834 byte)

	end
