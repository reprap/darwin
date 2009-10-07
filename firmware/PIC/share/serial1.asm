;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.7.4 #4943 (Oct 27 2007) (UNIX)
; This file was generated Fri Jun 13 14:34:00 2008
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.module serial1
	list	p=16f648a
	radix dec
	include "p16f648a.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
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
	extern	_transmitBuffer
	extern	_sendPacket
	extern	_deviceAddress
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
	global	_serialInterruptHandler
	global	_endMessage
	global	_endMessageISR
	global	_packetReady
	global	_sendReply
	global	_sendMessage
	global	_sendMessageISR
	global	_releaseLock
	global	_sendDataByteISR
	global	_sendDataByte
	global	_uartTransmit
	global	_uartNotifyReceive
	global	_serial_init
	global	_setFlash
	global	_LEDon
	global	_flashLED
	global	_computeCRC
	global	_uartReceiveError
	global	_serialStatus

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_serial1_0	udata
_serialStatus	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_serial1_0	udata
r0x1017	res	1
r0x1018	res	1
r0x1014	res	1
r0x1015	res	1
r0x1016	res	1
r0x1019	res	1
r0x101A	res	1
r0x101B	res	1
r0x1025	res	1
r0x1026	res	1
r0x1027	res	1
r0x1028	res	1
r0x1022	res	1
r0x1023	res	1
r0x1021	res	1
r0x1020	res	1
r0x101C	res	1
r0x101D	res	1
r0x101E	res	1
r0x1012	res	1
r0x1013	res	1
_flash_count	res	1
_flash	res	1
_flashOFF	res	1
_flashON	res	1
_transmitBufferHead	res	1
_transmitBufferTail	res	1
_crc	res	1
_in_hdb2	res	1
_in_hdb1	res	1
_packetLength	res	1
_sourceAddress	res	1
_bufferIndex	res	1
_receivedSourceAddress	res	1
_sendPacketLength	res	1
_sendPacketDestination	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_serial1_0	idata
_uartState
	db	0x30

