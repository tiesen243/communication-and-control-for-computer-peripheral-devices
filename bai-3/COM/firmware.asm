
_delay_s:

;firmware.c,8 :: 		void delay_s(unsigned int seconds) {
;firmware.c,9 :: 		while (seconds--) {
L_delay_s0:
	MOVF        FARG_delay_s_seconds+0, 0 
	MOVWF       R0 
	MOVF        FARG_delay_s_seconds+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_delay_s_seconds+0, 1 
	MOVLW       0
	SUBWFB      FARG_delay_s_seconds+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay_s1
;firmware.c,10 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_delay_s2:
	MOVLW       0
	SUBWF       _i+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay_s42
	MOVLW       10
	SUBWF       _i+0, 0 
L__delay_s42:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay_s3
;firmware.c,11 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_delay_s5:
	DECFSZ      R13, 1, 1
	BRA         L_delay_s5
	DECFSZ      R12, 1, 1
	BRA         L_delay_s5
	DECFSZ      R11, 1, 1
	BRA         L_delay_s5
	NOP
	NOP
;firmware.c,12 :: 		if (UART1_Data_Ready()) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay_s6
;firmware.c,13 :: 		char cmd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       delay_s_cmd_L3+0 
;firmware.c,14 :: 		if (cmd == '1' || cmd == '2' || cmd == '3' ||
	MOVF        R0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L__delay_s40
	MOVF        delay_s_cmd_L3+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__delay_s40
	MOVF        delay_s_cmd_L3+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L__delay_s40
;firmware.c,15 :: 		BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0)) {
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
	BTFSS       STATUS+0, 2 
	GOTO        L__delay_s40
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
	BTFSS       STATUS+0, 2 
	GOTO        L__delay_s40
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
	BTFSS       STATUS+0, 2 
	GOTO        L__delay_s40
	GOTO        L_delay_s9
L__delay_s40:
;firmware.c,16 :: 		RED = 0; YELLOW = 0; GREEN = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,17 :: 		mode = cmd - '0';
	MOVLW       48
	SUBWF       delay_s_cmd_L3+0, 0 
	MOVWF       _mode+0 
;firmware.c,18 :: 		return;
	GOTO        L_end_delay_s
;firmware.c,19 :: 		}
L_delay_s9:
;firmware.c,20 :: 		}
L_delay_s6:
;firmware.c,10 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;firmware.c,21 :: 		}
	GOTO        L_delay_s2
L_delay_s3:
;firmware.c,22 :: 		}
	GOTO        L_delay_s0
L_delay_s1:
;firmware.c,23 :: 		}
L_end_delay_s:
	RETURN      0
; end of _delay_s

_UART_Receive_Command:

;firmware.c,25 :: 		int UART_Receive_Command() {
;firmware.c,26 :: 		if (UART1_Data_Ready()) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART_Receive_Command10
;firmware.c,27 :: 		char cmd = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       UART_Receive_Command_cmd_L1+0 
;firmware.c,29 :: 		if (cmd == '1') {
	MOVF        R0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Receive_Command11
;firmware.c,30 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;firmware.c,31 :: 		UART1_Write('!');
	MOVLW       33
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,32 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_UART_Receive_Command12:
	DECFSZ      R13, 1, 1
	BRA         L_UART_Receive_Command12
	DECFSZ      R12, 1, 1
	BRA         L_UART_Receive_Command12
	DECFSZ      R11, 1, 1
	BRA         L_UART_Receive_Command12
	NOP
	NOP
;firmware.c,33 :: 		}
	GOTO        L_UART_Receive_Command13
L_UART_Receive_Command11:
;firmware.c,34 :: 		else if (cmd == '2') {
	MOVF        UART_Receive_Command_cmd_L1+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Receive_Command14
;firmware.c,35 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
;firmware.c,36 :: 		UART1_Write('@');
	MOVLW       64
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,37 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_UART_Receive_Command15:
	DECFSZ      R13, 1, 1
	BRA         L_UART_Receive_Command15
	DECFSZ      R12, 1, 1
	BRA         L_UART_Receive_Command15
	DECFSZ      R11, 1, 1
	BRA         L_UART_Receive_Command15
	NOP
	NOP
;firmware.c,38 :: 		}
	GOTO        L_UART_Receive_Command16
L_UART_Receive_Command14:
;firmware.c,39 :: 		else if (cmd == '3') {
	MOVF        UART_Receive_Command_cmd_L1+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Receive_Command17
;firmware.c,40 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
;firmware.c,41 :: 		UART1_Write('#');
	MOVLW       35
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,42 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_UART_Receive_Command18:
	DECFSZ      R13, 1, 1
	BRA         L_UART_Receive_Command18
	DECFSZ      R12, 1, 1
	BRA         L_UART_Receive_Command18
	DECFSZ      R11, 1, 1
	BRA         L_UART_Receive_Command18
	NOP
	NOP
;firmware.c,43 :: 		}
L_UART_Receive_Command17:
L_UART_Receive_Command16:
L_UART_Receive_Command13:
;firmware.c,44 :: 		}
L_UART_Receive_Command10:
;firmware.c,45 :: 		}
L_end_UART_Receive_Command:
	RETURN      0
; end of _UART_Receive_Command

_Button_Receive:

