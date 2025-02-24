
_turn_off_all_led:

;firmware.c,12 :: 		void turn_off_all_led() {
;firmware.c,13 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,14 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,15 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,16 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_delay:

;firmware.c,18 :: 		void delay(int time) {
;firmware.c,20 :: 		for (i = 0; i < time; i++) {
	CLRF        delay_i_L0+0 
	CLRF        delay_i_L0+1 
L_delay0:
	MOVF        FARG_delay_time+1, 0 
	SUBWF       delay_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay31
	MOVF        FARG_delay_time+0, 0 
	SUBWF       delay_i_L0+0, 0 
L__delay31:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay1
;firmware.c,22 :: 		if (BUTTON(&PORTB, 0, 10, 0)) {
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
	GOTO        L_delay3
;firmware.c,23 :: 		while (BUTTON(&PORTB, 0, 10, 0))
L_delay4:
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
	GOTO        L_delay5
;firmware.c,24 :: 		;
	GOTO        L_delay4
L_delay5:
;firmware.c,25 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,26 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,27 :: 		break;
	GOTO        L_delay1
;firmware.c,28 :: 		} else if (BUTTON(&PORTB, 1, 10, 0)) {
L_delay3:
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
	GOTO        L_delay7
;firmware.c,29 :: 		while (BUTTON(&PORTB, 1, 10, 0))
L_delay8:
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
	GOTO        L_delay9
;firmware.c,30 :: 		;
	GOTO        L_delay8
L_delay9:
;firmware.c,31 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,32 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,33 :: 		break;
	GOTO        L_delay1
;firmware.c,34 :: 		} else if (BUTTON(&PORTB, 2, 10, 0)) {
L_delay7:
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
	GOTO        L_delay11
;firmware.c,35 :: 		while (BUTTON(&PORTB, 2, 10, 0))
L_delay12:
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
	GOTO        L_delay13
;firmware.c,36 :: 		;
	GOTO        L_delay12
L_delay13:
;firmware.c,37 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,38 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,39 :: 		break;
	GOTO        L_delay1
;firmware.c,40 :: 		}
L_delay11:
;firmware.c,41 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay14:
	DECFSZ      R13, 1, 1
	BRA         L_delay14
	DECFSZ      R12, 1, 1
	BRA         L_delay14
;firmware.c,20 :: 		for (i = 0; i < time; i++) {
	INFSNZ      delay_i_L0+0, 1 
	INCF        delay_i_L0+1, 1 
;firmware.c,42 :: 		}
	GOTO        L_delay0
L_delay1:
;firmware.c,43 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_setup:

;firmware.c,45 :: 		void setup() {
;firmware.c,46 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,47 :: 		CMCON |= 0X07;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,50 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,51 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,52 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,53 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,54 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,57 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,58 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,59 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,60 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,61 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,63 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup15:
	DECFSZ      R13, 1, 1
	BRA         L_setup15
	DECFSZ      R12, 1, 1
	BRA         L_setup15
	DECFSZ      R11, 1, 1
	BRA         L_setup15
	NOP
	NOP
;firmware.c,64 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,65 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,66 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,68 :: 		void loop() {
;firmware.c,69 :: 		if (mode == 1) {
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop34
	MOVLW       1
	XORWF       _mode+0, 0 
L__loop34:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop16
;firmware.c,70 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,71 :: 		delay(1);
	MOVLW       1
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,72 :: 		} else if (mode == 2) {
	GOTO        L_loop17
L_loop16:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop35
	MOVLW       2
	XORWF       _mode+0, 0 
L__loop35:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop18
;firmware.c,73 :: 		YELLOW = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,74 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,75 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,76 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,77 :: 		} else if (mode == 3) {
	GOTO        L_loop19
L_loop18:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop36
	MOVLW       3
	XORWF       _mode+0, 0 
L__loop36:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop20
;firmware.c,78 :: 		if (RED == 1) {
	BTFSS       LATE0_bit+0, BitPos(LATE0_bit+0) 
	GOTO        L_loop21
;firmware.c,79 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,80 :: 		YELLOW = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,81 :: 		delay(3000);
	MOVLW       184
	MOVWF       FARG_delay_time+0 
	MOVLW       11
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,82 :: 		} else if (YELLOW == 1) {
	GOTO        L_loop22
L_loop21:
	BTFSS       LATE1_bit+0, BitPos(LATE1_bit+0) 
	GOTO        L_loop23
;firmware.c,83 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,84 :: 		GREEN = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,85 :: 		delay(10000);
	MOVLW       16
	MOVWF       FARG_delay_time+0 
	MOVLW       39
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,86 :: 		} else if (GREEN == 1) {
	GOTO        L_loop24
L_loop23:
	BTFSS       LATE2_bit+0, BitPos(LATE2_bit+0) 
	GOTO        L_loop25
;firmware.c,87 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,88 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,89 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,90 :: 		} else {
	GOTO        L_loop26
L_loop25:
;firmware.c,91 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,92 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,93 :: 		}
L_loop26:
L_loop24:
L_loop22:
;firmware.c,94 :: 		}
L_loop20:
L_loop19:
L_loop17:
;firmware.c,95 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,97 :: 		void main() {
;firmware.c,98 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,99 :: 		while (1)
L_main27:
;firmware.c,100 :: 		loop();
	CALL        _loop+0, 0
	GOTO        L_main27
;firmware.c,101 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
