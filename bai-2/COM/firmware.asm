
_main:

;firmware.c,11 :: 		void main()
;firmware.c,13 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,14 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,17 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,18 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,19 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,20 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,21 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,24 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,25 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,26 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,27 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,28 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,31 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;firmware.c,32 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;firmware.c,34 :: 		current_mode = 3;
	MOVLW       3
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,35 :: 		allow_control = 1;
	MOVLW       1
	MOVWF       _allow_control+0 
	MOVLW       0
	MOVWF       _allow_control+1 
;firmware.c,36 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,38 :: 		while (1)
L_main1:
;firmware.c,41 :: 		if (UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;firmware.c,42 :: 		receive_data = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _receive_data+0 
L_main3:
;firmware.c,44 :: 		if (receive_data == 'Y')
	MOVF        _receive_data+0, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;firmware.c,46 :: 		allow_control = 1;
	MOVLW       1
	MOVWF       _allow_control+0 
	MOVLW       0
	MOVWF       _allow_control+1 
;firmware.c,47 :: 		transmit_data = 'E';
	MOVLW       69
	MOVWF       _transmit_data+0 
;firmware.c,48 :: 		UART1_Write(transmit_data);
	MOVLW       69
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,49 :: 		}
	GOTO        L_main5
L_main4:
;firmware.c,50 :: 		else if (receive_data == 'N')
	MOVF        _receive_data+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;firmware.c,52 :: 		allow_control = 0;
	CLRF        _allow_control+0 
	CLRF        _allow_control+1 
;firmware.c,53 :: 		transmit_data = 'D';
	MOVLW       68
	MOVWF       _transmit_data+0 
;firmware.c,54 :: 		UART1_Write(transmit_data);
	MOVLW       68
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,55 :: 		}
L_main6:
L_main5:
;firmware.c,57 :: 		if (allow_control)
	MOVF        _allow_control+0, 0 
	IORWF       _allow_control+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;firmware.c,59 :: 		if (BUTTON(&PORTB, 0, 10, 0))
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
	GOTO        L_main8
;firmware.c,61 :: 		while (BUTTON(&PORTB, 0, 10, 0))
L_main9:
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
	GOTO        L_main10
;firmware.c,62 :: 		;
	GOTO        L_main9
L_main10:
;firmware.c,63 :: 		if (current_mode != 1)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__main63:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;firmware.c,64 :: 		switch_mode(1);
	MOVLW       1
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main11:
;firmware.c,65 :: 		}
	GOTO        L_main12
L_main8:
;firmware.c,66 :: 		else if (BUTTON(&PORTB, 1, 10, 0))
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
	GOTO        L_main13
;firmware.c,68 :: 		while (BUTTON(&PORTB, 1, 10, 0))
L_main14:
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
	GOTO        L_main15
;firmware.c,69 :: 		;
	GOTO        L_main14
L_main15:
;firmware.c,70 :: 		if (current_mode != 2)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main64
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__main64:
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
;firmware.c,71 :: 		switch_mode(2);
	MOVLW       2
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main16:
;firmware.c,72 :: 		}
	GOTO        L_main17
L_main13:
;firmware.c,73 :: 		else if (BUTTON(&PORTB, 2, 10, 0))
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
	GOTO        L_main18
;firmware.c,75 :: 		while (BUTTON(&PORTB, 2, 10, 0))
L_main19:
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
	GOTO        L_main20
;firmware.c,76 :: 		;
	GOTO        L_main19
L_main20:
;firmware.c,77 :: 		if (current_mode != 3)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__main65:
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
;firmware.c,78 :: 		switch_mode(3);
	MOVLW       3
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main21:
;firmware.c,79 :: 		}
L_main18:
L_main17:
L_main12:
;firmware.c,80 :: 		}
	GOTO        L_main22
L_main7:
;firmware.c,83 :: 		if (receive_data == '1')
	MOVF        _receive_data+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;firmware.c,85 :: 		if (current_mode != 1)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main66
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__main66:
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;firmware.c,86 :: 		switch_mode(1);
	MOVLW       1
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main24:
;firmware.c,87 :: 		}
	GOTO        L_main25
L_main23:
;firmware.c,88 :: 		else if (receive_data == '2')
	MOVF        _receive_data+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
;firmware.c,90 :: 		if (current_mode != 2)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main67
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__main67:
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
;firmware.c,91 :: 		switch_mode(2);
	MOVLW       2
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main27:
;firmware.c,92 :: 		}
	GOTO        L_main28
L_main26:
;firmware.c,93 :: 		else if (receive_data == '3')
	MOVF        _receive_data+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
;firmware.c,95 :: 		if (current_mode != 3)
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main68
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__main68:
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
;firmware.c,96 :: 		switch_mode(3);
	MOVLW       3
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main30:
;firmware.c,97 :: 		}
L_main29:
L_main28:
L_main25:
;firmware.c,98 :: 		}
L_main22:
;firmware.c,100 :: 		switch (current_mode)
	GOTO        L_main31
;firmware.c,102 :: 		case 1:
L_main33:
;firmware.c,103 :: 		mode_1();
	CALL        _mode_1+0, 0
;firmware.c,104 :: 		break;
	GOTO        L_main32
;firmware.c,105 :: 		case 2:
L_main34:
;firmware.c,106 :: 		mode_2();
	CALL        _mode_2+0, 0
;firmware.c,107 :: 		break;
	GOTO        L_main32
;firmware.c,108 :: 		case 3:
L_main35:
;firmware.c,109 :: 		mode_3();
	CALL        _mode_3+0, 0