;firmware.c,47 :: 		int Button_Receive() {
;firmware.c,48 :: 		if (BUTTON(&PORTB, 0, 10, 0)) {
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
	GOTO        L_Button_Receive19
;firmware.c,49 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;firmware.c,50 :: 		UART1_Write('#');
	MOVLW       35
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,51 :: 		}
	GOTO        L_Button_Receive20
L_Button_Receive19:
;firmware.c,52 :: 		else if (BUTTON(&PORTB, 1, 10, 0)) {
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
	GOTO        L_Button_Receive21
;firmware.c,53 :: 		while (BUTTON(&PORTB, 1, 10, 0));
L_Button_Receive22:
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
	GOTO        L_Button_Receive23
	GOTO        L_Button_Receive22
L_Button_Receive23:
;firmware.c,54 :: 		mode = 2;
	MOVLW       2
	MOVWF       _mode+0 
;firmware.c,55 :: 		UART1_Write('@');
	MOVLW       64
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,56 :: 		}
	GOTO        L_Button_Receive24
L_Button_Receive21:
;firmware.c,57 :: 		else if (BUTTON(&PORTB, 2, 10, 0)) {
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
	GOTO        L_Button_Receive25
;firmware.c,58 :: 		while (BUTTON(&PORTB, 2, 10, 0));
L_Button_Receive26:
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
	GOTO        L_Button_Receive27
	GOTO        L_Button_Receive26
L_Button_Receive27:
;firmware.c,59 :: 		mode = 3;
	MOVLW       3
	MOVWF       _mode+0 
;firmware.c,60 :: 		UART1_Write('#');
	MOVLW       35
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,61 :: 		}
L_Button_Receive25:
L_Button_Receive24:
L_Button_Receive20:
;firmware.c,62 :: 		}
L_end_Button_Receive:
	RETURN      0
; end of _Button_Receive

_setup:

;firmware.c,65 :: 		void setup() {
;firmware.c,66 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,67 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,70 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,71 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,72 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,73 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,74 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,77 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,78 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,79 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,80 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,81 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,83 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;firmware.c,84 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup28:
	DECFSZ      R13, 1, 1
	BRA         L_setup28
	DECFSZ      R12, 1, 1
	BRA         L_setup28
	DECFSZ      R11, 1, 1
	BRA         L_setup28
	NOP
	NOP
;firmware.c,85 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,87 :: 		void loop() {
;firmware.c,88 :: 		UART_Receive_Command();
	CALL        _UART_Receive_Command+0, 0
;firmware.c,89 :: 		Button_Receive();
	CALL        _Button_Receive+0, 0
;firmware.c,91 :: 		switch(mode) {
	GOTO        L_loop29
;firmware.c,92 :: 		case 1:
L_loop31:
;firmware.c,93 :: 		RED = 1; YELLOW = 0; GREEN = 0;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,94 :: 		break;
	GOTO        L_loop30
;firmware.c,95 :: 		case 2:
L_loop32:
;firmware.c,96 :: 		while (mode == 2) {
L_loop33:
	MOVF        _mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_loop34
;firmware.c,97 :: 		RED = 0; YELLOW = 1; GREEN = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,98 :: 		delay_s(1);
	MOVLW       1
	MOVWF       FARG_delay_s_seconds+0 
	MOVLW       0
	MOVWF       FARG_delay_s_seconds+1 
	CALL        _delay_s+0, 0
;firmware.c,99 :: 		RED = 0; YELLOW = 0; GREEN = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,100 :: 		delay_s(1);
	MOVLW       1
	MOVWF       FARG_delay_s_seconds+0 
	MOVLW       0
	MOVWF       FARG_delay_s_seconds+1 
	CALL        _delay_s+0, 0
;firmware.c,101 :: 		}
	GOTO        L_loop33
L_loop34:
;firmware.c,102 :: 		break;
	GOTO        L_loop30
;firmware.c,103 :: 		case 3:
L_loop35:
;firmware.c,104 :: 		while (mode == 3) {
L_loop36:
	MOVF        _mode+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_loop37
;firmware.c,105 :: 		RED = 1; YELLOW = 0; GREEN = 0;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,106 :: 		delay_s(red_time);
	MOVF        _red_time+0, 0 
	MOVWF       FARG_delay_s_seconds+0 
	MOVF        _red_time+1, 0 
	MOVWF       FARG_delay_s_seconds+1 
	CALL        _delay_s+0, 0
;firmware.c,107 :: 		RED = 0; YELLOW = 1; GREEN = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,108 :: 		delay_s(yellow_time);
	MOVF        _yellow_time+0, 0 
	MOVWF       FARG_delay_s_seconds+0 
	MOVF        _yellow_time+1, 0 
	MOVWF       FARG_delay_s_seconds+1 
	CALL        _delay_s+0, 0
;firmware.c,109 :: 		RED = 0; YELLOW = 0; GREEN = 1;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,110 :: 		delay_s(green_time);
	MOVF        _green_time+0, 0 
	MOVWF       FARG_delay_s_seconds+0 
	MOVF        _green_time+1, 0 
	MOVWF       FARG_delay_s_seconds+1 
	CALL        _delay_s+0, 0
;firmware.c,111 :: 		}
	GOTO        L_loop36
L_loop37:
;firmware.c,112 :: 		}
	GOTO        L_loop30
L_loop29:
	MOVF        _mode+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_loop31
	MOVF        _mode+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_loop32
	MOVF        _mode+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_loop35
L_loop30:
;firmware.c,113 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_main:

;firmware.c,115 :: 		void main() {
;firmware.c,116 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,117 :: 		while (1) loop();
L_main38:
	CALL        _loop+0, 0
	GOTO        L_main38
;firmware.c,118 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
