
_send:

;firmware.c,20 :: 		void send(char msg) {
;firmware.c,21 :: 		transmit_data = msg;
	MOVF        FARG_send_msg+0, 0 
	MOVWF       _transmit_data+0 
;firmware.c,22 :: 		UART1_Write(transmit_data);
	MOVF        FARG_send_msg+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,23 :: 		}
L_end_send:
	RETURN      0
; end of _send

_turn_off_all_led:

;firmware.c,25 :: 		void turn_off_all_led() {
;firmware.c,26 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,27 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,28 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,29 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_delay:

;firmware.c,31 :: 		void delay(int time) {
;firmware.c,33 :: 		for (i = 0; i < time; i++) {
	CLRF        delay_i_L0+0 
	CLRF        delay_i_L0+1 
L_delay0:
	MOVF        FARG_delay_time+1, 0 
	SUBWF       delay_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay43
	MOVF        FARG_delay_time+0, 0 
	SUBWF       delay_i_L0+0, 0 
L__delay43:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay1
;firmware.c,35 :: 		if (UART1_Data_Ready()) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay3
;firmware.c,36 :: 		receive_data = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _receive_data+0 
;firmware.c,38 :: 		if (receive_data == 'T') {
	MOVF        R0, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_delay4
;firmware.c,39 :: 		control_source = 1 - control_source;
	MOVF        _control_source+0, 0 
	SUBLW       1
	MOVWF       _control_source+0 
	MOVF        _control_source+1, 0 
	MOVWF       _control_source+1 
	MOVLW       0
	SUBFWB      _control_source+1, 1 
;firmware.c,40 :: 		if (control_source == 0)
	MOVLW       0
	XORWF       _control_source+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay44
	MOVLW       0
	XORWF       _control_source+0, 0 
L__delay44:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay5
;firmware.c,41 :: 		send('M'); // Manual
	MOVLW       77
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
	GOTO        L_delay6
L_delay5:
;firmware.c,43 :: 		send('A'); // Auto
	MOVLW       65
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
L_delay6:
;firmware.c,44 :: 		}
L_delay4:
;firmware.c,46 :: 		if (control_source == 1) {
	MOVLW       0
	XORWF       _control_source+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay45
	MOVLW       1
	XORWF       _control_source+0, 0 
L__delay45:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay7
;firmware.c,47 :: 		if (receive_data == '1') {
	MOVF        _receive_data+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_delay8
;firmware.c,48 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,49 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,50 :: 		send('Y');
	MOVLW       89
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,51 :: 		break;
	GOTO        L_delay1
;firmware.c,52 :: 		} else if (receive_data == '2') {
L_delay8:
	MOVF        _receive_data+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_delay10
;firmware.c,53 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,54 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,55 :: 		send('U');
	MOVLW       85
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,56 :: 		break;
	GOTO        L_delay1
;firmware.c,57 :: 		} else if (receive_data == '3') {
L_delay10:
	MOVF        _receive_data+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_delay12
;firmware.c,58 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,59 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,60 :: 		send('K');
	MOVLW       75
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,61 :: 		break;
	GOTO        L_delay1
;firmware.c,62 :: 		}
L_delay12:
;firmware.c,63 :: 		}
L_delay7:
;firmware.c,64 :: 		}
L_delay3:
;firmware.c,66 :: 		if (control_source == 0) {
	MOVLW       0
	XORWF       _control_source+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay46
	MOVLW       0
	XORWF       _control_source+0, 0 
L__delay46:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay13
;firmware.c,67 :: 		if (BUTTON(&PORTB, 0, 10, 0)) {
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
	GOTO        L_delay14
;firmware.c,68 :: 		while (BUTTON(&PORTB, 0, 10, 0))
L_delay15:
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
	GOTO        L_delay16
;firmware.c,69 :: 		;
	GOTO        L_delay15
L_delay16:
;firmware.c,70 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,71 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,72 :: 		send('Y');
	MOVLW       89
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,73 :: 		break;
	GOTO        L_delay1
;firmware.c,74 :: 		} else if (BUTTON(&PORTB, 1, 10, 0)) {
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
	GOTO        L_delay18
;firmware.c,75 :: 		while (BUTTON(&PORTB, 1, 10, 0))
L_delay19:
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
	GOTO        L_delay20
;firmware.c,76 :: 		;
	GOTO        L_delay19
L_delay20:
;firmware.c,77 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,78 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,79 :: 		send('U');
	MOVLW       85
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,80 :: 		break;
	GOTO        L_delay1
;firmware.c,81 :: 		} else if (BUTTON(&PORTB, 2, 10, 0)) {
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
	GOTO        L_delay22
;firmware.c,82 :: 		while (BUTTON(&PORTB, 2, 10, 0))
L_delay23:
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
	GOTO        L_delay24
;firmware.c,83 :: 		;
	GOTO        L_delay23
L_delay24:
;firmware.c,84 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,85 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,86 :: 		send('K');
	MOVLW       75
	MOVWF       FARG_send_msg+0 
	CALL        _send+0, 0
;firmware.c,87 :: 		break;
	GOTO        L_delay1
;firmware.c,88 :: 		}
L_delay22:
;firmware.c,89 :: 		}
L_delay13:
;firmware.c,91 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay25:
	DECFSZ      R13, 1, 1
	BRA         L_delay25
	DECFSZ      R12, 1, 1
	BRA         L_delay25
;firmware.c,33 :: 		for (i = 0; i < time; i++) {
	INFSNZ      delay_i_L0+0, 1 
	INCF        delay_i_L0+1, 1 
;firmware.c,92 :: 		}
	GOTO        L_delay0
L_delay1:
;firmware.c,93 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_setup:

;firmware.c,95 :: 		void setup() {
;firmware.c,96 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,97 :: 		CMCON |= 0X07;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,100 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,101 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,102 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,103 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,104 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,107 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,108 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,109 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,110 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,111 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,114 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;firmware.c,115 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup26:
	DECFSZ      R13, 1, 1
	BRA         L_setup26
	DECFSZ      R12, 1, 1
	BRA         L_setup26
	DECFSZ      R11, 1, 1
	BRA         L_setup26
	NOP
	NOP
;firmware.c,117 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,118 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
	MOVLW       0
	MOVWF       _mode+1 
;firmware.c,119 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,121 :: 		void loop() {
;firmware.c,122 :: 		if (mode == 1) {
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop49
	MOVLW       1
	XORWF       _mode+0, 0 
L__loop49:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop27
;firmware.c,123 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,124 :: 		delay(1);
	MOVLW       1
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,125 :: 		} else if (mode == 2) {
	GOTO        L_loop28
L_loop27:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop50
	MOVLW       2
	XORWF       _mode+0, 0 
L__loop50:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop29
;firmware.c,126 :: 		YELLOW = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,127 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,128 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,129 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,130 :: 		} else if (mode == 3) {
	GOTO        L_loop30
L_loop29:
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop51
	MOVLW       3
	XORWF       _mode+0, 0 
L__loop51:
	BTFSS       STATUS+0, 2 
	GOTO        L_loop31
;firmware.c,131 :: 		if (RED == 1) {
	BTFSS       LATE0_bit+0, BitPos(LATE0_bit+0) 
	GOTO        L_loop32
;firmware.c,132 :: 		RED = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,133 :: 		YELLOW = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,134 :: 		delay(3000);
	MOVLW       184
	MOVWF       FARG_delay_time+0 
	MOVLW       11
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,135 :: 		} else if (YELLOW == 1) {
	GOTO        L_loop33
L_loop32:
	BTFSS       LATE1_bit+0, BitPos(LATE1_bit+0) 
	GOTO        L_loop34
;firmware.c,136 :: 		YELLOW = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,137 :: 		GREEN = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,138 :: 		delay(10000);
	MOVLW       16
	MOVWF       FARG_delay_time+0 
	MOVLW       39
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,139 :: 		} else if (GREEN == 1) {
	GOTO        L_loop35
L_loop34:
	BTFSS       LATE2_bit+0, BitPos(LATE2_bit+0) 
	GOTO        L_loop36
;firmware.c,140 :: 		GREEN = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,141 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,142 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,143 :: 		} else {
	GOTO        L_loop37
L_loop36:
;firmware.c,144 :: 		RED = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,145 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,146 :: 		}
L_loop37:
L_loop35:
L_loop33:
;firmware.c,147 :: 		}
L_loop31:
L_loop30:
L_loop28:
;firmware.c,148 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,150 :: 		void main() {
;firmware.c,151 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,152 :: 		while (1)
L_main38:
;firmware.c,153 :: 		loop();
	CALL        _loop+0, 0
	GOTO        L_main38
;firmware.c,154 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
