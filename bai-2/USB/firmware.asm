
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
;firmware.c,35 :: 		is_physics_control = 1;
	MOVLW       1
	MOVWF       _is_physics_control+0 
	MOVLW       0
	MOVWF       _is_physics_control+1 
;firmware.c,36 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,38 :: 		while (1)
L_main1:
;firmware.c,40 :: 		if (UART1_Data_Ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;firmware.c,42 :: 		receive_data = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _receive_data+0 
;firmware.c,43 :: 		switch (receive_data)
	GOTO        L_main4
;firmware.c,45 :: 		case 'Z':
L_main6:
;firmware.c,46 :: 		is_physics_control = 1;
	MOVLW       1
	MOVWF       _is_physics_control+0 
	MOVLW       0
	MOVWF       _is_physics_control+1 
;firmware.c,47 :: 		transmit_data = 'E';
	MOVLW       69
	MOVWF       _transmit_data+0 
;firmware.c,48 :: 		UART1_Write(transmit_data);
	MOVLW       69
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,49 :: 		break;
	GOTO        L_main5
;firmware.c,50 :: 		case 'X':
L_main7:
;firmware.c,51 :: 		is_physics_control = 0;
	CLRF        _is_physics_control+0 
	CLRF        _is_physics_control+1 
;firmware.c,52 :: 		transmit_data = 'D';
	MOVLW       68
	MOVWF       _transmit_data+0 
;firmware.c,53 :: 		UART1_Write(transmit_data);
	MOVLW       68
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,54 :: 		break;
	GOTO        L_main5
;firmware.c,55 :: 		case '1':
L_main8:
;firmware.c,56 :: 		if (!is_physics_control && current_mode != 1)
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__main65:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L__main56:
;firmware.c,57 :: 		switch_mode(1);
	MOVLW       1
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main11:
;firmware.c,58 :: 		break;
	GOTO        L_main5
;firmware.c,59 :: 		case '2':
L_main12:
;firmware.c,60 :: 		if (!is_physics_control && current_mode != 2)
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main66
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__main66:
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
L__main55:
;firmware.c,61 :: 		switch_mode(2);
	MOVLW       2
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main15:
;firmware.c,62 :: 		break;
	GOTO        L_main5
;firmware.c,63 :: 		case '3':
L_main16:
;firmware.c,64 :: 		if (!is_physics_control && current_mode != 3)
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main67
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__main67:
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
L__main54:
;firmware.c,65 :: 		switch_mode(3);
	MOVLW       3
	MOVWF       FARG_switch_mode_mode+0 
	MOVLW       0
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_main19:
;firmware.c,66 :: 		break;
	GOTO        L_main5
;firmware.c,67 :: 		}
L_main4:
	MOVF        _receive_data+0, 0 
	XORLW       90
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        _receive_data+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        _receive_data+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _receive_data+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        _receive_data+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
L_main5:
;firmware.c,68 :: 		}
L_main3:
;firmware.c,70 :: 		handle_button(0, 1);
	CLRF        FARG_handle_button_button+0 
	CLRF        FARG_handle_button_button+1 
	MOVLW       1
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,71 :: 		handle_button(1, 2);
	MOVLW       1
	MOVWF       FARG_handle_button_button+0 
	MOVLW       0
	MOVWF       FARG_handle_button_button+1 
	MOVLW       2
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,72 :: 		handle_button(2, 3);
	MOVLW       2
	MOVWF       FARG_handle_button_button+0 
	MOVLW       0
	MOVWF       FARG_handle_button_button+1 
	MOVLW       3
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,74 :: 		update_led_status();
	CALL        _update_led_status+0, 0
;firmware.c,75 :: 		}
	GOTO        L_main1
;firmware.c,76 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_handle_button:

;firmware.c,78 :: 		void handle_button(int button, int mode)
;firmware.c,80 :: 		if (!is_physics_control)
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_handle_button20
;firmware.c,81 :: 		return;
	GOTO        L_end_handle_button
