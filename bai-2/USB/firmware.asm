
_send:

;firmware.c,15 :: 		void send(char msg) {
;firmware.c,16 :: 		writebuff[0] = msg;
	MOVF        FARG_send_msg+0, 0 
	MOVWF       1344 
;firmware.c,17 :: 		HID_Write(&writebuff, out_size);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       1
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;firmware.c,18 :: 		}
L_end_send:
	RETURN      0
; end of _send

_turn_off_all_led:

;firmware.c,20 :: 		void turn_off_all_led() {
;firmware.c,21 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,22 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,23 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,24 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_delay:

;firmware.c,26 :: 		void delay(int time) {
;firmware.c,28 :: 		for (i = 0; i < time; i++) {
	CLRF        delay_i_L0+0 
	CLRF        delay_i_L0+1 
L_delay0:
	MOVF        FARG_delay_time+1, 0 
	SUBWF       delay_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay22
	MOVF        FARG_delay_time+0, 0 
	SUBWF       delay_i_L0+0, 0 
L__delay22:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay1
;firmware.c,29 :: 		if (HID_Read() != 0) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_delay3
;firmware.c,30 :: 		if (readbuff[0] == '1') {
	MOVF        1280, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_delay4
;firmware.c,31 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,32 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,33 :: 		} else if (readbuff[0] == '2') {
	GOTO        L_delay5
L_delay4:
	MOVF        1280, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_delay6
;firmware.c,34 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,35 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,36 :: 		} else if (readbuff[0] == '3') {
	GOTO        L_delay7
L_delay6:
	MOVF        1280, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_delay8
;firmware.c,37 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,38 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,39 :: 		}
L_delay8:
L_delay7:
L_delay5:
;firmware.c,40 :: 		}
L_delay3:
;firmware.c,41 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay9:
	DECFSZ      R13, 1, 1
	BRA         L_delay9
	DECFSZ      R12, 1, 1
	BRA         L_delay9
;firmware.c,28 :: 		for (i = 0; i < time; i++) {
	INFSNZ      delay_i_L0+0, 1 
	INCF        delay_i_L0+1, 1 
;firmware.c,42 :: 		}
	GOTO        L_delay0
L_delay1:
;firmware.c,43 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_interrupt:

;firmware.c,48 :: 		void interrupt(void) {
;firmware.c,49 :: 		if (USBIF_bit == 1) {
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt10
;firmware.c,50 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,51 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;firmware.c,52 :: 		}
L_interrupt10:
;firmware.c,53 :: 		}
L_end_interrupt:
L__interrupt24:
	RETFIE      1
; end of _interrupt

_setup:

;firmware.c,57 :: 		void setup() {
;firmware.c,58 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,59 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,62 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,63 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,64 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,65 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,66 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,69 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,70 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,71 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,72 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,73 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,76 :: 		UPUEN_bit = 1;
	BSF         UPUEN_bit+0, BitPos(UPUEN_bit+0) 
;firmware.c,77 :: 		FSEN_bit = 1;
	BSF         FSEN_bit+0, BitPos(FSEN_bit+0) 
;firmware.c,78 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;firmware.c,81 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,82 :: 		USBIE_bit = 1;
	BSF         USBIE_bit+0, BitPos(USBIE_bit+0) 
;firmware.c,83 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;firmware.c,84 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;firmware.c,86 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup11:
	DECFSZ      R13, 1, 1
	BRA         L_setup11
	DECFSZ      R12, 1, 1
	BRA         L_setup11
	DECFSZ      R11, 1, 1
	BRA         L_setup11
	NOP
	NOP
;firmware.c,87 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,88 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,89 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,91 :: 		void loop()
;firmware.c,93 :: 		if (mode == 1) {
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop27
	MOVLW       1
	XORWF       _mode+0, 0 
L__loop27:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop12
;firmware.c,94 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,95 :: 		delay(1);
	MOVLW       1
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,96 :: 		} else if (mode == 2) {
	GOTO        L_loop13
L_loop12:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop28
	MOVLW       2
	XORWF       _mode+0, 0 
L__loop28:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop14
;firmware.c,97 :: 		YELLOW = 1; delay(1000);
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,98 :: 		YELLOW = 0; delay(1000);
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,99 :: 		} else if (mode == 3) {
	GOTO        L_loop15
L_loop14:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop29
	MOVLW       3
	XORWF       _mode+0, 0 
L__loop29:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop16
;firmware.c,100 :: 		RED = 1; GREEN = 0; delay(5000);
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,101 :: 		YELLOW = 1; RED = 0; delay(3000);
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	MOVLW       184
	MOVWF       FARG_delay_time+0 
	MOVLW       11
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,102 :: 		GREEN = 1; YELLOW = 0; delay(10000);
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       16
	MOVWF       FARG_delay_time+0 
	MOVLW       39
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,103 :: 		}
L_loop16:
L_loop15:
L_loop13:
;firmware.c,104 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,106 :: 		void main() {
;firmware.c,107 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,108 :: 		while (1) loop();
L_main17:
	CALL        _loop+0, 0
	GOTO        L_main17
;firmware.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
