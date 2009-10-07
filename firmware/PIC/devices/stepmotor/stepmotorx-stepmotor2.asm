;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.7.4 #4943 (Oct 27 2007) (UNIX)
; This file was generated Fri Jun 13 14:34:01 2008
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.module stepmotor2
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
	extern	_syncEnabled
	extern	_syncCounter
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
	global	_setPower
	global	_syncStrobe
	global	_timerTick
	global	_init2
	global	_motor_stop
	global	_motor_click
	global	_forward1
	global	_reverse1
	global	_setTimer
	global	_strobe_sync

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_stepmotor2_0	udata
r0x1017	res	1
r0x1015	res	1
r0x1016	res	1
r0x1022	res	1
r0x101D	res	1
r0x101E	res	1
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
r0x1019	res	1
r0x101A	res	1
r0x101B	res	1
r0x101C	res	1
r0x1011	res	1
r0x1014	res	1
_currentPosition	res	2
_seekPosition	res	2
_maxPosition	res	2
_dda_error	res	2
_dda_deltay	res	2
_dda_deltax	res	2
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_stepmotor2_0	idata
_coilPosition
	db	0x00


ID_stepmotor2_1	idata
_function
	db	0x00


ID_stepmotor2_2	idata
_speed
	db	0x00


ID_stepmotor2_3	idata
_seekNotify
	db	0xff


ID_stepmotor2_4	idata
_sync_mode
	db	0x00