L_handle_button20:
;firmware.c,82 :: 		if (BUTTON(&PORTB, button, 10, 0))
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVF        FARG_handle_button_button+0, 0 
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_handle_button21
;firmware.c,84 :: 		while (BUTTON(&PORTB, button, 10, 0))
L_handle_button22:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVF        FARG_handle_button_button+0, 0 
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_handle_button23
;firmware.c,85 :: 		;
	GOTO        L_handle_button22
L_handle_button23:
;firmware.c,86 :: 		if (current_mode != mode)
	MOVF        _current_mode+1, 0 
	XORWF       FARG_handle_button_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__handle_button69
	MOVF        FARG_handle_button_mode+0, 0 
	XORWF       _current_mode+0, 0 
L__handle_button69:
	BTFSC       STATUS+0, 2 
	GOTO        L_handle_button24
;firmware.c,87 :: 		switch_mode(mode);
	MOVF        FARG_handle_button_mode+0, 0 
	MOVWF       FARG_switch_mode_mode+0 
	MOVF        FARG_handle_button_mode+1, 0 
	MOVWF       FARG_switch_mode_mode+1 
	CALL        _switch_mode+0, 0
L_handle_button24:
;firmware.c,88 :: 		}
L_handle_button21:
;firmware.c,89 :: 		}
L_end_handle_button:
	RETURN      0
; end of _handle_button

_update_led_status:

;firmware.c,91 :: 		void update_led_status()
;firmware.c,93 :: 		switch (current_mode)
	GOTO        L_update_led_status25
;firmware.c,95 :: 		case 1:
L_update_led_status27:
;firmware.c,96 :: 		send_led_status('R');
	MOVLW       82
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,97 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,98 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,99 :: 		break;
	GOTO        L_update_led_status26
;firmware.c,100 :: 		case 2:
L_update_led_status28:
;firmware.c,101 :: 		send_led_status('Y');
	MOVLW       89
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,102 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,103 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,104 :: 		send_led_status('O');
	MOVLW       79
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,105 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,106 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,107 :: 		break;
	GOTO        L_update_led_status26
;firmware.c,108 :: 		case 3:
L_update_led_status29:
;firmware.c,109 :: 		send_led_status('R');
	MOVLW       82
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,110 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,111 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,112 :: 		delay(5000);
	MOVLW       136
	MOVWF       FARG_delay_time+0 
	MOVLW       19
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,113 :: 		send_led_status('Y');
	MOVLW       89
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,114 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,115 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,116 :: 		delay(3000);
	MOVLW       184
	MOVWF       FARG_delay_time+0 
	MOVLW       11
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,117 :: 		send_led_status('G');
	MOVLW       71
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,118 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,119 :: 		LATE2_bit = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,120 :: 		delay(10000);
	MOVLW       16
	MOVWF       FARG_delay_time+0 
	MOVLW       39
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,121 :: 		break;
	GOTO        L_update_led_status26
;firmware.c,122 :: 		}
L_update_led_status25:
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_led_status71
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__update_led_status71:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_led_status27
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_led_status72
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__update_led_status72:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_led_status28
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_led_status73
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__update_led_status73:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_led_status29
L_update_led_status26:
;firmware.c,123 :: 		}
L_end_update_led_status:
	RETURN      0
; end of _update_led_status

_switch_mode:

;firmware.c,125 :: 		void switch_mode(int mode)
;firmware.c,127 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,129 :: 		switch (mode)
	GOTO        L_switch_mode30
;firmware.c,131 :: 		case 1:
L_switch_mode32:
;firmware.c,132 :: 		current_mode = 1;
	MOVLW       1
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,133 :: 		transmit_data = '!';
	MOVLW       33
	MOVWF       _transmit_data+0 
;firmware.c,134 :: 		break;
	GOTO        L_switch_mode31