;firmware.c,110 :: 		break;
	GOTO        L_main32
;firmware.c,111 :: 		default:
L_main36:
;firmware.c,112 :: 		break;
	GOTO        L_main32
;firmware.c,113 :: 		}
L_main31:
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main69
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__main69:
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__main70:
	BTFSC       STATUS+0, 2 
	GOTO        L_main34
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main71
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__main71:
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
	GOTO        L_main36
L_main32:
;firmware.c,114 :: 		}
	GOTO        L_main1
;firmware.c,115 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_mode_1:

;firmware.c,117 :: 		void mode_1()
;firmware.c,119 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,120 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,121 :: 		}
L_end_mode_1:
	RETURN      0
; end of _mode_1

_mode_2:

;firmware.c,123 :: 		void mode_2()
;firmware.c,125 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,126 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,127 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,128 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,129 :: 		}
L_end_mode_2:
	RETURN      0
; end of _mode_2

_mode_3:

;firmware.c,131 :: 		void mode_3()
;firmware.c,133 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,134 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,135 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,136 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,137 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,138 :: 		delay(3000);
	MOVLW       184
	MOVWF       FARG_delay_time+0 
	MOVLW       11
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,139 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,140 :: 		LATE2_bit = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,141 :: 		delay(10000);
	MOVLW       16
	MOVWF       FARG_delay_time+0 
	MOVLW       39
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,142 :: 		}
L_end_mode_3:
	RETURN      0
; end of _mode_3

_switch_mode:

;firmware.c,144 :: 		void switch_mode(int mode)
;firmware.c,146 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,148 :: 		switch (mode)
	GOTO        L_switch_mode37
;firmware.c,150 :: 		case 1:
L_switch_mode39:
;firmware.c,151 :: 		current_mode = 1;
	MOVLW       1
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,152 :: 		transmit_data = '!';
	MOVLW       33
	MOVWF       _transmit_data+0 
;firmware.c,153 :: 		UART1_Write(transmit_data);
	MOVLW       33
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,154 :: 		break;
	GOTO        L_switch_mode38
;firmware.c,155 :: 		case 2:
L_switch_mode40:
;firmware.c,156 :: 		current_mode = 2;
	MOVLW       2
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,157 :: 		transmit_data = '@';
	MOVLW       64
	MOVWF       _transmit_data+0 
;firmware.c,158 :: 		UART1_Write(transmit_data);
	MOVLW       64
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,159 :: 		break;
	GOTO        L_switch_mode38
;firmware.c,160 :: 		case 3:
L_switch_mode41:
;firmware.c,161 :: 		current_mode = 3;
	MOVLW       3
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,162 :: 		transmit_data = '#';
	MOVLW       35
	MOVWF       _transmit_data+0 
;firmware.c,163 :: 		UART1_Write(transmit_data);
	MOVLW       35
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,164 :: 		break;
	GOTO        L_switch_mode38
;firmware.c,165 :: 		}
L_switch_mode37:
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode76
	MOVLW       1
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode76:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode39
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode77
	MOVLW       2
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode77:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode40
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode78
	MOVLW       3
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode78:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode41
L_switch_mode38:
;firmware.c,166 :: 		}
L_end_switch_mode:
	RETURN      0
; end of _switch_mode

_turn_off_all_led:

;firmware.c,168 :: 		void turn_off_all_led()
;firmware.c,170 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,171 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,172 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,173 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_delay:

;firmware.c,175 :: 		void delay(int time)
;firmware.c,177 :: 		for (i = 0; i < 0.8 * time; i++)
	CLRF        _i+0 
	CLRF        _i+1 
L_delay42:
	MOVF        FARG_delay_time+0, 0 
	MOVWF       R0 
	MOVF        FARG_delay_time+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__delay+0 
	MOVF        R1, 0 
	MOVWF       FLOC__delay+1 
	MOVF        R2, 0 
	MOVWF       FLOC__delay+2 
	MOVF        R3, 0 
	MOVWF       FLOC__delay+3 
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        FLOC__delay+0, 0 
	MOVWF       R4 
	MOVF        FLOC__delay+1, 0 
	MOVWF       R5 
	MOVF        FLOC__delay+2, 0 
	MOVWF       R6 
	MOVF        FLOC__delay+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay43
;firmware.c,179 :: 		if ((allow_control && (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))) ||
	MOVF        _allow_control+0, 0 
	IORWF       _allow_control+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay60
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
	GOTO        L__delay61
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
	GOTO        L__delay61
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
	GOTO        L__delay61
	GOTO        L__delay60
L__delay61:
	GOTO        L__delay57
;firmware.c,180 :: 		(UART1_Data_Ready() && (receive_data == '1' || receive_data == '2' || receive_data == '3')))
L__delay60:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay58
	MOVF        _receive_data+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L__delay59
	MOVF        _receive_data+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__delay59
	MOVF        _receive_data+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L__delay59
	GOTO        L__delay58
L__delay59:
	GOTO        L__delay57
L__delay58:
	GOTO        L_delay55
L__delay57:
;firmware.c,181 :: 		break;
	GOTO        L_delay43
L_delay55:
;firmware.c,182 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay56:
	DECFSZ      R13, 1, 1
	BRA         L_delay56
	DECFSZ      R12, 1, 1
	BRA         L_delay56
;firmware.c,177 :: 		for (i = 0; i < 0.8 * time; i++)
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;firmware.c,183 :: 		}
	GOTO        L_delay42
L_delay43:
;firmware.c,184 :: 		}
L_end_delay:
	RETURN      0
; end of _delay
