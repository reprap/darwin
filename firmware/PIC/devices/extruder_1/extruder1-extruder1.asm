;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.7.4 #4943 (Oct 27 2007) (UNIX)
; This file was generated Fri Jun 13 14:34:04 2008
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.module extruder1
	list	p=16f648a
	radix dec
	include "p16f648a.inc"
;--------------------------------------------------------
; config word 
;--------------------------------------------------------
	__config 0x3f10
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_init2
	extern	_processCommand
	extern	_motorTick
	extern	_timerTick
	extern	_checkTemperature
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
	extern	_PWMPeriod
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
	extern	___sdcc_saved_fsr
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_init1
	global	_main
	global	_deviceAddress

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_extruder1_0	udata
r0x1002	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_extruder1_0	idata
_deviceAddress
	db	0x09

;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; interrupt and initialization code
;--------------------------------------------------------
c_interrupt	code	0x4
__sdcc_interrupt
;***
;  pBlock Stats: dbName = I
;***
;entry:  _isr	;Function start
; 0 exit points
;functions called:
;   _serialInterruptHandler
;   _motorTick
;   _timerTick
;   _serialInterruptHandler
;   _motorTick
;   _timerTick
;; Starting pCode block
_isr	;Function start
; 0 exit points
;	.line	48; "extruder1.c"	static void isr() interrupt 0 {
	MOVWF	WSAVE
	SWAPF	STATUS,W
	CLRF	STATUS
	MOVWF	SSAVE
	MOVF	PCLATH,W
	CLRF	PCLATH
	MOVWF	PSAVE
	MOVF	FSR,W
	BANKSEL	___sdcc_saved_fsr
	MOVWF	___sdcc_saved_fsr
;	.line	49; "extruder1.c"	serialInterruptHandler();
	PAGESEL	_serialInterruptHandler
	CALL	_serialInterruptHandler
	PAGESEL	$
;	.line	51; "extruder1.c"	if (RBIF)
	BANKSEL	_INTCON_bits
	BTFSS	_INTCON_bits,0
	GOTO	_00106_DS_
;	.line	52; "extruder1.c"	motorTick();
	PAGESEL	_motorTick
	CALL	_motorTick
	PAGESEL	$
_00106_DS_
;	.line	54; "extruder1.c"	if (TMR1IF) {
	BANKSEL	_PIR1_bits
	BTFSS	_PIR1_bits,0
	GOTO	_00109_DS_
;	.line	55; "extruder1.c"	timerTick();
	PAGESEL	_timerTick
	CALL	_timerTick
	PAGESEL	$
;	.line	56; "extruder1.c"	TMR1IF = 0;
	BANKSEL	_PIR1_bits
	BCF	_PIR1_bits,0
_00109_DS_
	BANKSEL	___sdcc_saved_fsr
	MOVF	___sdcc_saved_fsr,W
	MOVWF	FSR
	MOVF	PSAVE,W
	MOVWF	PCLATH
	CLRF	STATUS
	SWAPF	SSAVE,W
	MOVWF	STATUS
	SWAPF	WSAVE,F
	SWAPF	WSAVE,W
END_OF_INTERRUPT
	RETFIE	

;--------------------------------------------------------
; code
;--------------------------------------------------------
code_extruder1	code
;***
;  pBlock Stats: dbName = M
;***
;entry:  _main	;Function start
; 2 exit points
;has an exit
;functions called:
;   _init2
;   _init1
;   _serial_init
;   _uartTransmit
;   _packetReady
;   _processCommand
;   _releaseLock
;   _checkTemperature
;   _delay_10us
;   _clearwdt
;   _init2
;   _init1
;   _serial_init
;   _uartTransmit
;   _packetReady
;   _processCommand
;   _releaseLock
;   _checkTemperature
;   _delay_10us
;   _clearwdt
;1 compiler assigned register :
;   r0x1002
;; Starting pCode block
_main	;Function start
; 2 exit points
;	.line	127; "extruder1.c"	init2();  // Order is important here, otherwise interrupts will occur
	PAGESEL	_init2
	CALL	_init2
	PAGESEL	$
;	.line	130; "extruder1.c"	init1();
	CALL	_init1
;	.line	131; "extruder1.c"	serial_init();
	PAGESEL	_serial_init
	CALL	_serial_init
	PAGESEL	$
;	.line	134; "extruder1.c"	GIE=0;
	BANKSEL	_INTCON_bits
	BCF	_INTCON_bits,7
;	.line	135; "extruder1.c"	uartTransmit(0);
	MOVLW	0x00
	PAGESEL	_uartTransmit
	CALL	_uartTransmit
	PAGESEL	$
;	.line	136; "extruder1.c"	GIE=1;
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,7
_00121_DS_
;	.line	139; "extruder1.c"	if (packetReady()) {
	PAGESEL	_packetReady
	CALL	_packetReady
	PAGESEL	$
	BANKSEL	r0x1002
	MOVWF	r0x1002
	MOVF	r0x1002,W
	BTFSC	STATUS,2
	GOTO	_00119_DS_
;	.line	140; "extruder1.c"	processCommand();
	PAGESEL	_processCommand
	CALL	_processCommand
	PAGESEL	$
;	.line	141; "extruder1.c"	releaseLock();
	PAGESEL	_releaseLock
	CALL	_releaseLock
	PAGESEL	$
_00119_DS_
;	.line	143; "extruder1.c"	checkTemperature();
	PAGESEL	_checkTemperature
	CALL	_checkTemperature
	PAGESEL	$
;	.line	144; "extruder1.c"	delay_10us();
	PAGESEL	_delay_10us
	CALL	_delay_10us
	PAGESEL	$
;	.line	145; "extruder1.c"	clearwdt();
	PAGESEL	_clearwdt
	CALL	_clearwdt
	PAGESEL	$
	GOTO	_00121_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;entry:  _init1	;Function start
; 2 exit points
;has an exit
;; Starting pCode block
_init1	;Function start
; 2 exit points
;	.line	65; "extruder1.c"	OPTION_REG = BIN(01011111); // Disable TMR0 on RA4, 1:128 WDT, pullups on
	MOVLW	0x5f
	BANKSEL	_OPTION_REG
	MOVWF	_OPTION_REG
;	.line	66; "extruder1.c"	CMCON = BIN(00000010);      // Comparator: compare RA0 to int. ref.
	MOVLW	0x02
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	67; "extruder1.c"	TRISA = BIN(11111111);      // Port A all inputs for now
	MOVLW	0xff
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	77; "extruder1.c"	TRISB = BIN(11000111);
	MOVLW	0xc7
	MOVWF	_TRISB
;	.line	85; "extruder1.c"	PIE1 = BIN(00000000);       // All peripheral interrupts initially disabled
	CLRF	_PIE1
;	.line	86; "extruder1.c"	INTCON = BIN(00000000);     // Interrupts disabled
	BANKSEL	_INTCON
	CLRF	_INTCON
;	.line	87; "extruder1.c"	PIR1 = 0;                   // Clear peripheral interrupt flags
	CLRF	_PIR1
;	.line	88; "extruder1.c"	SPBRG = 12;                 // 12 = ~19200 baud @ 4MHz
	MOVLW	0x0c
	BANKSEL	_SPBRG
	MOVWF	_SPBRG
;	.line	90; "extruder1.c"	TXSTA = BIN(00000100);      // 8 bit high speed 
	MOVLW	0x04
	MOVWF	_TXSTA
;	.line	91; "extruder1.c"	RCSTA = BIN(10000000);      // Enable port for 8 bit receive
	MOVLW	0x80
	BANKSEL	_RCSTA
	MOVWF	_RCSTA
;	.line	93; "extruder1.c"	RCIE = 1;  // Enable receive interrupts
	BANKSEL	_PIE1_bits
	BSF	_PIE1_bits,5
;	.line	94; "extruder1.c"	CREN = 1;  // Start reception
	BANKSEL	_RCSTA_bits
	BSF	_RCSTA_bits,4
;	.line	96; "extruder1.c"	TXEN = 1;  // Enable transmit
	BANKSEL	_TXSTA_bits
	BSF	_TXSTA_bits,5
;	.line	97; "extruder1.c"	RBIE = 1;  // Enable RB port change interrupt
	BANKSEL	_INTCON_bits
	BSF	_INTCON_bits,3
;	.line	99; "extruder1.c"	PEIE = 1;  // Peripheral interrupts on
	BSF	_INTCON_bits,6
;	.line	100; "extruder1.c"	GIE = 1;   // Now turn on interrupts
	BSF	_INTCON_bits,7
;	.line	102; "extruder1.c"	PORTB = BIN(11000001);
	MOVLW	0xc1
	MOVWF	_PORTB
;	.line	103; "extruder1.c"	TRISA = BIN(11000010) | PORTATRIS;  // Turn off A/D lines,
	MOVLW	0xe2
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	105; "extruder1.c"	PORTA = 0;
	BANKSEL	_PORTA
	CLRF	_PORTA
;	.line	114; "extruder1.c"	TMR1IE = 0;
	BANKSEL	_PIE1_bits
	BCF	_PIE1_bits,0
;	.line	115; "extruder1.c"	T1CON = BIN(00000000);  // Timer 1 in clock mode with 1:1 scale
	BANKSEL	_T1CON
	CLRF	_T1CON
;	.line	116; "extruder1.c"	TMR1IE = 1;  // Enable timer interrupt
	BANKSEL	_PIE1_bits
	BSF	_PIE1_bits,0
;	.line	117; "extruder1.c"	TMR1ON = 1;
	BANKSEL	_T1CON_bits
	BSF	_T1CON_bits,0
;	.line	119; "extruder1.c"	PR2 = PWMPeriod;          // Initial PWM period
	BANKSEL	_PWMPeriod
	MOVF	_PWMPeriod,W
	BANKSEL	_PR2
	MOVWF	_PR2
;	.line	120; "extruder1.c"	CCP1CON = BIN(00001100);  // Enable PWM mode
	MOVLW	0x0c
	BANKSEL	_CCP1CON
	MOVWF	_CCP1CON
;	.line	121; "extruder1.c"	CCPR1L = 0;               // Start turned off
	CLRF	_CCPR1L
;	.line	123; "extruder1.c"	T2CON = BIN(00000100);    // Enable timer 2 and set prescale to 1
	MOVLW	0x04
	MOVWF	_T2CON
	RETURN	
; exit point of _init1


;	code size estimation:
;	   86+   51 =   137 instructions (  376 byte)

	end