;firmware.c,135 :: 		case 2:
L_switch_mode33:
;firmware.c,136 :: 		current_mode = 2;
	MOVLW       2
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,137 :: 		transmit_data = '@';
	MOVLW       64
	MOVWF       _transmit_data+0 
;firmware.c,138 :: 		break;
	GOTO        L_switch_mode31
;firmware.c,139 :: 		case 3:
L_switch_mode34:
;firmware.c,140 :: 		current_mode = 3;
	MOVLW       3
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,141 :: 		transmit_data = '#';
	MOVLW       35
	MOVWF       _transmit_data+0 
;firmware.c,142 :: 		break;
	GOTO        L_switch_mode31
;firmware.c,143 :: 		}
L_switch_mode30:
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode75
	MOVLW       1
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode75:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode32
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode76
	MOVLW       2
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode76:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode33
	MOVLW       0
	XORWF       FARG_switch_mode_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__switch_mode77
	MOVLW       3
	XORWF       FARG_switch_mode_mode+0, 0 
L__switch_mode77:
	BTFSC       STATUS+0, 2 
	GOTO        L_switch_mode34
L_switch_mode31:
;firmware.c,144 :: 		UART1_Write(transmit_data);
	MOVF        _transmit_data+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,145 :: 		}
L_end_switch_mode:
	RETURN      0
; end of _switch_mode

_turn_off_all_led:

;firmware.c,147 :: 		void turn_off_all_led()
;firmware.c,149 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,150 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,151 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,152 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_send_led_status:

;firmware.c,154 :: 		void send_led_status(char status)
;firmware.c,156 :: 		transmit_data = status;
	MOVF        FARG_send_led_status_status+0, 0 
	MOVWF       _transmit_data+0 
;firmware.c,157 :: 		UART1_Write(transmit_data);
	MOVF        FARG_send_led_status_status+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;firmware.c,158 :: 		}
L_end_send_led_status:
	RETURN      0
; end of _send_led_status

_delay:

;firmware.c,160 :: 		void delay(int time)
;firmware.c,162 :: 		for (i = 0; i < time; i++)
	CLRF        _i+0 
	CLRF        _i+1 
L_delay35:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_delay_time+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay81
	MOVF        FARG_delay_time+0, 0 
	SUBWF       _i+0, 0 
L__delay81:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay36
;firmware.c,164 :: 		if ((is_physics_control && (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))) ||
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay62
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
	GOTO        L__delay63
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
	GOTO        L__delay63
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
	GOTO        L__delay63
	GOTO        L__delay62
L__delay63:
	GOTO        L__delay57
;firmware.c,165 :: 		(UART1_Data_Ready() && !is_physics_control && (receive_data == '1' || receive_data == '2' || receive_data == '3')) ||
L__delay62:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay60
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay60
	MOVF        _receive_data+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L__delay61
	MOVF        _receive_data+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__delay61
	MOVF        _receive_data+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L__delay61
	GOTO        L__delay60
L__delay61:
	GOTO        L__delay57
L__delay60:
;firmware.c,166 :: 		(UART1_Data_Ready() && (receive_data == 'Z' || receive_data == 'X')))
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay58
	MOVF        _receive_data+0, 0 
	XORLW       90
	BTFSC       STATUS+0, 2 
	GOTO        L__delay59
	MOVF        _receive_data+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L__delay59
	GOTO        L__delay58
L__delay59:
	GOTO        L__delay57
L__delay58:
	GOTO        L_delay52
L__delay57:
;firmware.c,167 :: 		break;
	GOTO        L_delay36
L_delay52:
;firmware.c,168 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_delay53:
	DECFSZ      R13, 1, 1
	BRA         L_delay53
	DECFSZ      R12, 1, 1
	BRA         L_delay53
;firmware.c,162 :: 		for (i = 0; i < time; i++)
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;firmware.c,169 :: 		}
	GOTO        L_delay35
L_delay36:
;firmware.c,170 :: 		}
L_end_delay:
	RETURN      0
; end of _delay
