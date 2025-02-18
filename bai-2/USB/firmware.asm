
_send:

;firmware.c,16 :: 		void send(char msg) {
;firmware.c,17 :: 		writebuff[0] = msg;
	MOVF        FARG_send_msg+0, 0 
	MOVWF       1344 
;firmware.c,18 :: 		HID_Write(&writebuff, out_size);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       1
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;firmware.c,19 :: 		}
L_end_send:
	RETURN      0
; end of _send

_turn_off_all_led:

;firmware.c,21 :: 		void turn_off_all_led() {
;firmware.c,22 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,23 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,24 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,25 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_delay:

;firmware.c,27 :: 		void delay(int ms) {
;firmware.c,29 :: 		for (i = 0; i < ms; i++) {
	CLRF        delay_i_L0+0 
	CLRF        delay_i_L0+1 
L_delay0:
	MOVLW       128
	XORWF       delay_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_delay_ms+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay33
	MOVF        FARG_delay_ms+0, 0 
	SUBWF       delay_i_L0+0, 0 
L__delay33:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay1
;firmware.c,30 :: 		if (HID_Read()) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay3
;firmware.c,31 :: 		if (readbuff[0] == '1') { mode = 1; send('Y'); turn_off_all_led(); break;}
	MOVF        1280, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_delay4
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       89
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
L_delay4:
;firmware.c,32 :: 		else if (readbuff[0] == '2') { mode = 2; send('U'); turn_off_all_led(); break; }
	MOVF        1280, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_delay6
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       85
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
L_delay6:
;firmware.c,33 :: 		else if (readbuff[0] == '3') { mode = 3; send('K'); turn_off_all_led(); break; }
	MOVF        1280, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_delay8
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       75
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
L_delay8:
;firmware.c,34 :: 		}
L_delay3:
;firmware.c,36 :: 		if (BUTTON(&PORTB, 0, 10, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay9
;firmware.c,37 :: 		while (BUTTON(&PORTB, 0, 10, 0));
L_delay10:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay11
	GOTO        L_delay10
L_delay11:
;firmware.c,38 :: 		mode = 1; send('Y'); turn_off_all_led(); break;
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       89
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
;firmware.c,39 :: 		} else if (BUTTON(&PORTB, 1, 10, 0)) {
L_delay9:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay13
;firmware.c,40 :: 		while (BUTTON(&PORTB, 1, 10, 0));
L_delay14:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay15
	GOTO        L_delay14
L_delay15:
;firmware.c,41 :: 		mode = 2; send('U'); turn_off_all_led(); break;
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       85
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
;firmware.c,42 :: 		} else if (BUTTON(&PORTB, 2, 10, 0)) {
L_delay13:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay17
;firmware.c,43 :: 		while (BUTTON(&PORTB, 2, 10, 0));
L_delay18:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay19
	GOTO        L_delay18
L_delay19:
;firmware.c,44 :: 		mode = 3; send('K'); turn_off_all_led(); break;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       75
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	CALL        _turn_off_all_led+0, 0
	GOTO        L_delay1
;firmware.c,45 :: 		}
L_delay17:
;firmware.c,47 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay20:
	DECFSZ      R13, 1, 1
	BRA         L_delay20
	DECFSZ      R12, 1, 1
	BRA         L_delay20
;firmware.c,29 :: 		for (i = 0; i < ms; i++) {
	INFSNZ      delay_i_L0+0, 1 
	INCF        delay_i_L0+1, 1 
;firmware.c,48 :: 		}
	GOTO        L_delay0
L_delay1:
;firmware.c,49 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_interrupt:

;firmware.c,53 :: 		void interrupt(void) {
;firmware.c,54 :: 		if (USBIF_bit == 1) {
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt21
;firmware.c,55 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,56 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;firmware.c,57 :: 		}
L_interrupt21:
;firmware.c,58 :: 		}
L_end_interrupt:
L__interrupt35:
	RETFIE      1
; end of _interrupt

_setup:

;firmware.c,60 :: 		void setup() {
;firmware.c,61 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,62 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,65 :: 		PORTB = 0x00; LATB = 0x00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;firmware.c,66 :: 		TRISB0_bit = 1; TRISB1_bit = 1; TRISB2_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,69 :: 		PORTE = 0x00; LATE = 0x00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;firmware.c,70 :: 		TRISE0_bit = 0; TRISE1_bit = 0; TRISE2_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,73 :: 		UPUEN_bit = 1;
	BSF         UPUEN_bit+0, BitPos(UPUEN_bit+0) 
;firmware.c,74 :: 		FSEN_bit = 1;
	BSF         FSEN_bit+0, BitPos(FSEN_bit+0) 
;firmware.c,75 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;firmware.c,78 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,79 :: 		USBIE_bit = 1;
	BSF         USBIE_bit+0, BitPos(USBIE_bit+0) 
;firmware.c,80 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;firmware.c,81 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;firmware.c,83 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup22:
	DECFSZ      R13, 1, 1
	BRA         L_setup22
	DECFSZ      R12, 1, 1
	BRA         L_setup22
	DECFSZ      R11, 1, 1
	BRA         L_setup22
	NOP
	NOP
;firmware.c,84 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,85 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,86 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,88 :: 		void loop()
;firmware.c,90 :: 		if (mode == 1) {
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop38
	MOVLW       1
	XORWF       _mode+0, 0 
L__loop38:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop23
;firmware.c,91 :: 		RED = 1; delay(1);
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	MOVLW       1
	MOVWF       FARG_delay_ms+0 
	MOVLW       0
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,92 :: 		} else if (mode == 2) {
	GOTO        L_loop24
L_loop23:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop39
	MOVLW       2
	XORWF       _mode+0, 0 
L__loop39:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop25
;firmware.c,93 :: 		YELLOW = 1; delay(1000);
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       232
	MOVWF       FARG_delay_ms+0 
	MOVLW       3
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,94 :: 		YELLOW = 0; delay(1000);
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       232
	MOVWF       FARG_delay_ms+0 
	MOVLW       3
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,95 :: 		} else if (mode == 3) {
	GOTO        L_loop26
L_loop25:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop40
	MOVLW       3
	XORWF       _mode+0, 0 
L__loop40:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop27
;firmware.c,96 :: 		RED = 1; GREEN = 0; delay(5000);
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
	MOVLW       136
	MOVWF       FARG_delay_ms+0 
	MOVLW       19
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,97 :: 		YELLOW = 1; RED = 0; delay(3000);
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	MOVLW       184
	MOVWF       FARG_delay_ms+0 
	MOVLW       11
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,98 :: 		GREEN = 1; YELLOW = 0; delay(10000);
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	MOVLW       16
	MOVWF       FARG_delay_ms+0 
	MOVLW       39
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,99 :: 		}
L_loop27:
L_loop26:
L_loop24:
;firmware.c,100 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,102 :: 		void main() {
;firmware.c,103 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,104 :: 		while (1) loop();
L_main28:
	CALL        _loop+0, 0
	GOTO        L_main28
;firmware.c,105 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