;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_stepmotor2	code
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
;   _setTimer
;   _setTimer
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
;   _motor_stop
;   _setTimer
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
;   _forward1
;   _reverse1
;   _setPower
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
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
;   _setTimer
;   _setTimer
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
;   _motor_stop
;   _setTimer
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
;   _forward1
;   _reverse1
;   _setPower
;   _sendReply
;   _sendDataByte
;   _sendDataByte
;   _sendDataByte
;   _endMessage
;   _setTimer
;4 compiler assigned registers:
;   r0x1011
;   r0x1012
;   r0x1013
;   r0x1014
;; Starting pCode block
_processCommand	;Function start
; 2 exit points
;	.line	577; "stepmotor2.c"	switch(buffer[0]) {
	BANKSEL	_buffer
	MOVF	(_buffer + 0),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BTFSC	STATUS,2
	GOTO	_00283_DS_
	MOVF	r0x1011,W
	XORLW	0x01
	BTFSC	STATUS,2
	GOTO	_00295_DS_
	MOVF	r0x1011,W
	XORLW	0x02
	BTFSC	STATUS,2
	GOTO	_00296_DS_
	MOVF	r0x1011,W
	XORLW	0x03
	BTFSC	STATUS,2
	GOTO	_00297_DS_
	MOVF	r0x1011,W
	XORLW	0x04
	BTFSC	STATUS,2
	GOTO	_00298_DS_
	MOVF	r0x1011,W
	XORLW	0x05
	BTFSC	STATUS,2
	GOTO	_00299_DS_
	MOVF	r0x1011,W
	XORLW	0x06
	BTFSC	STATUS,2
	GOTO	_00303_DS_
	MOVF	r0x1011,W
	XORLW	0x07
	BTFSC	STATUS,2
	GOTO	_00304_DS_
	MOVF	r0x1011,W
	XORLW	0x08
	BTFSC	STATUS,2
	GOTO	_00305_DS_
	MOVF	r0x1011,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00306_DS_
	MOVF	r0x1011,W
	XORLW	0x0a
	BTFSC	STATUS,2
	GOTO	_00307_DS_
	MOVF	r0x1011,W
	XORLW	0x0b
	BTFSC	STATUS,2
	GOTO	_00308_DS_
	MOVF	r0x1011,W
	XORLW	0x0c
	BTFSC	STATUS,2
	GOTO	_00311_DS_
	MOVF	r0x1011,W
	XORLW	0x0d
	BTFSC	STATUS,2
	GOTO	_00312_DS_
	MOVF	r0x1011,W
	XORLW	0x0e
	BTFSC	STATUS,2
	GOTO	_00313_DS_
	MOVF	r0x1011,W
	XORLW	0x0f
	BTFSC	STATUS,2
	GOTO	_00314_DS_
	MOVF	r0x1011,W
	XORLW	0x10
	BTFSC	STATUS,2
	GOTO	_00315_DS_
	MOVF	r0x1011,W
	XORLW	0xfe
	BTFSC	STATUS,2
	GOTO	_00284_DS_
	MOVF	r0x1011,W
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00294_DS_
	GOTO	_00316_DS_
_00283_DS_
;	.line	579; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	580; "stepmotor2.c"	sendDataByte(CMD_VERSION);  // Response type 0
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	581; "stepmotor2.c"	sendDataByte(MAJOR_VERSION_NUMBER);
	MOVLW	0x01
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	582; "stepmotor2.c"	sendDataByte(MINOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	583; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	584; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00284_DS_
;	.line	587; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	588; "stepmotor2.c"	sendDataByte(CMD_CHECKHOSTVERSION);    
	MOVLW	0xfe
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	589; "stepmotor2.c"	if(buffer[1] > OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BTFSC	STATUS,2
	GOTO	_00292_DS_
;	.line	590; "stepmotor2.c"	sendDataByte(0xff);    
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00293_DS_
_00292_DS_
;	.line	591; "stepmotor2.c"	else if (buffer[1] == OLDHOST_MAJOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	MOVF	r0x1011,W
	BTFSS	STATUS,2
	GOTO	_00289_DS_
;	.line	593; "stepmotor2.c"	if (buffer[2] >= OLDHOST_MINOR_VERSION_NUMBER)
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
;unsigned compare: left < lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	r0x1011,W
	BTFSS	STATUS,0
	GOTO	_00286_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
;	.line	594; "stepmotor2.c"	sendDataByte(0xff);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00293_DS_
_00286_DS_
;	.line	596; "stepmotor2.c"	sendDataByte(0);    
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
	GOTO	_00293_DS_
_00289_DS_
;	.line	598; "stepmotor2.c"	sendDataByte(0);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
_00293_DS_
;	.line	599; "stepmotor2.c"	sendDataByte(OLDHOST_MAJOR_VERSION_NUMBER);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	600; "stepmotor2.c"	sendDataByte(OLDHOST_MINOR_VERSION_NUMBER);
	MOVLW	0x08
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	601; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	602; "stepmotor2.c"	break;    
	GOTO	_00316_DS_
_00294_DS_
;	.line	605; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	606; "stepmotor2.c"	sendDataByte(CMD_GETMODULETYPE);
	MOVLW	0xff
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	607; "stepmotor2.c"	sendDataByte(LINEAR_AXIS_TYPE);
	MOVLW	0x00
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	608; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	609; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00295_DS_
;	.line	613; "stepmotor2.c"	function = func_forward;
	MOVLW	0x01
	BANKSEL	_function
	MOVWF	_function
;	.line	614; "stepmotor2.c"	setTimer(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
;	.line	615; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00296_DS_
;	.line	619; "stepmotor2.c"	function = func_reverse;
	MOVLW	0x02
	BANKSEL	_function
	MOVWF	_function
;	.line	620; "stepmotor2.c"	setTimer(buffer[1]);    
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
;	.line	621; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00297_DS_
;	.line	625; "stepmotor2.c"	currentPosition.bytes[0] = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;	.line	626; "stepmotor2.c"	currentPosition.bytes[1] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
;	.line	627; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00298_DS_
;	.line	631; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	632; "stepmotor2.c"	sendDataByte(CMD_GETPOS);
	MOVLW	0x04
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	633; "stepmotor2.c"	sendDataByte(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	634; "stepmotor2.c"	sendDataByte(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	635; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	636; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00299_DS_
;	.line	640; "stepmotor2.c"	seekPosition.bytes[0] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 0)
;	.line	641; "stepmotor2.c"	seekPosition.bytes[1] = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 1)
;	.line	643; "stepmotor2.c"	if (sync_mode == sync_seek)
	BANKSEL	_sync_mode
	MOVF	_sync_mode,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00301_DS_
;	.line	644; "stepmotor2.c"	function = func_syncwait;
	MOVLW	0x03
	BANKSEL	_function
	MOVWF	_function
	GOTO	_00302_DS_
_00301_DS_
;	.line	646; "stepmotor2.c"	function = func_seek;
	MOVLW	0x04
	BANKSEL	_function
	MOVWF	_function
_00302_DS_
;	.line	647; "stepmotor2.c"	setTimer(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
;	.line	648; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00303_DS_
;	.line	652; "stepmotor2.c"	motor_stop();
	CALL	_motor_stop
;	.line	653; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
;	.line	654; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00304_DS_
;	.line	658; "stepmotor2.c"	seekNotify = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;	.line	659; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00305_DS_
;	.line	663; "stepmotor2.c"	sync_mode = buffer[1];
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	_sync_mode
	MOVWF	_sync_mode
;	.line	664; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00306_DS_
;	.line	668; "stepmotor2.c"	function = func_findmin;
	MOVLW	0x05
	BANKSEL	_function
	MOVWF	_function
;	.line	669; "stepmotor2.c"	setTimer(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
;	.line	670; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00307_DS_
;	.line	674; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	675; "stepmotor2.c"	sendDataByte(CMD_GETRANGE);
	MOVLW	0x0a
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	676; "stepmotor2.c"	sendDataByte(maxPosition.bytes[0]);
	BANKSEL	_maxPosition
	MOVF	(_maxPosition + 0),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	677; "stepmotor2.c"	sendDataByte(maxPosition.bytes[1]);
	BANKSEL	_maxPosition
	MOVF	(_maxPosition + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	678; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	679; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00308_DS_
;	.line	686; "stepmotor2.c"	seekPosition.bytes[0] = buffer[2];
	BANKSEL	_buffer
	MOVF	(_buffer + 2),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 0)
;	.line	687; "stepmotor2.c"	seekPosition.bytes[1] = buffer[3];
	BANKSEL	_buffer
	MOVF	(_buffer + 3),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_seekPosition
	MOVWF	(_seekPosition + 1)
;	.line	688; "stepmotor2.c"	dda_deltay.bytes[0] = buffer[4];
	BANKSEL	_buffer
	MOVF	(_buffer + 4),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_dda_deltay
	MOVWF	(_dda_deltay + 0)
;	.line	689; "stepmotor2.c"	dda_deltay.bytes[1] = buffer[5];
	BANKSEL	_buffer
	MOVF	(_buffer + 5),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	BANKSEL	_dda_deltay
	MOVWF	(_dda_deltay + 1)
;	.line	690; "stepmotor2.c"	dda_error = 0;
	BANKSEL	_dda_error
	CLRF	_dda_error
	CLRF	(_dda_error + 1)
;	.line	692; "stepmotor2.c"	dda_deltax = seekPosition.ival - currentPosition.ival;
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
;;101	MOVF	(_seekPosition + 1),W
;;99	MOVWF	r0x1012
;;120	MOVF	(_currentPosition + 0),W
;;118	MOVWF	r0x1013
;;111	MOVF	(_currentPosition + 1),W
;;119	MOVF	r0x1013,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1011
	SUBWF	r0x1011,W
	BANKSEL	_dda_deltax
	MOVWF	_dda_deltax
;;100	MOVF	r0x1012,W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	_dda_deltax
	MOVWF	(_dda_deltax + 1)
;;110	MOVF	r0x1014,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1014
	MOVWF	r0x1014
	BTFSS	STATUS,0
	INCF	r0x1014,W
	BTFSC	STATUS,2
	GOTO	_00001_DS_
	BANKSEL	_dda_deltax
	SUBWF	(_dda_deltax + 1),F
;signed compare: left < lit(0x0=0), size=2, mask=ffff
_00001_DS_
;	.line	693; "stepmotor2.c"	if (dda_deltax < 0) dda_deltax = -dda_deltax;
	BSF	STATUS,0
	BANKSEL	(_dda_deltax + 1)
	BTFSS	(_dda_deltax + 1),7
	BCF	STATUS,0
	BTFSS	STATUS,0
	GOTO	_00310_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
	COMF	_dda_deltax,F
	COMF	(_dda_deltax + 1),F
	INCF	_dda_deltax,F
	BTFSC	STATUS,2
	INCF	(_dda_deltax + 1),F
_00310_DS_
;	.line	695; "stepmotor2.c"	function = func_ddamaster;
	MOVLW	0x07
	BANKSEL	_function
	MOVWF	_function
;	.line	696; "stepmotor2.c"	setTimer(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
;	.line	697; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00311_DS_
;	.line	700; "stepmotor2.c"	forward1();
	CALL	_forward1
;	.line	701; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00312_DS_
;	.line	704; "stepmotor2.c"	reverse1();
	CALL	_reverse1
;	.line	705; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00313_DS_
;	.line	711; "stepmotor2.c"	setPower(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setPower
;	.line	712; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00314_DS_
;	.line	715; "stepmotor2.c"	sendReply();
	PAGESEL	_sendReply
	CALL	_sendReply
	PAGESEL	$
;	.line	716; "stepmotor2.c"	sendDataByte(CMD_GETSENSOR);
	MOVLW	0x0f
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	717; "stepmotor2.c"	sendDataByte(PORTA);
	BANKSEL	_PORTA
	MOVF	_PORTA,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	718; "stepmotor2.c"	sendDataByte(PORTB);
	BANKSEL	_PORTB
	MOVF	_PORTB,W
	PAGESEL	_sendDataByte
	CALL	_sendDataByte
	PAGESEL	$
;	.line	719; "stepmotor2.c"	endMessage();
	PAGESEL	_endMessage
	CALL	_endMessage
	PAGESEL	$
;	.line	720; "stepmotor2.c"	break;
	GOTO	_00316_DS_
_00315_DS_
;	.line	724; "stepmotor2.c"	function = func_homereset;
	MOVLW	0x08
	BANKSEL	_function
	MOVWF	_function
;	.line	725; "stepmotor2.c"	setTimer(buffer[1]);
	BANKSEL	_buffer
	MOVF	(_buffer + 1),W
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CALL	_setTimer
_00316_DS_
	BANKSEL _coilPosition
	RETURN	
; exit point of _processCommand

;***
;  pBlock Stats: dbName = C
;***
;entry:  _setPower	;Function start
; 2 exit points
;has an exit
;2 compiler assigned registers:
;   r0x101C
;   r0x1016
;; Starting pCode block
_setPower	;Function start
; 2 exit points
;	.line	564; "stepmotor2.c"	void setPower(byte p)
	BANKSEL	r0x101C
	MOVWF	r0x101C
;shiftRight_Left2ResultLit:6973: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	569; "stepmotor2.c"	CCPR1L = p >> 2;
	BCF	STATUS,0
	RRF	r0x101C,W
	BANKSEL	_CCPR1L
	MOVWF	_CCPR1L
;shiftRight_Left2ResultLit:6973: shCount=1, size=1, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	_CCPR1L,F
;	.line	570; "stepmotor2.c"	PR2 = 16;  // The maximum range
	MOVLW	0x10
	BANKSEL	_PR2
	MOVWF	_PR2
;	.line	572; "stepmotor2.c"	CCP1CON = BIN(1100) | ((p & BIN(11)) << 4);
	MOVLW	0x03
	BANKSEL	r0x101C
	ANDWF	r0x101C,F
	SWAPF	r0x101C,W
	ANDLW	0xf0
	MOVWF	r0x1016
	MOVLW	0x0c
	IORWF	r0x1016,W
	BANKSEL	_CCP1CON
	MOVWF	_CCP1CON
	RETURN	
; exit point of _setPower

;***
;  pBlock Stats: dbName = C
;***
;entry:  _syncStrobe	;Function start
; 2 exit points
;has an exit
;functions called:
;   _forward1
;   _reverse1
;   _forward1
;   _reverse1
;; Starting pCode block
_syncStrobe	;Function start
; 2 exit points
;swapping arguments (AOP_TYPEs 1/3)
;unsigned compare: left >= lit(0x4=4), size=1
;	.line	546; "stepmotor2.c"	switch(sync_mode) {
	MOVLW	0x04
	BANKSEL	_sync_mode
	SUBWF	_sync_mode,W
	BTFSC	STATUS,0
	GOTO	_00270_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
	MOVLW	HIGH(_00274_DS_)
	MOVWF	PCLATH
	MOVLW	_00274_DS_
	ADDWF	_sync_mode,W
	BTFSC	STATUS,0
	INCF	PCLATH,F
	BANKSEL	PCL
	MOVWF	PCL
_00274_DS_
	GOTO	_00263_DS_
	GOTO	_00264_DS_
	GOTO	_00267_DS_
	GOTO	_00268_DS_
_00263_DS_
;	.line	548; "stepmotor2.c"	break;
	GOTO	_00270_DS_
_00264_DS_
;	.line	550; "stepmotor2.c"	if (function = func_syncwait) {
	MOVLW	0x03
	BANKSEL	_function
	MOVWF	_function
;	.line	551; "stepmotor2.c"	sync_mode = sync_none;
	BANKSEL	_sync_mode
	CLRF	_sync_mode
;	.line	552; "stepmotor2.c"	function = func_seek;
	MOVLW	0x04
	BANKSEL	_function
	MOVWF	_function
;	.line	554; "stepmotor2.c"	break;
	GOTO	_00270_DS_
_00267_DS_
;	.line	556; "stepmotor2.c"	forward1();
	CALL	_forward1
;	.line	557; "stepmotor2.c"	break;
	GOTO	_00270_DS_
_00268_DS_
;	.line	559; "stepmotor2.c"	reverse1();
	CALL	_reverse1
_00270_DS_
;	.line	561; "stepmotor2.c"	}
	RETURN	
; exit point of _syncStrobe

;***
;  pBlock Stats: dbName = C
;***
;entry:  _timerTick	;Function start
; 2 exit points
;has an exit
;functions called:
;   _LEDon
;   _forward1
;   _reverse1
;   _forward1
;   _reverse1
;   _LEDon
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _reverse1
;   _forward1
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _dda_step
;   _reverse1
;   _sendMessageISR
;   _sendDataByteISR
;   _endMessageISR
;   _setTimer
;   _LEDon
;   _forward1
;   _reverse1
;   _forward1
;   _reverse1
;   _LEDon
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _reverse1
;   _forward1
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _dda_step
;   _reverse1
;   _sendMessageISR
;   _sendDataByteISR
;   _endMessageISR
;   _setTimer
;5 compiler assigned registers:
;   r0x1021
;   r0x1019
;   r0x101A
;   r0x101B
;   r0x101C
;; Starting pCode block
_timerTick	;Function start
; 2 exit points
;	.line	447; "stepmotor2.c"	switch(function) {
	BANKSEL	_function
	MOVF	_function,W
	BANKSEL	r0x1021
	MOVWF	r0x1021
;swapping arguments (AOP_TYPEs 1/2)
;unsigned compare: left >= lit(0x9=9), size=1
	MOVLW	0x09
	SUBWF	r0x1021,W
	BTFSC	STATUS,0
	GOTO	_00234_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
	MOVLW	HIGH(_00253_DS_)
	MOVWF	PCLATH
	MOVLW	_00253_DS_
	ADDWF	r0x1021,W
	BTFSC	STATUS,0
	INCF	PCLATH,F
	BANKSEL	PCL
	MOVWF	PCL
_00253_DS_
	GOTO	_00192_DS_
	GOTO	_00193_DS_
	GOTO	_00194_DS_
	GOTO	_00222_DS_
	GOTO	_00195_DS_
	GOTO	_00208_DS_
	GOTO	_00212_DS_
	GOTO	_00223_DS_
	GOTO	_00224_DS_
_00192_DS_
;	.line	449; "stepmotor2.c"	TMR1ON = 0;
	BANKSEL	_T1CON_bits
	BCF	_T1CON_bits,0
;	.line	450; "stepmotor2.c"	speed = 0;
	BANKSEL	_speed
	CLRF	_speed
;	.line	451; "stepmotor2.c"	LEDon();
	PAGESEL	_LEDon
	CALL	_LEDon
	PAGESEL	$
;	.line	452; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00193_DS_
;	.line	454; "stepmotor2.c"	forward1();
	CALL	_forward1
;	.line	455; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00194_DS_
;	.line	457; "stepmotor2.c"	reverse1();
	CALL	_reverse1
;	.line	458; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00195_DS_
;	.line	460; "stepmotor2.c"	if (currentPosition.ival < seekPosition.ival) {
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
;;117	MOVF	(_currentPosition + 1),W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101A
	MOVWF	r0x101A
;;109	MOVF	(_seekPosition + 1),W
;;116	MOVF	r0x1019,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	ADDLW	0x80
	MOVWF	r0x101C
;;108	MOVF	r0x101B,W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	ADDLW	0x80
	SUBWF	r0x101C,W
	BTFSS	STATUS,2
	GOTO	_00254_DS_
	MOVF	r0x101A,W
	SUBWF	r0x1021,W
_00254_DS_
	BTFSC	STATUS,0
	GOTO	_00200_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
;	.line	461; "stepmotor2.c"	forward1();
	CALL	_forward1
	GOTO	_00201_DS_
_00200_DS_
;	.line	462; "stepmotor2.c"	} else if (currentPosition.ival > seekPosition.ival) {
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
;;107	MOVF	(_currentPosition + 1),W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101A
	MOVWF	r0x101A
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x101B
	MOVWF	r0x101B
	ADDLW	0x80
	MOVWF	r0x101C
;;106	MOVF	r0x1019,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1019
	MOVWF	r0x1019
	ADDLW	0x80
	SUBWF	r0x101C,W
	BTFSS	STATUS,2
	GOTO	_00255_DS_
	MOVF	r0x1021,W
	SUBWF	r0x101A,W
_00255_DS_
	BTFSC	STATUS,0
	GOTO	_00197_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
;	.line	463; "stepmotor2.c"	reverse1();
	CALL	_reverse1
	GOTO	_00201_DS_
_00197_DS_
;	.line	466; "stepmotor2.c"	LEDon();
	PAGESEL	_LEDon
	CALL	_LEDon
	PAGESEL	$
;	.line	469; "stepmotor2.c"	function=func_idle;
	BANKSEL	_function
	CLRF	_function
_00201_DS_
;	.line	471; "stepmotor2.c"	if (function == func_idle && seekNotify != 255) {
	MOVLW	0x00
	BANKSEL	_function
	IORWF	_function,W
	BTFSS	STATUS,2
	GOTO	_00234_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	472; "stepmotor2.c"	if (sendMessageISR(seekNotify)) {
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00234_DS_
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x1021
	MOVWF	r0x1021
	MOVF	r0x1021,W
	BTFSC	STATUS,2
	GOTO	_00203_DS_
;	.line	473; "stepmotor2.c"	sendDataByteISR(CMD_SEEK);
	MOVLW	0x05
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	474; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	475; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	476; "stepmotor2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
	GOTO	_00234_DS_
_00203_DS_
;	.line	479; "stepmotor2.c"	function=func_seek;
	MOVLW	0x04
	BANKSEL	_function
	MOVWF	_function
;	.line	482; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00208_DS_
;	.line	484; "stepmotor2.c"	if (MINSENSOR) {
	BANKSEL	_PORTB_bits
	BTFSS	_PORTB_bits,0
	GOTO	_00210_DS_
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	485; "stepmotor2.c"	currentPosition.bytes[0] = 0;
	BANKSEL	_currentPosition
	CLRF	(_currentPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	486; "stepmotor2.c"	currentPosition.bytes[1] = 0;
	CLRF	(_currentPosition + 1)
;	.line	487; "stepmotor2.c"	function = func_findmax;
	MOVLW	0x06
	BANKSEL	_function
	MOVWF	_function
	GOTO	_00234_DS_
_00210_DS_
;	.line	489; "stepmotor2.c"	reverse1();
	CALL	_reverse1
;	.line	491; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00212_DS_
;	.line	493; "stepmotor2.c"	if (MAXSENSOR) {
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00214_DS_
;	.line	494; "stepmotor2.c"	maxPosition.bytes[0] = currentPosition.bytes[0];
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	BANKSEL	_maxPosition
	MOVWF	(_maxPosition + 0)
;	.line	495; "stepmotor2.c"	maxPosition.bytes[1] = currentPosition.bytes[1];
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	BANKSEL	_maxPosition
	MOVWF	(_maxPosition + 1)
;	.line	496; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
	GOTO	_00215_DS_
_00214_DS_
;	.line	498; "stepmotor2.c"	forward1();
	CALL	_forward1
_00215_DS_
;	.line	500; "stepmotor2.c"	if (function == func_idle && seekNotify != 255) {
	MOVLW	0x00
	BANKSEL	_function
	IORWF	_function,W
	BTFSS	STATUS,2
	GOTO	_00234_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	501; "stepmotor2.c"	if (sendMessageISR(seekNotify)) {
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00234_DS_
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x1021
	MOVWF	r0x1021
	MOVF	r0x1021,W
	BTFSC	STATUS,2
	GOTO	_00217_DS_
;	.line	502; "stepmotor2.c"	sendDataByteISR(CMD_CALIBRATE);
	MOVLW	0x09
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	503; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	504; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1021
	MOVWF	r0x1021
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	505; "stepmotor2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
	GOTO	_00234_DS_
_00217_DS_
;	.line	508; "stepmotor2.c"	function = func_findmax;
	MOVLW	0x06
	BANKSEL	_function
	MOVWF	_function
;	.line	511; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00222_DS_
;	.line	514; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00223_DS_
;	.line	516; "stepmotor2.c"	dda_step();
	CALL	_dda_step
;	.line	517; "stepmotor2.c"	break;
	GOTO	_00234_DS_
_00224_DS_
;	.line	519; "stepmotor2.c"	if (MINSENSOR) {
	BANKSEL	_PORTB_bits
	BTFSS	_PORTB_bits,0
	GOTO	_00226_DS_
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	520; "stepmotor2.c"	currentPosition.bytes[0] = 0;
	BANKSEL	_currentPosition
	CLRF	(_currentPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	521; "stepmotor2.c"	currentPosition.bytes[1] = 0;
	CLRF	(_currentPosition + 1)
;	.line	522; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
	GOTO	_00227_DS_
_00226_DS_
;	.line	524; "stepmotor2.c"	reverse1();
	CALL	_reverse1
_00227_DS_
;	.line	526; "stepmotor2.c"	if (function == func_idle && seekNotify != 255) {
	MOVLW	0x00
	BANKSEL	_function
	IORWF	_function,W
	BTFSS	STATUS,2
	GOTO	_00234_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	527; "stepmotor2.c"	if (sendMessageISR(seekNotify)) {
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00234_DS_
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x1021
	MOVWF	r0x1021
	MOVF	r0x1021,W
	BTFSC	STATUS,2
	GOTO	_00229_DS_
;	.line	528; "stepmotor2.c"	sendDataByteISR(CMD_HOMERESET);
	MOVLW	0x10
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	529; "stepmotor2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
	GOTO	_00234_DS_
_00229_DS_
;	.line	532; "stepmotor2.c"	function = func_homereset;
	MOVLW	0x08
	BANKSEL	_function
	MOVWF	_function
_00234_DS_
;	.line	537; "stepmotor2.c"	setTimer(speed);
	BANKSEL	_speed
	MOVF	_speed,W
	CALL	_setTimer
	BANKSEL _coilPosition
	RETURN	
; exit point of _timerTick

;***
;  pBlock Stats: dbName = C
;***
;entry:  _dda_step	;Function start
; 2 exit points
;has an exit
;functions called:
;   _forward1
;   _reverse1
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _strobe_sync
;   _forward1
;   _reverse1
;   _sendMessageISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _sendDataByteISR
;   _endMessageISR
;   _strobe_sync
;5 compiler assigned registers:
;   r0x101D
;   r0x101E
;   r0x101F
;   r0x1020
;   r0x1021
;; Starting pCode block
_dda_step	;Function start
; 2 exit points
;	.line	413; "stepmotor2.c"	if (currentPosition.ival == seekPosition.ival) {
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101E
	MOVWF	r0x101E
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101F
	MOVWF	r0x101F
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	r0x101F,W
	XORWF	r0x101D,W
	BTFSS	STATUS,2
	GOTO	_00163_DS_
	MOVF	r0x1020,W
	XORWF	r0x101E,W
	BTFSS	STATUS,2
	GOTO	_00163_DS_
;	.line	414; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
	GOTO	_00164_DS_
_00163_DS_
;	.line	415; "stepmotor2.c"	} else if (currentPosition.ival < seekPosition.ival) {
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
;;115	MOVF	(_currentPosition + 1),W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 0),W
	BANKSEL	r0x101F
	MOVWF	r0x101F
;;105	MOVF	(_seekPosition + 1),W
;;114	MOVF	r0x101E,W
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101E
	MOVWF	r0x101E
	ADDLW	0x80
	MOVWF	r0x1021
;;104	MOVF	r0x1020,W
	BANKSEL	_seekPosition
	MOVF	(_seekPosition + 1),W
	BANKSEL	r0x1020
	MOVWF	r0x1020
	ADDLW	0x80
	SUBWF	r0x1021,W
	BTFSS	STATUS,2
	GOTO	_00185_DS_
	MOVF	r0x101F,W
	SUBWF	r0x101D,W
_00185_DS_
	BTFSC	STATUS,0
	GOTO	_00160_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
;	.line	416; "stepmotor2.c"	forward1();
	CALL	_forward1
	GOTO	_00164_DS_
_00160_DS_
;	.line	418; "stepmotor2.c"	reverse1();
	CALL	_reverse1
_00164_DS_
;	.line	420; "stepmotor2.c"	if (function == func_idle && seekNotify != 255) {
	MOVLW	0x00
	BANKSEL	_function
	IORWF	_function,W
	BTFSS	STATUS,2
	GOTO	_00173_DS_
	BANKSEL	_seekNotify
	MOVF	_seekNotify,W
;	.line	421; "stepmotor2.c"	if (sendMessageISR(seekNotify)) { 
	XORLW	0xff
	BTFSC	STATUS,2
	GOTO	_00173_DS_
	MOVF	_seekNotify,W
	PAGESEL	_sendMessageISR
	CALL	_sendMessageISR
	PAGESEL	$
	BANKSEL	r0x101D
	MOVWF	r0x101D
	MOVF	r0x101D,W
	BTFSC	STATUS,2
	GOTO	_00166_DS_
;	.line	422; "stepmotor2.c"	sendDataByteISR(CMD_DDA);
	MOVLW	0x0b
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	423; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[0]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	424; "stepmotor2.c"	sendDataByteISR(currentPosition.bytes[1]);
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	PAGESEL	_sendDataByteISR
	CALL	_sendDataByteISR
	PAGESEL	$
;	.line	425; "stepmotor2.c"	endMessageISR();
	PAGESEL	_endMessageISR
	CALL	_endMessageISR
	PAGESEL	$
	GOTO	_00003_DS_
_00166_DS_
;	.line	428; "stepmotor2.c"	function = func_ddamaster;
	MOVLW	0x07
	BANKSEL	_function
	MOVWF	_function
	GOTO	_00003_DS_
_00173_DS_
;	.line	430; "stepmotor2.c"	} else if (function != func_idle) {
	MOVLW	0x00
	BANKSEL	_function
	IORWF	_function,W
	BTFSC	STATUS,2
	GOTO	_00003_DS_
;;113	MOVF	(_dda_deltay + 0),W
;;103	MOVF	(_dda_deltay + 1),W
;;112	MOVF	r0x101D,W
;	.line	431; "stepmotor2.c"	dda_error += dda_deltay.ival;
	BANKSEL	_dda_deltay
	MOVF	(_dda_deltay + 0),W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	BANKSEL	_dda_error
	ADDWF	_dda_error,F
;;102	MOVF	r0x101E,W
	BANKSEL	_dda_deltay
	MOVF	(_dda_deltay + 1),W
	BANKSEL	r0x101E
	MOVWF	r0x101E
	BTFSC	STATUS,0
	INCF	r0x101E,W
	BTFSC	STATUS,2
	GOTO	_00002_DS_
	BANKSEL	_dda_error
	ADDWF	(_dda_error + 1),F
_00002_DS_
;	.line	432; "stepmotor2.c"	if ((dda_error + dda_error) > dda_deltax) {
	BCF	STATUS,0
	BANKSEL	_dda_error
	RLF	_dda_error,W
	BANKSEL	r0x101D
	MOVWF	r0x101D
	BANKSEL	_dda_error
	RLF	(_dda_error + 1),W
	BANKSEL	r0x101E
	MOVWF	r0x101E
	BANKSEL	_dda_deltax
	MOVF	(_dda_deltax + 1),W
	ADDLW	0x80
	BANKSEL	r0x1021
	MOVWF	r0x1021
	MOVF	r0x101E,W
	ADDLW	0x80
	SUBWF	r0x1021,W
	BTFSS	STATUS,2
	GOTO	_00187_DS_
	MOVF	r0x101D,W
	BANKSEL	_dda_deltax
	SUBWF	_dda_deltax,W
_00187_DS_
	BTFSC	STATUS,0
	GOTO	_00003_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
;	.line	434; "stepmotor2.c"	strobe_sync();
	CALL	_strobe_sync
;	.line	435; "stepmotor2.c"	dda_error -= dda_deltax;
	BANKSEL	_dda_deltax
	MOVF	_dda_deltax,W
	BANKSEL	_dda_error
	SUBWF	_dda_error,F
	BANKSEL	_dda_deltax
	MOVF	(_dda_deltax + 1),W
	BTFSS	STATUS,0
	INCF	(_dda_deltax + 1),W
	BTFSC	STATUS,2
	GOTO	_00003_DS_
	BANKSEL	_dda_error
	SUBWF	(_dda_error + 1),F
_00003_DS_
	RETURN	
; exit point of _dda_step

;***
;  pBlock Stats: dbName = C
;***
;entry:  _strobe_sync	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x1022
;; Starting pCode block
_strobe_sync	;Function start
; 2 exit points
;	.line	393; "stepmotor2.c"	SYNCA = 0; // Pull low
	BANKSEL	_PORTA_bits
	BCF	_PORTA_bits,1
;	.line	394; "stepmotor2.c"	SYNCA_TRIS = 0; // Set to output during stobe
	BANKSEL	_TRISA_bits
	BCF	_TRISA_bits,1
;	.line	397; "stepmotor2.c"	for(delay = 0; delay <= 254; delay++)
	MOVLW	0xff
	BANKSEL	r0x1022
	MOVWF	r0x1022
_00154_DS_
	BANKSEL	r0x1022
	DECFSZ	r0x1022,F
	GOTO	_00154_DS_
;	.line	400; "stepmotor2.c"	SYNCA_TRIS = 1; // Back to input so we don't drive the sync line
	BANKSEL	_TRISA_bits
	BSF	_TRISA_bits,1
	BANKSEL _coilPosition
	RETURN	
; exit point of _strobe_sync

;***
;  pBlock Stats: dbName = C
;***
;entry:  _setTimer	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_setTimer	;Function start
; 2 exit points
;	.line	371; "stepmotor2.c"	void setTimer(byte newspeed)
	BANKSEL	_speed
	MOVWF	_speed
;	.line	374; "stepmotor2.c"	if (speed) {
	MOVF	_speed,W
	BTFSC	STATUS,2
	GOTO	_00146_DS_
;	.line	375; "stepmotor2.c"	TMR1ON = 0;  //TMR1H, TMR1L should only be set, when TMR1ON is off
	BANKSEL	_T1CON_bits
	BCF	_T1CON_bits,0
;	.line	376; "stepmotor2.c"	TMR1H = speed;
	BANKSEL	_speed
	MOVF	_speed,W
	BANKSEL	_TMR1H
	MOVWF	_TMR1H
;	.line	377; "stepmotor2.c"	TMR1L = 0;
	CLRF	_TMR1L
;	.line	378; "stepmotor2.c"	TMR1ON = 1;
	BSF	_T1CON_bits,0
	GOTO	_00147_DS_
_00146_DS_
;	.line	380; "stepmotor2.c"	TMR1ON = 0;
	BANKSEL	_T1CON_bits
	BCF	_T1CON_bits,0
_00147_DS_
	BANKSEL _coilPosition
	RETURN	
; exit point of _setTimer

;***
;  pBlock Stats: dbName = C
;***
;entry:  _reverse1	;Function start
; 2 exit points
;has an exit
;functions called:
;   _flashLED
;   _motor_stop
;   _motor_click
;   _flashLED
;   _motor_stop
;   _motor_click
;2 compiler assigned registers:
;   r0x1015
;   r0x1016
;; Starting pCode block
_reverse1	;Function start
; 2 exit points
;	.line	353; "stepmotor2.c"	flashLED();
	PAGESEL	_flashLED
	CALL	_flashLED
	PAGESEL	$
;	.line	354; "stepmotor2.c"	if (MINSENSOR) {
	BANKSEL	_PORTB_bits
	BTFSS	_PORTB_bits,0
	GOTO	_00139_DS_
;	.line	356; "stepmotor2.c"	motor_stop();
	CALL	_motor_stop
;	.line	357; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
	GOTO	_00140_DS_
_00139_DS_
;	.line	359; "stepmotor2.c"	currentPosition.ival--;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1015
	MOVWF	r0x1015
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1016
	MOVWF	r0x1016
	MOVLW	0xff
	ADDWF	r0x1015,F
	BTFSS	STATUS,0
	DECF	r0x1016,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x1015,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x1016
	MOVF	r0x1016,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
;	.line	360; "stepmotor2.c"	coilPosition = (coilPosition + stepCount - 1) & (stepCount - 1);
	MOVLW	0x03
	BANKSEL	_coilPosition
	ADDWF	_coilPosition,W
	BANKSEL	r0x1015
	MOVWF	r0x1015
	MOVLW	0x03
	ANDWF	r0x1015,W
	BANKSEL	_coilPosition
	MOVWF	_coilPosition
;	.line	361; "stepmotor2.c"	motor_click();
	CALL	_motor_click
_00140_DS_
	BANKSEL _coilPosition;
	RETURN	
; exit point of _reverse1

;***
;  pBlock Stats: dbName = C
;***
;entry:  _forward1	;Function start
; 2 exit points
;has an exit
;functions called:
;   _flashLED
;   _motor_stop
;   _motor_click
;   _flashLED
;   _motor_stop
;   _motor_click
;2 compiler assigned registers:
;   r0x1015
;   r0x1016
;; Starting pCode block
_forward1	;Function start
; 2 exit points
;	.line	333; "stepmotor2.c"	flashLED();
	PAGESEL	_flashLED
	CALL	_flashLED
	PAGESEL	$
;	.line	334; "stepmotor2.c"	if (MAXSENSOR) {
	BANKSEL	_PORTA_bits
	BTFSS	_PORTA_bits,5
	GOTO	_00132_DS_
;	.line	336; "stepmotor2.c"	motor_stop();
	CALL	_motor_stop
;	.line	337; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
	GOTO	_00133_DS_
_00132_DS_
;	.line	339; "stepmotor2.c"	currentPosition.ival++;
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 0),W
	BANKSEL	r0x1015
	MOVWF	r0x1015
	BANKSEL	_currentPosition
	MOVF	(_currentPosition + 1),W
	BANKSEL	r0x1016
	MOVWF	r0x1016
	INCF	r0x1015,F
	BTFSC	STATUS,2
	INCF	r0x1016,F
;gen.c:9306: size=1/2, offset=0, AOP_TYPE(res)=13
	MOVF	r0x1015,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 0)
;gen.c:9306: size=0/2, offset=1, AOP_TYPE(res)=13
	BANKSEL	r0x1016
	MOVF	r0x1016,W
	BANKSEL	_currentPosition
	MOVWF	(_currentPosition + 1)
;	.line	340; "stepmotor2.c"	coilPosition = (coilPosition + 1) & (stepCount - 1);
	BANKSEL	_coilPosition
	INCF	_coilPosition,W
	BANKSEL	r0x1015
	MOVWF	r0x1015
	MOVLW	0x03
	ANDWF	r0x1015,W
	BANKSEL	_coilPosition
	MOVWF	_coilPosition
;	.line	341; "stepmotor2.c"	motor_click();
	CALL	_motor_click
_00133_DS_
	BANKSEL _coilPosition
	RETURN	
; exit point of _forward1

;***
;  pBlock Stats: dbName = C
;***
;entry:  _motor_click	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x1017
;; Starting pCode block
_motor_click	;Function start
; 2 exit points
;	.line	192; "stepmotor2.c"	cp = coilPosition << 1;
	BCF	STATUS,0
	BANKSEL	_coilPosition
	RLF	_coilPosition,W
	BANKSEL	r0x1017
	MOVWF	r0x1017
;swapping arguments (AOP_TYPEs 1/2)
;unsigned compare: left >= lit(0x8=8), size=1
;	.line	194; "stepmotor2.c"	switch(cp) {
	MOVLW	0x08
	SUBWF	r0x1017,W
	BTFSC	STATUS,0
	GOTO	_00121_DS_
;genSkipc:3694: created from rifx:0xbfaf2e00
	MOVLW	HIGH(_00126_DS_)
	MOVWF	PCLATH
	MOVLW	_00126_DS_
	ADDWF	r0x1017,W
	BTFSC	STATUS,0
	INCF	PCLATH,F
	BANKSEL	PCL
	MOVWF	PCL
_00126_DS_
	GOTO	_00120_DS_
	GOTO	_00119_DS_
	GOTO	_00118_DS_
	GOTO	_00117_DS_
	GOTO	_00116_DS_
	GOTO	_00115_DS_
	GOTO	_00114_DS_
	GOTO	_00113_DS_
_00113_DS_
;	.line	197; "stepmotor2.c"	RB5 = 1;
	BANKSEL	_PORTB_bits
	BSF	_PORTB_bits,5
;	.line	198; "stepmotor2.c"	RB4 = 0;
	BCF	_PORTB_bits,4
;	.line	199; "stepmotor2.c"	RA2 = 1;
	BSF	_PORTA_bits,2
;	.line	200; "stepmotor2.c"	RA0 = 0;
	BCF	_PORTA_bits,0
;	.line	201; "stepmotor2.c"	break;
	GOTO	_00121_DS_
_00114_DS_
;	.line	204; "stepmotor2.c"	RB5 = 1;
	BANKSEL	_PORTB_bits
	BSF	_PORTB_bits,5
;	.line	205; "stepmotor2.c"	RB4 = 0;
	BCF	_PORTB_bits,4
;	.line	206; "stepmotor2.c"	RA2 = 0;
	BCF	_PORTA_bits,2
;	.line	207; "stepmotor2.c"	RA0 = 0;
	BCF	_PORTA_bits,0
;	.line	208; "stepmotor2.c"	break;    
	GOTO	_00121_DS_
_00115_DS_
;	.line	211; "stepmotor2.c"	RB5 = 1;
	BANKSEL	_PORTB_bits
	BSF	_PORTB_bits,5
;	.line	212; "stepmotor2.c"	RB4 = 0;
	BCF	_PORTB_bits,4
;	.line	213; "stepmotor2.c"	RA2 = 0;
	BCF	_PORTA_bits,2
;	.line	214; "stepmotor2.c"	RA0 = 1;
	BSF	_PORTA_bits,0
;	.line	215; "stepmotor2.c"	break;     
	GOTO	_00121_DS_
_00116_DS_
;	.line	218; "stepmotor2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	219; "stepmotor2.c"	RB4 = 0;
	BCF	_PORTB_bits,4
;	.line	220; "stepmotor2.c"	RA2 = 0;
	BCF	_PORTA_bits,2
;	.line	221; "stepmotor2.c"	RA0 = 1;
	BSF	_PORTA_bits,0
;	.line	222; "stepmotor2.c"	break;     
	GOTO	_00121_DS_
_00117_DS_
;	.line	225; "stepmotor2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	226; "stepmotor2.c"	RB4 = 1;
	BSF	_PORTB_bits,4
;	.line	227; "stepmotor2.c"	RA2 = 0;
	BCF	_PORTA_bits,2
;	.line	228; "stepmotor2.c"	RA0 = 1;
	BSF	_PORTA_bits,0
;	.line	229; "stepmotor2.c"	break;     
	GOTO	_00121_DS_
_00118_DS_
;	.line	232; "stepmotor2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	233; "stepmotor2.c"	RB4 = 1;
	BSF	_PORTB_bits,4
;	.line	234; "stepmotor2.c"	RA2 = 0;
	BCF	_PORTA_bits,2
;	.line	235; "stepmotor2.c"	RA0 = 0;
	BCF	_PORTA_bits,0
;	.line	236; "stepmotor2.c"	break;    
	GOTO	_00121_DS_
_00119_DS_
;	.line	239; "stepmotor2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	240; "stepmotor2.c"	RB4 = 1;
	BSF	_PORTB_bits,4
;	.line	241; "stepmotor2.c"	RA2 = 1;
	BSF	_PORTA_bits,2
;	.line	242; "stepmotor2.c"	RA0 = 0;
	BCF	_PORTA_bits,0
;	.line	243; "stepmotor2.c"	break;    
	GOTO	_00121_DS_
_00120_DS_
;	.line	246; "stepmotor2.c"	RB5 = 0;
	BANKSEL	_PORTB_bits
	BCF	_PORTB_bits,5
;	.line	247; "stepmotor2.c"	RB4 = 0;
	BCF	_PORTB_bits,4
;	.line	248; "stepmotor2.c"	RA2 = 1;
	BSF	_PORTA_bits,2
;	.line	249; "stepmotor2.c"	RA0 = 0;
	BCF	_PORTA_bits,0
_00121_DS_
	BANKSEL _coilPosition
	RETURN	
; exit point of _motor_click

;***
;  pBlock Stats: dbName = C
;***
;entry:  _motor_stop	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_motor_stop	;Function start
; 2 exit points
;	.line	169; "stepmotor2.c"	PORTB = PORTB & BIN(11001111);
	MOVLW	0xcf
	BANKSEL	_PORTB
	ANDWF	_PORTB,F
;	.line	170; "stepmotor2.c"	PORTA = PORTA & BIN(11111010);
	MOVLW	0xfa
	ANDWF	_PORTA,F
	BANKSEL _coilPosition
	RETURN	
; exit point of _motor_stop

;***
;  pBlock Stats: dbName = C
;***
;entry:  _init2	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_init2	;Function start
; 2 exit points
;	.line	148; "stepmotor2.c"	speed = 0;
	BANKSEL	_speed
	CLRF	_speed
;	.line	149; "stepmotor2.c"	function = func_idle;
	BANKSEL	_function
	CLRF	_function
;	.line	150; "stepmotor2.c"	coilPosition = 0;
	BANKSEL	_coilPosition
	CLRF	_coilPosition
;	.line	151; "stepmotor2.c"	sync_mode = sync_none;
	BANKSEL	_sync_mode
	CLRF	_sync_mode
;	.line	152; "stepmotor2.c"	seekNotify = 255;
	MOVLW	0xff
	BANKSEL	_seekNotify
	MOVWF	_seekNotify
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	154; "stepmotor2.c"	currentPosition.bytes[0] = 0;
	BANKSEL	_currentPosition
	CLRF	(_currentPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	155; "stepmotor2.c"	currentPosition.bytes[1] = 0;
	CLRF	(_currentPosition + 1)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	156; "stepmotor2.c"	seekPosition.bytes[0] = 0;
	BANKSEL	_seekPosition
	CLRF	(_seekPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	157; "stepmotor2.c"	seekPosition.bytes[1] = 0;
	CLRF	(_seekPosition + 1)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	158; "stepmotor2.c"	maxPosition.bytes[0] = 0;
	BANKSEL	_maxPosition
	CLRF	(_maxPosition + 0)
;gen.c:9306: size=0/1, offset=0, AOP_TYPE(res)=13
;	.line	159; "stepmotor2.c"	maxPosition.bytes[1] = 0;
	CLRF	(_maxPosition + 1)
	RETURN	
; exit point of _init2


;	code size estimation:
;	  749+  355 =  1104 instructions ( 2918 byte)

	end
