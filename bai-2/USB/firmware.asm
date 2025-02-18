
_turn_off_all_led:

;firmware.c,16 :: 		void turn_off_all_led() {
;firmware.c,17 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,18 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,19 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,20 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_send:

;firmware.c,22 :: 		void send(char msg) {
;firmware.c,23 :: 		writebuff[0] = msg;
	MOVF        FARG_send_msg+0, 0 
	MOVWF       1344 
;firmware.c,24 :: 		HID_Write(&writebuff, out_size);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       1
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;firmware.c,25 :: 		}
L_end_send:
	RETURN      0
; end of _send

_interrupt:

;firmware.c,31 :: 		void interrupt(void) {
;firmware.c,32 :: 		if (USBIF_bit == 1)
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt0
;firmware.c,34 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,35 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;firmware.c,36 :: 		}
L_interrupt0:
;firmware.c,37 :: 		}
L_end_interrupt:
L__interrupt22:
	RETFIE      1
; end of _interrupt

_setup:

;firmware.c,39 :: 		void setup() {
;firmware.c,40 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,41 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,44 :: 		PORTB = 0x00; LATB = 0x00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;firmware.c,45 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,46 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,47 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,50 :: 		PORTE = 0x00; LATE = 0x00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;firmware.c,51 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,52 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,53 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,56 :: 		UPUEN_bit = 1;
	BSF         UPUEN_bit+0, BitPos(UPUEN_bit+0) 
;firmware.c,57 :: 		FSEN_bit = 1;
	BSF         FSEN_bit+0, BitPos(FSEN_bit+0) 
;firmware.c,58 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;firmware.c,61 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,62 :: 		USBIE_bit = 1;
	BSF         USBIE_bit+0, BitPos(USBIE_bit+0) 
;firmware.c,63 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;firmware.c,64 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;firmware.c,66 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup1:
	DECFSZ      R13, 1, 1
	BRA         L_setup1
	DECFSZ      R12, 1, 1
	BRA         L_setup1
	DECFSZ      R11, 1, 1
	BRA         L_setup1
	NOP
	NOP
;firmware.c,67 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,68 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,69 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,71 :: 		void loop()
;firmware.c,73 :: 		if (mode == 1) {
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop25
	MOVLW       1
	XORWF       _mode+0, 0 
L__loop25:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop2
;firmware.c,74 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,75 :: 		delay(100);
	MOVLW       100
	MOVWF       FARG_delay_ms+0 
	MOVLW       0
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,76 :: 		} else if (mode == 2) {
	GOTO        L_loop3
L_loop2:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop26
	MOVLW       2
	XORWF       _mode+0, 0 
L__loop26:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop4
;firmware.c,77 :: 		YELLOW = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,78 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_ms+0 
	MOVLW       3
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,79 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,80 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_ms+0 
	MOVLW       3
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,81 :: 		} else if (mode == 3) {
	GOTO        L_loop5
L_loop4:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop27
	MOVLW       3
	XORWF       _mode+0, 0 
L__loop27:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop6
;firmware.c,82 :: 		RED = 1; GREEN = 0;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,83 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_ms+0 
	MOVLW       19
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,84 :: 		YELLOW = 1; RED = 0;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,85 :: 		delay(3000);
	MOVLW       184
	MOVWF       FARG_delay_ms+0 
	MOVLW       11
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,86 :: 		YELLOW = 0; GREEN = 1;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,87 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_ms+0 
	MOVLW       3
	MOVWF       FARG_delay_ms+1 
	CALL        _delay+0, 0
;firmware.c,88 :: 		}
L_loop6:
L_loop5:
L_loop3:
;firmware.c,89 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,91 :: 		void main()
;firmware.c,93 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,94 :: 		while (1) loop();
L_main7:
	CALL        _loop+0, 0
	GOTO        L_main7
;firmware.c,95 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_delay:

;firmware.c,97 :: 		void delay(int ms) {
;firmware.c,99 :: 		for (i = 0; i < ms; i++) {
	CLRF        delay_i_L0+0 
	CLRF        delay_i_L0+1 
L_delay9:
	MOVF        FARG_delay_ms+1, 0 
	SUBWF       delay_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay30
	MOVF        FARG_delay_ms+0, 0 
	SUBWF       delay_i_L0+0, 0 
L__delay30:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay10
;firmware.c,100 :: 		if (HID_Read()) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay12
;firmware.c,101 :: 		if (readbuff[0] == '1') {
	MOVF        1280, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_delay13
;firmware.c,102 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,103 :: 		mode = 1; send('Y');
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       89
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,104 :: 		break;
	GOTO        L_delay10
;firmware.c,105 :: 		} else if (readbuff[0] == '2') {
L_delay13:
	MOVF        1280, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_delay15
;firmware.c,106 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,107 :: 		mode = 2; send('U');
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       85
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,108 :: 		break;
	GOTO        L_delay10
;firmware.c,109 :: 		} else if (readbuff[0] == '3') {
L_delay15:
	MOVF        1280, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_delay17
;firmware.c,110 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,111 :: 		mode = 3; send('K');
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
	MOVLW       75
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,112 :: 		break;
	GOTO        L_delay10
;firmware.c,113 :: 		}
L_delay17:
;firmware.c,114 :: 		}
L_delay12:
;firmware.c,115 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay18:
	DECFSZ      R13, 1, 1
	BRA         L_delay18
	DECFSZ      R12, 1, 1
	BRA         L_delay18
;firmware.c,99 :: 		for (i = 0; i < ms; i++) {
	INFSNZ      delay_i_L0+0, 1 
	INCF        delay_i_L0+1, 1 
;firmware.c,116 :: 		}
	GOTO        L_delay9
L_delay10:
;firmware.c,117 :: 		}
L_end_delay:
	RETURN      0
; end of _delay