;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_serial1	code
;***
;  pBlock Stats: dbName = C
;***
;entry:  _serialInterruptHandler	;Function start
; 2 exit points
;has an exit
;functions called:
;   _uartNotifyReceive
;   _uartNotifyReceive
;2 compiler assigned registers:
;   r0x1012
;   r0x1013
;; Starting pCode block
_serialInterruptHandler	;Function start
; 2 exit points
;	.line	905; "serial1.c"	if (TXIF && TXIE) {
	BANKSEL	_PIR1_bits
	BTFSS	_PIR1_bits,4
	GOTO	_00339_DS_
	BANKSEL	_PIE1_bits
	BTFSS	_PIE1_bits,4
	GOTO	_00339_DS_
;	.line	906; "serial1.c"	if (transmitBufferHead == transmitBufferTail) {
	BANKSEL	_transmitBufferTail
	MOVF	_transmitBufferTail,W
	BANKSEL	_transmitBufferHead
	XORWF	_transmitBufferHead,W
	BTFSS	STATUS,2
	GOTO	_00336_DS_
;	.line	908; "serial1.c"	if (TRMT) 
	BANKSEL	_TXSTA_bits
	BTFSS	_TXSTA_bits,1
	GOTO	_00339_DS_
;	.line	909; "serial1.c"	TXIE = 0;
	BCF	_PIE1_bits,4
	GOTO	_00339_DS_
_00336_DS_
;	.line	911; "serial1.c"	TXREG = transmitBuffer[transmitBufferHead];
	BANKSEL	_transmitBufferHead
	MOVF	_transmitBufferHead,W
	ADDLW	(_transmitBuffer + 0)
	BANKSEL	r0x1012
	MOVWF	r0x1012
	MOVLW	high (_transmitBuffer + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1013
	MOVF	r0x1012,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1013,0
	BSF	STATUS,7
	MOVF	INDF,W
	BANKSEL	_TXREG
	MOVWF	_TXREG
;	.line	912; "serial1.c"	transmitBufferHead++;
	BANKSEL	_transmitBufferHead
	INCF	_transmitBufferHead,F
;unsigned compare: left < lit(0x10=16), size=1
;	.line	913; "serial1.c"	if (transmitBufferHead >= MAX_TRANSMIT_BUFFER)
	MOVLW	0x10
;	.line	914; "serial1.c"	transmitBufferHead = 0;
	SUBWF	_transmitBufferHead,W
;	.line	928; "serial1.c"	if (RCIF) {
	BTFSC	STATUS,0
	CLRF	_transmitBufferHead
_00339_DS_
	BANKSEL	_PIR1_bits
	BTFSS	_PIR1_bits,5
	GOTO	_00342_DS_
;	.line	929; "serial1.c"	uartNotifyReceive();
	CALL	_uartNotifyReceive
_00342_DS_
	BANKSEL _uartState;
	RETURN	
; exit point of _serialInterruptHandler

;***
;  pBlock Stats: dbName = C
;***
;entry:  _endMessage	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _endMessageIntern
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _endMessageIntern
;; Starting pCode block
_endMessage	;Function start
; 2 exit points
;	.line	881; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
_00324_DS_
;	.line	883; "serial1.c"	while (serialStatus & inTransmitMsgBit) {
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,1
	GOTO	_00326_DS_
;	.line	884; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	885; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	886; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	887; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	888; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	889; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	890; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
	GOTO	_00324_DS_
_00326_DS_
;	.line	892; "serial1.c"	endMessageIntern();
	CALL	_endMessageIntern
;	.line	893; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
	RETURN	
; exit point of _endMessage

;***
;  pBlock Stats: dbName = C
;***
;entry:  _endMessageISR	;Function start
; 2 exit points
;has an exit
;functions called:
;   _endMessageIntern
;   _endMessageIntern
;; Starting pCode block
_endMessageISR	;Function start
; 2 exit points
;	.line	867; "serial1.c"	endMessageIntern();
	CALL	_endMessageIntern
	RETURN	
; exit point of _endMessageISR

;***
;  pBlock Stats: dbName = C
;***
;entry:  _endMessageIntern	;Function start
; 2 exit points
;has an exit
;functions called:
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;4 compiler assigned registers:
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;; Starting pCode block
_endMessageIntern	;Function start
; 2 exit points
;	.line	840; "serial1.c"	if (serialStatus & inSendQueueMsgBit) {  
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,2
	GOTO	_00315_DS_
;	.line	844; "serial1.c"	uartTransmit(SNAP_SYNC);
	MOVLW	0x54
	CALL	_uartTransmit
;	.line	845; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	846; "serial1.c"	uartTransmit(computeCRC(BIN(01010001)));   // Request ACK
	MOVLW	0x51
	CALL	_computeCRC
	BANKSEL	r0x101C
	MOVWF	r0x101C
	CALL	_uartTransmit
;	.line	847; "serial1.c"	uartTransmit(computeCRC(BIN(00110000) | sendPacketLength));
	MOVLW	0x30
	BANKSEL	_sendPacketLength
	IORWF	_sendPacketLength,W
	BANKSEL	r0x101C
	MOVWF	r0x101C
	CALL	_computeCRC
	BANKSEL	r0x101C
	MOVWF	r0x101C
	CALL	_uartTransmit
;	.line	848; "serial1.c"	uartTransmit(computeCRC(sendPacketDestination));
	BANKSEL	_sendPacketDestination
	MOVF	_sendPacketDestination,W
	CALL	_computeCRC
	BANKSEL	r0x101C
	MOVWF	r0x101C
	CALL	_uartTransmit
;	.line	849; "serial1.c"	uartTransmit(computeCRC(deviceAddress));
	BANKSEL	_deviceAddress
	MOVF	_deviceAddress,W
	CALL	_computeCRC
	BANKSEL	r0x101C
	MOVWF	r0x101C
	CALL	_uartTransmit
;	.line	850; "serial1.c"	for(i = 0; i < sendPacketLength; i++)
	BANKSEL	r0x101C
	CLRF	r0x101C
_00311_DS_
	BANKSEL	_sendPacketLength
	MOVF	_sendPacketLength,W
	BANKSEL	r0x101C
	SUBWF	r0x101C,W
	BTFSC	STATUS,0
	GOTO	_00314_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;	.line	851; "serial1.c"	uartTransmit(computeCRC(sendPacket[i]));
	MOVF	r0x101C,W
	ADDLW	(_sendPacket + 0)
	MOVWF	r0x101D
	MOVLW	high (_sendPacket + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x101E
	MOVF	r0x101D,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x101E,0
	BSF	STATUS,7
	MOVF	INDF,W
;;1	MOVWF	r0x101F
	CALL	_computeCRC
	BANKSEL	r0x101D
	MOVWF	r0x101D
	CALL	_uartTransmit
;	.line	850; "serial1.c"	for(i = 0; i < sendPacketLength; i++)
	BANKSEL	r0x101C
	INCF	r0x101C,F
	GOTO	_00311_DS_
_00314_DS_
;	.line	852; "serial1.c"	uartTransmit(crc); /// @todo crc here
	BANKSEL	_crc
	MOVF	_crc,W
	CALL	_uartTransmit
;	.line	854; "serial1.c"	serialStatus &= ~inSendQueueMsgBit;  //clear 
	BANKSEL	_serialStatus
	BCF	_serialStatus,2
_00315_DS_
	RETURN	
; exit point of _endMessageIntern

;***
;  pBlock Stats: dbName = C
;***
;entry:  _packetReady	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x1020
;; Starting pCode block
_packetReady	;Function start
; 2 exit points
;	.line	821; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	822; "serial1.c"	ready = (serialStatus & processingLockBit);
	MOVLW	0x80
	BANKSEL	_serialStatus
	ANDWF	_serialStatus,W
	BANKSEL	r0x1020
	MOVWF	r0x1020
;	.line	823; "serial1.c"	if (transmitBufferHead != transmitBufferTail)
	BANKSEL	_transmitBufferTail
	MOVF	_transmitBufferTail,W
;	.line	824; "serial1.c"	ready = 0;
	BANKSEL	_transmitBufferHead
	XORWF	_transmitBufferHead,W
;	.line	825; "serial1.c"	GIE=1;
	BTFSC	STATUS,2
	GOTO	_00001_DS_
	BANKSEL	r0x1020
	CLRF	r0x1020
_00001_DS_
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	826; "serial1.c"	return ready;
	BANKSEL	r0x1020
	MOVF	r0x1020,W
	RETURN	
; exit point of _packetReady

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendReply	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sendMessage
;   _sendMessage
;; Starting pCode block
_sendReply	;Function start
; 2 exit points
;	.line	809; "serial1.c"	sendMessage(receivedSourceAddress);
	BANKSEL	_receivedSourceAddress
	MOVF	_receivedSourceAddress,W
	CALL	_sendMessage
	RETURN	
; exit point of _sendReply

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendMessage	;Function start
; 2 exit points
;has an exit
;functions called:
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _sendMessageIntern
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _delay_10us
;   _sendMessageIntern
;1 compiler assigned register :
;   r0x1021
;; Starting pCode block
_sendMessage	;Function start
; 2 exit points
;	.line	786; "serial1.c"	void sendMessage(byte dest)
	BANKSEL	r0x1021
	MOVWF	r0x1021
;	.line	788; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
_00288_DS_
;	.line	789; "serial1.c"	while (serialStatus & inSendQueueMsgBit) { 
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,2
	GOTO	_00290_DS_
;	.line	791; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
;	.line	792; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	793; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	794; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	795; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	796; "serial1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	797; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
	GOTO	_00288_DS_
_00290_DS_
;	.line	800; "serial1.c"	sendMessageIntern(dest);
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	CALL	_sendMessageIntern
;	.line	801; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
	RETURN	
; exit point of _sendMessage

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendMessageISR	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sendMessageIntern
;   _sendMessageIntern
;1 compiler assigned register :
;   r0x1023
;; Starting pCode block
_sendMessageISR	;Function start
; 2 exit points
;	.line	759; "serial1.c"	byte sendMessageISR(byte dest)
	BANKSEL	r0x1023
	MOVWF	r0x1023
;	.line	766; "serial1.c"	if ((serialStatus & inSendQueueMsgBit) || (serialStatus & inTransmitMsgBit) ||
	BANKSEL	_serialStatus
	BTFSC	_serialStatus,2
	GOTO	_00274_DS_
	BTFSC	_serialStatus,1
	GOTO	_00274_DS_
;	.line	767; "serial1.c"	(transmitBufferHead != transmitBufferTail)) {
	BANKSEL	_transmitBufferTail
	MOVF	_transmitBufferTail,W
;	.line	768; "serial1.c"	return 0; 
	BANKSEL	_transmitBufferHead
	XORWF	_transmitBufferHead,W
	BTFSC	STATUS,2
	GOTO	_00275_DS_
_00274_DS_
	MOVLW	0x00
	GOTO	_00279_DS_
_00275_DS_
;	.line	770; "serial1.c"	sendMessageIntern(dest);	  
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	CALL	_sendMessageIntern
;	.line	772; "serial1.c"	return 1;
	MOVLW	0x01
_00279_DS_
	RETURN	
; exit point of _sendMessageISR

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendMessageIntern	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   r0x1022
;; Starting pCode block
_sendMessageIntern	;Function start
; 2 exit points
;	.line	745; "serial1.c"	static void sendMessageIntern(byte dest)
	BANKSEL	r0x1022
	MOVWF	r0x1022
;	.line	747; "serial1.c"	serialStatus |= inSendQueueMsgBit; //set bit
	BANKSEL	_serialStatus
	BSF	_serialStatus,2
;	.line	748; "serial1.c"	sendPacketDestination = dest;
	BANKSEL	r0x1022
	MOVF	r0x1022,W
	BANKSEL	_sendPacketDestination
	MOVWF	_sendPacketDestination
;	.line	749; "serial1.c"	sendPacketLength = 0;
	BANKSEL	_sendPacketLength
	CLRF	_sendPacketLength
	RETURN	
; exit point of _sendMessageIntern

;***
;  pBlock Stats: dbName = C
;***
;entry:  _releaseLock	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_releaseLock	;Function start
; 2 exit points
;	.line	735; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	736; "serial1.c"	serialStatus &= ~processingLockBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,7
;	.line	737; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
	RETURN	
; exit point of _releaseLock

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendDataByteISR	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sendDataByteIntern
;   _sendDataByteIntern
;1 compiler assigned register :
;   r0x1024
;; Starting pCode block
_sendDataByteISR	;Function start
; 2 exit points
;;1	MOVWF	r0x1024
;	.line	726; "serial1.c"	sendDataByteIntern(c);
	CALL	_sendDataByteIntern
	RETURN	
; exit point of _sendDataByteISR

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendDataByte	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sendDataByteIntern
;   _sendDataByteIntern
;1 compiler assigned register :
;   r0x1028
;; Starting pCode block
_sendDataByte	;Function start
; 2 exit points
;	.line	713; "serial1.c"	void sendDataByte(byte c)
	BANKSEL	r0x1028
	MOVWF	r0x1028
;	.line	715; "serial1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	716; "serial1.c"	sendDataByteIntern(c);
	BANKSEL	r0x1028
	MOVF	r0x1028,W
	CALL	_sendDataByteIntern
;	.line	717; "serial1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
	RETURN	
; exit point of _sendDataByte

;***
;  pBlock Stats: dbName = C
;***
;entry:  _sendDataByteIntern	;Function start
; 2 exit points
;has an exit
;3 compiler assigned registers:
;   r0x1025
;   r0x1026
;   r0x1027
;; Starting pCode block
_sendDataByteIntern	;Function start
; 2 exit points
;	.line	694; "serial1.c"	static void sendDataByteIntern(byte c)
	BANKSEL	r0x1025
	MOVWF	r0x1025
;	.line	696; "serial1.c"	if (serialStatus & inSendQueueMsgBit)  {
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,2
	GOTO	_00253_DS_
;unsigned compare: left < lit(0x10=16), size=1
;	.line	700; "serial1.c"	if (sendPacketLength < MAX_PAYLOAD)
	MOVLW	0x10
	BANKSEL	_sendPacketLength
	SUBWF	_sendPacketLength,W
	BTFSC	STATUS,0
	GOTO	_00253_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;	.line	701; "serial1.c"	sendPacket[sendPacketLength++] = c;
	MOVF	_sendPacketLength,W
	BANKSEL	r0x1026
	MOVWF	r0x1026
	BANKSEL	_sendPacketLength
	INCF	_sendPacketLength,F
	BANKSEL	r0x1026
	MOVF	r0x1026,W
	ADDLW	(_sendPacket + 0)
	MOVWF	r0x1026
	MOVLW	high (_sendPacket + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1027
	MOVF	r0x1026,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1027,0
	BSF	STATUS,7
	MOVF	r0x1025,W
	MOVWF	INDF
_00253_DS_
	BANKSEL _uartState;
	RETURN	
; exit point of _sendDataByteIntern

;***
;  pBlock Stats: dbName = C
;***
;entry:  _uartTransmit	;Function start
; 2 exit points
;has an exit
;4 compiler assigned registers:
;   r0x1018
;   r0x1019
;   r0x101A
;   r0x101B
;; Starting pCode block
_uartTransmit	;Function start
; 2 exit points
;	.line	663; "serial1.c"	void uartTransmit(byte c)
	BANKSEL	r0x1018
	MOVWF	r0x1018
;	.line	668; "serial1.c"	newTail = transmitBufferTail + 1;
	BANKSEL	_transmitBufferTail
	INCF	_transmitBufferTail,W
	BANKSEL	r0x1019
	MOVWF	r0x1019
;unsigned compare: left < lit(0x10=16), size=1
;	.line	669; "serial1.c"	if (newTail >= MAX_TRANSMIT_BUFFER)
	MOVLW	0x10
;	.line	670; "serial1.c"	newTail = 0;
	SUBWF	r0x1019,W
;	.line	674; "serial1.c"	if (newTail != transmitBufferHead) {
	BTFSC	STATUS,0
	CLRF	r0x1019
	BANKSEL	_transmitBufferHead
	MOVF	_transmitBufferHead,W
;	.line	675; "serial1.c"	transmitBuffer[transmitBufferTail] = c;
	BANKSEL	r0x1019
	XORWF	r0x1019,W
	BTFSC	STATUS,2
	GOTO	_00238_DS_
	BANKSEL	_transmitBufferTail
	MOVF	_transmitBufferTail,W
	ADDLW	(_transmitBuffer + 0)
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVLW	high (_transmitBuffer + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x101B
	MOVF	r0x101A,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x101B,0
	BSF	STATUS,7
	MOVF	r0x1018,W
	MOVWF	INDF
;	.line	676; "serial1.c"	transmitBufferTail = newTail;
	MOVF	r0x1019,W
	BANKSEL	_transmitBufferTail
	MOVWF	_transmitBufferTail
;	.line	678; "serial1.c"	if (TXIE == 0) {
	BANKSEL	_PIE1_bits
	BTFSC	_PIE1_bits,4
	GOTO	_00238_DS_
;	.line	679; "serial1.c"	TXIE=1; //enabling TXIE sets also TXIF
	BSF	_PIE1_bits,4
_00238_DS_
	BANKSEL _uartState;
	RETURN	
; exit point of _uartTransmit

;***
;  pBlock Stats: dbName = C
;***
;entry:  _uartNotifyReceive	;Function start
; 2 exit points
;has an exit
;functions called:
;   _uartReceiveError
;   _uartReceiveError
;   _computeCRC
;   _uartReceiveError
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _computeCRC
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartReceiveError
;   _uartReceiveError
;   _uartReceiveError
;   _computeCRC
;   _uartReceiveError
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _computeCRC
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _computeCRC
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartTransmit
;   _uartReceiveError
;3 compiler assigned registers:
;   r0x1014
;   r0x1015
;   r0x1016
;; Starting pCode block
_uartNotifyReceive	;Function start
; 2 exit points
;	.line	434; "serial1.c"	c = RCREG;
	BANKSEL	_RCREG
	MOVF	_RCREG,W
;	.line	439; "serial1.c"	if (OERR) {
	BANKSEL	r0x1014
	MOVWF	r0x1014
;	.line	440; "serial1.c"	CREN = 0;
	BANKSEL	_RCSTA_bits
	BTFSC	_RCSTA_bits,1
;	.line	445; "serial1.c"	CREN = 1;
	BCF	_RCSTA_bits,4
	BSF	_RCSTA_bits,4
;	.line	447; "serial1.c"	if (serialStatus & serialErrorBit) {
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,0
	GOTO	_00159_DS_
;	.line	448; "serial1.c"	uartReceiveError();
	CALL	_uartReceiveError
;	.line	449; "serial1.c"	return;
	GOTO	_00204_DS_
_00159_DS_
;	.line	453; "serial1.c"	switch(uartState) {
	BANKSEL	_uartState
	MOVF	_uartState,W
	BANKSEL	r0x1015
	MOVWF	r0x1015
;unsigned compare: left < lit(0x30=48), size=1
	MOVLW	0x30
	SUBWF	r0x1015,W
	BTFSS	STATUS,0
	GOTO	_00202_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;swapping arguments (AOP_TYPEs 1/2)
;unsigned compare: left >= lit(0x3B=59), size=1
	MOVLW	0x3b
	SUBWF	r0x1015,W
	BTFSC	STATUS,0
	GOTO	_00202_DS_
;genSkipc:3694: created from rifx:0xbffdc340
	MOVLW	0xd0
	ADDWF	r0x1015,F
	MOVLW	HIGH(_00224_DS_)
	MOVWF	PCLATH
	MOVLW	_00224_DS_
	ADDWF	r0x1015,W
	BTFSC	STATUS,0
	INCF	PCLATH,F
	BANKSEL	PCL
	MOVWF	PCL
_00224_DS_
	GOTO	_00160_DS_
	GOTO	_00163_DS_
	GOTO	_00170_DS_
	GOTO	_00176_DS_
	GOTO	_00180_DS_
	GOTO	_00184_DS_
	GOTO	_00187_DS_
	GOTO	_00193_DS_
	GOTO	_00196_DS_
	GOTO	_00197_DS_
	GOTO	_00198_DS_
_00160_DS_
;	.line	459; "serial1.c"	if (c == SNAP_SYNC) {
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	XORLW	0x54
	BTFSS	STATUS,2
	GOTO	_00204_DS_
;	.line	460; "serial1.c"	uartState = SNAP_haveSync;
	MOVLW	0x31
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	461; "serial1.c"	serialStatus &= ~msgAbortedBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,3
;	.line	463; "serial1.c"	break;
	GOTO	_00204_DS_
_00163_DS_
;	.line	472; "serial1.c"	in_hdb2 = c;
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	BANKSEL	_in_hdb2
	MOVWF	_in_hdb2
;	.line	473; "serial1.c"	if ((c & BIN(11111100)) != BIN(01010000)) {
	MOVLW	0xfc
	BANKSEL	r0x1014
	ANDWF	r0x1014,W
	MOVWF	r0x1015
;	.line	475; "serial1.c"	serialStatus |= serialErrorBit;  //set serialError
	XORLW	0x50
	BTFSC	STATUS,2
	GOTO	_00168_DS_
	BANKSEL	_serialStatus
	BSF	_serialStatus,0
;	.line	476; "serial1.c"	serialStatus |= wrongByteErrorBit; 
	BSF	_serialStatus,5
;	.line	477; "serial1.c"	uartReceiveError();
	CALL	_uartReceiveError
	GOTO	_00204_DS_
_00168_DS_
;	.line	480; "serial1.c"	if ((c & BIN(00000011)) == BIN(00000001))
	MOVLW	0x03
	BANKSEL	r0x1014
	ANDWF	r0x1014,W
	MOVWF	r0x1015
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00165_DS_
;	.line	481; "serial1.c"	serialStatus |= ackRequestedBit;  //set ackRequested-Bit
	BANKSEL	_serialStatus
	BSF	_serialStatus,6
	GOTO	_00166_DS_
_00165_DS_
;	.line	483; "serial1.c"	serialStatus &= ~ackRequestedBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,6
_00166_DS_
;	.line	484; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	485; "serial1.c"	computeCRC(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	CALL	_computeCRC
;	.line	486; "serial1.c"	uartState = SNAP_haveHDB2;
	MOVLW	0x32
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	488; "serial1.c"	break;
	GOTO	_00204_DS_
_00170_DS_
;	.line	494; "serial1.c"	in_hdb1 = c;
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	BANKSEL	_in_hdb1
	MOVWF	_in_hdb1
;	.line	495; "serial1.c"	if ((c & BIN(11110000)) != BIN(00110000)) {
	MOVLW	0xf0
	BANKSEL	r0x1014
	ANDWF	r0x1014,W
	MOVWF	r0x1015
;	.line	496; "serial1.c"	serialStatus |= serialErrorBit;  //set serialError
	XORLW	0x30
	BTFSC	STATUS,2
	GOTO	_00174_DS_
	BANKSEL	_serialStatus
	BSF	_serialStatus,0
;	.line	497; "serial1.c"	serialStatus |= wrongByteErrorBit; 
	BSF	_serialStatus,5
;	.line	498; "serial1.c"	uartReceiveError();
	CALL	_uartReceiveError
	GOTO	_00204_DS_
_00174_DS_
;	.line	500; "serial1.c"	packetLength = c & 0x0f;
	MOVLW	0x0f
	BANKSEL	r0x1014
	ANDWF	r0x1014,W
	BANKSEL	_packetLength
	MOVWF	_packetLength
;swapping arguments (AOP_TYPEs 1/3)
;unsigned compare: left >= lit(0x11=17), size=1
;	.line	501; "serial1.c"	if (packetLength > MAX_PAYLOAD)
	MOVLW	0x11
	SUBWF	_packetLength,W
	BTFSS	STATUS,0
	GOTO	_00172_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;	.line	502; "serial1.c"	packetLength = MAX_PAYLOAD;
	MOVLW	0x10
	MOVWF	_packetLength
_00172_DS_
;	.line	503; "serial1.c"	computeCRC(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	CALL	_computeCRC
;	.line	504; "serial1.c"	uartState = SNAP_haveHDB1;
	MOVLW	0x33
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	506; "serial1.c"	break;
	GOTO	_00204_DS_
_00176_DS_
;	.line	511; "serial1.c"	if (c != deviceAddress) {
	BANKSEL	_deviceAddress
	MOVF	_deviceAddress,W
;	.line	512; "serial1.c"	uartTransmit(SNAP_SYNC);
	BANKSEL	r0x1014
	XORWF	r0x1014,W
	BTFSC	STATUS,2
	GOTO	_00178_DS_
	MOVLW	0x54
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	513; "serial1.c"	uartTransmit(in_hdb2);
	BANKSEL	_in_hdb2
	MOVF	_in_hdb2,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	514; "serial1.c"	uartTransmit(in_hdb1);
	BANKSEL	_in_hdb1
	MOVF	_in_hdb1,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	515; "serial1.c"	uartTransmit(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	516; "serial1.c"	uartState = SNAP_haveDABPass;
	MOVLW	0x39
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	517; "serial1.c"	serialStatus &= ~ackRequestedBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,6
;	.line	518; "serial1.c"	serialStatus |= inTransmitMsgBit; 
	BSF	_serialStatus,1
	GOTO	_00204_DS_
_00178_DS_
;	.line	520; "serial1.c"	computeCRC(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	CALL	_computeCRC
;	.line	521; "serial1.c"	uartState = SNAP_haveDAB;
	MOVLW	0x34
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	523; "serial1.c"	break;
	GOTO	_00204_DS_
_00180_DS_
;	.line	535; "serial1.c"	if (serialStatus & processingLockBit) {
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,7
	GOTO	_00182_DS_
;	.line	537; "serial1.c"	uartTransmit(SNAP_SYNC);
	MOVLW	0x54
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	538; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	539; "serial1.c"	uartTransmit(computeCRC(BIN(01010011))); //HDB2
	MOVLW	0x53
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	541; "serial1.c"	uartTransmit(computeCRC(BIN(00110000)));  //HDB1
	MOVLW	0x30
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	542; "serial1.c"	uartTransmit(computeCRC(sourceAddress));  // Return to sender
	BANKSEL	_sourceAddress
	MOVF	_sourceAddress,W
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	543; "serial1.c"	uartTransmit(computeCRC(deviceAddress));  // From us
	BANKSEL	_deviceAddress
	MOVF	_deviceAddress,W
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	551; "serial1.c"	uartTransmit(crc);  // CRC
	BANKSEL	_crc
	MOVF	_crc,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	552; "serial1.c"	serialStatus &= ~ackRequestedBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,6
;	.line	553; "serial1.c"	serialStatus |= msgAbortedBit; //set
	BSF	_serialStatus,3
;	.line	554; "serial1.c"	uartState = SNAP_idle;
	MOVLW	0x30
	BANKSEL	_uartState
	MOVWF	_uartState
	GOTO	_00204_DS_
_00182_DS_
;	.line	556; "serial1.c"	sourceAddress = c;
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	BANKSEL	_sourceAddress
	MOVWF	_sourceAddress
;	.line	557; "serial1.c"	bufferIndex = 0;
	BANKSEL	_bufferIndex
	CLRF	_bufferIndex
;	.line	558; "serial1.c"	computeCRC(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	CALL	_computeCRC
;	.line	559; "serial1.c"	uartState = SNAP_readingData;
	MOVLW	0x35
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	561; "serial1.c"	break;
	GOTO	_00204_DS_
_00184_DS_
;	.line	565; "serial1.c"	buffer[bufferIndex] = c;
	BANKSEL	_bufferIndex
	MOVF	_bufferIndex,W
	ADDLW	(_buffer + 0)
	BANKSEL	r0x1015
	MOVWF	r0x1015
	MOVLW	high (_buffer + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1016
	MOVF	r0x1015,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1016,0
	BSF	STATUS,7
	MOVF	r0x1014,W
	MOVWF	INDF
;	.line	566; "serial1.c"	bufferIndex++;
	BANKSEL	_bufferIndex
	INCF	_bufferIndex,F
;	.line	567; "serial1.c"	computeCRC(c);
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	CALL	_computeCRC
;	.line	569; "serial1.c"	if (bufferIndex == packetLength)
	BANKSEL	_packetLength
	MOVF	_packetLength,W
	BANKSEL	_bufferIndex
	XORWF	_bufferIndex,W
	BTFSS	STATUS,2
	GOTO	_00204_DS_
;	.line	570; "serial1.c"	uartState = SNAP_dataComplete;
	MOVLW	0x36
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	571; "serial1.c"	break;
	GOTO	_00204_DS_
_00187_DS_
;	.line	580; "serial1.c"	if (c == crc) {
	BANKSEL	_crc
	MOVF	_crc,W
	BANKSEL	r0x1014
	XORWF	r0x1014,W
	BTFSS	STATUS,2
	GOTO	_00189_DS_
;	.line	588; "serial1.c"	hdb2 |= BIN(10);
	MOVLW	0x52
	MOVWF	r0x1015
;	.line	589; "serial1.c"	serialStatus |= processingLockBit;  //set processingLockBit
	BANKSEL	_serialStatus
	BSF	_serialStatus,7
;	.line	590; "serial1.c"	receivedSourceAddress = sourceAddress;
	BANKSEL	_sourceAddress
	MOVF	_sourceAddress,W
	BANKSEL	_receivedSourceAddress
	MOVWF	_receivedSourceAddress
	GOTO	_00190_DS_
_00189_DS_
;	.line	593; "serial1.c"	hdb2 |= BIN(11);
	MOVLW	0x53
	BANKSEL	r0x1015
	MOVWF	r0x1015
_00190_DS_
;	.line	595; "serial1.c"	if (serialStatus & ackRequestedBit) {
	BANKSEL	_serialStatus
	BTFSS	_serialStatus,6
	GOTO	_00192_DS_
;	.line	597; "serial1.c"	uartTransmit(SNAP_SYNC);
	MOVLW	0x54
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	598; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	599; "serial1.c"	uartTransmit(computeCRC(hdb2));
	BANKSEL	r0x1015
	MOVF	r0x1015,W
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	601; "serial1.c"	uartTransmit(computeCRC(BIN(00110000)));
	MOVLW	0x30
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	602; "serial1.c"	uartTransmit(computeCRC(sourceAddress));  // Return to sender
	BANKSEL	_sourceAddress
	MOVF	_sourceAddress,W
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	603; "serial1.c"	uartTransmit(computeCRC(deviceAddress));  // From us
	BANKSEL	_deviceAddress
	MOVF	_deviceAddress,W
	CALL	_computeCRC
	BANKSEL	r0x1015
	MOVWF	r0x1015
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	604; "serial1.c"	uartTransmit(crc);  // CRC
	BANKSEL	_crc
	MOVF	_crc,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	605; "serial1.c"	serialStatus &= ~ackRequestedBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,6
_00192_DS_
;	.line	608; "serial1.c"	uartState = SNAP_idle;
	MOVLW	0x30
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	609; "serial1.c"	break;
	GOTO	_00204_DS_
_00193_DS_
;	.line	613; "serial1.c"	uartTransmit(c);  // We will be reading HDB1; pass it on
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	614; "serial1.c"	packetLength = c & 0x0f;
	MOVLW	0x0f
	BANKSEL	r0x1014
	ANDWF	r0x1014,W
	BANKSEL	_packetLength
	MOVWF	_packetLength
;swapping arguments (AOP_TYPEs 1/3)
;unsigned compare: left >= lit(0x11=17), size=1
;	.line	615; "serial1.c"	if (packetLength > MAX_PAYLOAD)
	MOVLW	0x11
	SUBWF	_packetLength,W
	BTFSS	STATUS,0
	GOTO	_00195_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;	.line	616; "serial1.c"	packetLength = MAX_PAYLOAD;
	MOVLW	0x10
	MOVWF	_packetLength
_00195_DS_
;	.line	617; "serial1.c"	uartState = SNAP_haveHDB1Pass;
	MOVLW	0x38
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	618; "serial1.c"	break;
	GOTO	_00204_DS_
_00196_DS_
;	.line	622; "serial1.c"	uartTransmit(c);  // We will be reading dest addr; pass it on
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	623; "serial1.c"	uartState = SNAP_haveDABPass;
	MOVLW	0x39
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	624; "serial1.c"	break;
	GOTO	_00204_DS_
_00197_DS_
;	.line	628; "serial1.c"	uartTransmit(c);  // We will be reading source addr; pass it on
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	632; "serial1.c"	packetLength++;
	BANKSEL	_packetLength
	INCF	_packetLength,F
;	.line	634; "serial1.c"	uartState = SNAP_readingDataPass;
	MOVLW	0x3a
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	635; "serial1.c"	break;
	GOTO	_00204_DS_
_00198_DS_
;	.line	639; "serial1.c"	uartTransmit(c);  // This is a data byte; pass it on
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;swapping arguments (AOP_TYPEs 1/3)
;unsigned compare: left >= lit(0x2=2), size=1
;	.line	640; "serial1.c"	if (packetLength > 1)
	MOVLW	0x02
	BANKSEL	_packetLength
	SUBWF	_packetLength,W
	BTFSS	STATUS,0
	GOTO	_00200_DS_
;genSkipc:3694: created from rifx:0xbffdc340
;	.line	641; "serial1.c"	packetLength--;
	DECF	_packetLength,F
	GOTO	_00204_DS_
_00200_DS_
;	.line	643; "serial1.c"	uartState = SNAP_idle;
	MOVLW	0x30
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	644; "serial1.c"	serialStatus &= ~inTransmitMsgBit; //clear
	BANKSEL	_serialStatus
	BCF	_serialStatus,1
;	.line	646; "serial1.c"	break;
	GOTO	_00204_DS_
_00202_DS_
;	.line	649; "serial1.c"	serialStatus |= serialErrorBit;  //set serialError
	BANKSEL	_serialStatus
	BSF	_serialStatus,0
;	.line	650; "serial1.c"	serialStatus |= wrongStateErrorBit;  
	BSF	_serialStatus,4
;	.line	651; "serial1.c"	uartReceiveError();
	CALL	_uartReceiveError
_00204_DS_
;	.line	652; "serial1.c"	}
	RETURN	
; exit point of _uartNotifyReceive

;***
;  pBlock Stats: dbName = C
;***
;entry:  _uartReceiveError	;Function start
; 2 exit points
;has an exit
;functions called:
;   _uartTransmit
;   _uartTransmit
;1 compiler assigned register :
;   r0x1017
;; Starting pCode block
_uartReceiveError	;Function start
; 2 exit points
;	.line	404; "serial1.c"	if ((serialStatus & msgAbortedBit) == 0) {
	BANKSEL	_serialStatus
	BTFSC	_serialStatus,3
	GOTO	_00148_DS_
;	.line	406; "serial1.c"	for (i=0; i<8; i++) { //if we are sending too much for the transmit-buffer, it is discarded
	MOVLW	0x08
	BANKSEL	r0x1017
	MOVWF	r0x1017
_00151_DS_
;	.line	407; "serial1.c"	uartTransmit(0);
	MOVLW	0x00
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
	BANKSEL	r0x1017
	DECFSZ	r0x1017,F
	GOTO	_00151_DS_
_00148_DS_
;	.line	420; "serial1.c"	serialStatus = (serialStatus & msgAbortedBit); //clear all bits except msgAbortedBit;
	MOVLW	0x08
	BANKSEL	_serialStatus
	ANDWF	_serialStatus,F
;	.line	422; "serial1.c"	uartState = SNAP_idle;
	MOVLW	0x30
	BANKSEL	_uartState
	MOVWF	_uartState
	RETURN	
; exit point of _uartReceiveError

;***
;  pBlock Stats: dbName = C
;***
;entry:  _computeCRC	;Function start
; 2 exit points
;has an exit
;2 compiler assigned registers:
;   r0x1017
;   r0x1018
;; Starting pCode block
_computeCRC	;Function start
; 2 exit points
;	.line	338; "serial1.c"	byte computeCRC(byte dataval)
	BANKSEL	r0x1017
	MOVWF	r0x1017
;	.line	369; "serial1.c"	byte i = dataval ^ crc;
	BANKSEL	_crc
	XORWF	_crc,W
	BANKSEL	r0x1018
	MOVWF	r0x1018
;	.line	371; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	373; "serial1.c"	if(i & 1)
	BANKSEL	r0x1018
	BTFSS	r0x1018,0
	GOTO	_00128_DS_
;	.line	374; "serial1.c"	crc ^= 0x5e;
	MOVLW	0x5e
	BANKSEL	_crc
	XORWF	_crc,F
_00128_DS_
;	.line	375; "serial1.c"	if(i & 2)
	BANKSEL	r0x1018
	BTFSS	r0x1018,1
	GOTO	_00130_DS_
;	.line	376; "serial1.c"	crc ^= 0xbc;
	MOVLW	0xbc
	BANKSEL	_crc
	XORWF	_crc,F
_00130_DS_
;	.line	377; "serial1.c"	if(i & 4)
	BANKSEL	r0x1018
	BTFSS	r0x1018,2
	GOTO	_00132_DS_
;	.line	378; "serial1.c"	crc ^= 0x61;
	MOVLW	0x61
	BANKSEL	_crc
	XORWF	_crc,F
_00132_DS_
;	.line	379; "serial1.c"	if(i & 8)
	BANKSEL	r0x1018
	BTFSS	r0x1018,3
	GOTO	_00134_DS_
;	.line	380; "serial1.c"	crc ^= 0xc2;
	MOVLW	0xc2
	BANKSEL	_crc
	XORWF	_crc,F
_00134_DS_
;	.line	381; "serial1.c"	if(i & 0x10)
	BANKSEL	r0x1018
	BTFSS	r0x1018,4
	GOTO	_00136_DS_
;	.line	382; "serial1.c"	crc ^= 0x9d;
	MOVLW	0x9d
	BANKSEL	_crc
	XORWF	_crc,F
_00136_DS_
;	.line	383; "serial1.c"	if(i & 0x20)
	BANKSEL	r0x1018
	BTFSS	r0x1018,5
	GOTO	_00138_DS_
;	.line	384; "serial1.c"	crc ^= 0x23;
	MOVLW	0x23
	BANKSEL	_crc
	XORWF	_crc,F
_00138_DS_
;	.line	385; "serial1.c"	if(i & 0x40)
	BANKSEL	r0x1018
	BTFSS	r0x1018,6
	GOTO	_00140_DS_
;	.line	386; "serial1.c"	crc ^= 0x46;
	MOVLW	0x46
	BANKSEL	_crc
	XORWF	_crc,F
_00140_DS_
;	.line	387; "serial1.c"	if(i & 0x80)
	BANKSEL	r0x1018
	BTFSS	r0x1018,7
	GOTO	_00142_DS_
;	.line	388; "serial1.c"	crc ^= 0x8c;
	MOVLW	0x8c
	BANKSEL	_crc
	XORWF	_crc,F
_00142_DS_
;	.line	389; "serial1.c"	return dataval;
	BANKSEL	r0x1017
	MOVF	r0x1017,W
	RETURN	
; exit point of _computeCRC

;***
;  pBlock Stats: dbName = C
;***
;entry:  _serial_init	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_serial_init	;Function start
; 2 exit points
;	.line	324; "serial1.c"	uartState = SNAP_idle;
	MOVLW	0x30
	BANKSEL	_uartState
	MOVWF	_uartState
;	.line	325; "serial1.c"	transmitBufferHead = 0;
	BANKSEL	_transmitBufferHead
	CLRF	_transmitBufferHead
;	.line	326; "serial1.c"	transmitBufferTail = 0;
	BANKSEL	_transmitBufferTail
	CLRF	_transmitBufferTail
;	.line	327; "serial1.c"	serialStatus = 0;
	BANKSEL	_serialStatus
	CLRF	_serialStatus
;	.line	328; "serial1.c"	crc = 0;
	BANKSEL	_crc
	CLRF	_crc
;	.line	329; "serial1.c"	flash = 0;
	BANKSEL	_flash
	CLRF	_flash
;	.line	330; "serial1.c"	flashON = FLASHRATE;
	MOVLW	0x32
;	.line	331; "serial1.c"	flashOFF = FLASHRATE;
	BANKSEL	_flashON
	MOVWF	_flashON
	BANKSEL	_flashOFF
	MOVWF	_flashOFF
	RETURN	
; exit point of _serial_init

;***
;  pBlock Stats: dbName = C
;***
;entry:  _setFlash	;Function start
; 2 exit points
;has an exit
;1 compiler assigned register :
;   STK00
;; Starting pCode block
_setFlash	;Function start
; 2 exit points
;	.line	313; "serial1.c"	void setFlash(byte on, byte off)
	BANKSEL	_flashON
	MOVWF	_flashON
	MOVF	STK00,W
	BANKSEL	_flashOFF
	MOVWF	_flashOFF
;	.line	316; "serial1.c"	flashOFF = off;
	RETURN	
; exit point of _setFlash

;***
;  pBlock Stats: dbName = C
;***
;entry:  _LEDon	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_LEDon	;Function start
; 2 exit points
;	.line	310; "serial1.c"	LED = 0;
	BANKSEL	_PORTA_bits
	BCF	_PORTA_bits,4
	RETURN	
; exit point of _LEDon

;***
;  pBlock Stats: dbName = C
;***
;entry:  _flashLED	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_flashLED	;Function start
; 2 exit points
;	.line	292; "serial1.c"	flash_count--;
	BANKSEL	_flash_count
	DECF	_flash_count,F
;	.line	293; "serial1.c"	if(flash_count <= 0)
	MOVF	_flash_count,W
	BTFSS	STATUS,2
	GOTO	_00110_DS_
;	.line	295; "serial1.c"	flash = 1 - flash;
	BANKSEL	_flash
	MOVF	_flash,W
	SUBLW	0x01
	MOVWF	_flash
;	.line	296; "serial1.c"	if(flash)
	MOVF	_flash,W
	BTFSC	STATUS,2
	GOTO	_00106_DS_
;	.line	298; "serial1.c"	LED = 0;
	BANKSEL	_PORTA_bits
	BCF	_PORTA_bits,4
;	.line	299; "serial1.c"	flash_count = flashOFF;
	BANKSEL	_flashOFF
	MOVF	_flashOFF,W
	BANKSEL	_flash_count
	MOVWF	_flash_count
	GOTO	_00110_DS_
_00106_DS_
;	.line	302; "serial1.c"	LED = 1;
	BANKSEL	_PORTA_bits
	BSF	_PORTA_bits,4
;	.line	303; "serial1.c"	flash_count = flashON;
	BANKSEL	_flashON
	MOVF	_flashON,W
	BANKSEL	_flash_count
	MOVWF	_flash_count
_00110_DS_
	RETURN	
; exit point of _flashLED


;	code size estimation:
;	  569+  279 =   848 instructions ( 2254 byte)

	end
