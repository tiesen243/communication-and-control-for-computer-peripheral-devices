
_interrupt:

;firmware.c,15 :: 		void interrupt(void) {
;firmware.c,16 :: 		if (USBIF_bit == 1)
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt0
;firmware.c,18 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,19 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;firmware.c,20 :: 		}
L_interrupt0:
;firmware.c,21 :: 		}
L_end_interrupt:
L__interrupt50:
	RETFIE      1
; end of _interrupt

_main:

;firmware.c,23 :: 		void main()
;firmware.c,25 :: 		setup();
	CALL        _setup+0, 0
;firmware.c,26 :: 		while (1) loop();
L_main1:
	CALL        _loop+0, 0
	GOTO        L_main1
;firmware.c,27 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_setup:

;firmware.c,29 :: 		void setup()
;firmware.c,31 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;firmware.c,32 :: 		CMCON |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;firmware.c,35 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;firmware.c,36 :: 		LATB = 0x00;
	CLRF        LATB+0 
;firmware.c,37 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;firmware.c,38 :: 		TRISB1_bit = 1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;firmware.c,39 :: 		TRISB2_bit = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;firmware.c,42 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;firmware.c,43 :: 		LATE = 0x00;
	CLRF        LATE+0 
;firmware.c,44 :: 		TRISE0_bit = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;firmware.c,45 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;firmware.c,46 :: 		TRISE2_bit = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;firmware.c,49 :: 		UPUEN_bit = 1;
	BSF         UPUEN_bit+0, BitPos(UPUEN_bit+0) 
;firmware.c,50 :: 		FSEN_bit = 1;
	BSF         FSEN_bit+0, BitPos(FSEN_bit+0) 
;firmware.c,51 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;firmware.c,53 :: 		USBIF_bit = 0;
	BCF         USBIF_bit+0, BitPos(USBIF_bit+0) 
;firmware.c,54 :: 		USBIE_bit = 1;
	BSF         USBIE_bit+0, BitPos(USBIE_bit+0) 
;firmware.c,55 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;firmware.c,56 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;firmware.c,58 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_setup3:
	DECFSZ      R13, 1, 1
	BRA         L_setup3
	DECFSZ      R12, 1, 1
	BRA         L_setup3
	DECFSZ      R11, 1, 1
	BRA         L_setup3
	NOP
	NOP
;firmware.c,60 :: 		current_mode = 3;
	MOVLW       3
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,61 :: 		is_physics_control = 1;
	MOVLW       1
	MOVWF       _is_physics_control+0 
	MOVLW       0
	MOVWF       _is_physics_control+1 
;firmware.c,62 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,63 :: 		}
L_end_setup:
	RETURN      0
; end of _setup

_loop:

;firmware.c,65 :: 		void loop()
;firmware.c,67 :: 		switch (current_mode)
	GOTO        L_loop4
;firmware.c,69 :: 		case 1:
L_loop6:
;firmware.c,70 :: 		send_led_status('R');
	MOVLW       82
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,71 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,72 :: 		delay(100);
	MOVLW       100
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,73 :: 		break;
	GOTO        L_loop5
;firmware.c,74 :: 		case 2:
L_loop7:
;firmware.c,75 :: 		send_led_status('Y');
	MOVLW       89
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,76 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,77 :: 		delay(100);
	MOVLW       100
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,78 :: 		send_led_status('O');
	MOVLW       79
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,79 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,80 :: 		delay(100);
	MOVLW       100
	MOVWF       FARG_delay_time+0 
	MOVLW       0
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,81 :: 		break;
	GOTO        L_loop5
;firmware.c,82 :: 		case 3:
L_loop8:
;firmware.c,83 :: 		send_led_status('R');
	MOVLW       82
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,84 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,85 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,86 :: 		delay(500);
	MOVLW       244
	MOVWF       FARG_delay_time+0 
	MOVLW       1
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,87 :: 		send_led_status('Y');
	MOVLW       89
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,88 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,89 :: 		LATE1_bit = 1;
	BSF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,90 :: 		delay(300);
	MOVLW       44
	MOVWF       FARG_delay_time+0 
	MOVLW       1
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,91 :: 		send_led_status('G');
	MOVLW       71
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,92 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,93 :: 		LATE2_bit = 1;
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,94 :: 		delay(1000);
	MOVLW       232
	MOVWF       FARG_delay_time+0 
	MOVLW       3
	MOVWF       FARG_delay_time+1 
	CALL        _delay+0, 0
;firmware.c,95 :: 		break;
	GOTO        L_loop5
;firmware.c,96 :: 		}
L_loop4:
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop54
	MOVLW       1
	XORWF       _current_mode+0, 0 
L__loop54:
	BTFSC       STATUS+0, 2 
	GOTO        L_loop6
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop55
	MOVLW       2
	XORWF       _current_mode+0, 0 
L__loop55:
	BTFSC       STATUS+0, 2 
	GOTO        L_loop7
	MOVLW       0
	XORWF       _current_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__loop56
	MOVLW       3
	XORWF       _current_mode+0, 0 
L__loop56:
	BTFSC       STATUS+0, 2 
	GOTO        L_loop8
L_loop5:
;firmware.c,97 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_delay:

;firmware.c,101 :: 		void delay(int time)
;firmware.c,103 :: 		for (i = 0; i < time; i++)
	CLRF        _i+0 
	CLRF        _i+1 
L_delay9:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_delay_time+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay58
	MOVF        FARG_delay_time+0, 0 
	SUBWF       _i+0, 0 
L__delay58:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay10
;firmware.c,105 :: 		if ((is_physics_control && (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))) ||
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay47
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
	GOTO        L__delay48
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
	GOTO        L__delay48
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
	GOTO        L__delay48
	GOTO        L__delay47
L__delay48:
	GOTO        L__delay45
;firmware.c,106 :: 		HID_Read() != 0 && readbuff[0]) {
L__delay47:
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__delay46
	MOVF        1280, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__delay46
	GOTO        L__delay45
L__delay46:
	GOTO        L_delay20
L__delay45:
;firmware.c,107 :: 		if (readbuff[0] == 'Z')
	MOVF        1280, 0 
	XORLW       90
	BTFSS       STATUS+0, 2 
	GOTO        L_delay21
;firmware.c,109 :: 		is_physics_control = 1;
	MOVLW       1
	MOVWF       _is_physics_control+0 
	MOVLW       0
	MOVWF       _is_physics_control+1 
;firmware.c,110 :: 		send_led_status('E');
	MOVLW       69
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,111 :: 		}
	GOTO        L_delay22
L_delay21:
;firmware.c,112 :: 		else if (readbuff[0] == 'X')
	MOVF        1280, 0 
	XORLW       88
	BTFSS       STATUS+0, 2 
	GOTO        L_delay23
;firmware.c,114 :: 		is_physics_control = 0;
	CLRF        _is_physics_control+0 
	CLRF        _is_physics_control+1 
;firmware.c,115 :: 		send_led_status('D');
	MOVLW       68
	MOVWF       FARG_send_led_status_status+0 
	CALL        _send_led_status+0, 0
;firmware.c,116 :: 		}
	GOTO        L_delay24
L_delay23:
;firmware.c,117 :: 		else if (readbuff[0] == '1' && is_physics_control ==0)
	MOVF        1280, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_delay27
	MOVLW       0
	XORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay59
	MOVLW       0
	XORWF       _is_physics_control+0, 0 
L__delay59:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay27
L__delay44:
;firmware.c,119 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,120 :: 		current_mode = 1;
	MOVLW       1
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,121 :: 		break;
	GOTO        L_delay10
;firmware.c,122 :: 		}
L_delay27:
;firmware.c,123 :: 		else if (readbuff[0] == '2' && is_physics_control == 0)
	MOVF        1280, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_delay31
	MOVLW       0
	XORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay60
	MOVLW       0
	XORWF       _is_physics_control+0, 0 
L__delay60:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay31
L__delay43:
;firmware.c,125 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,126 :: 		current_mode = 2;
	MOVLW       2
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,127 :: 		break;
	GOTO        L_delay10
;firmware.c,128 :: 		}
L_delay31:
;firmware.c,129 :: 		else if (readbuff[0] == '3' && is_physics_control == 0)
	MOVF        1280, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_delay35
	MOVLW       0
	XORWF       _is_physics_control+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay61
	MOVLW       0
	XORWF       _is_physics_control+0, 0 
L__delay61:
	BTFSS       STATUS+0, 2 
	GOTO        L_delay35
L__delay42:
;firmware.c,131 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,132 :: 		current_mode = 3;
	MOVLW       3
	MOVWF       _current_mode+0 
	MOVLW       0
	MOVWF       _current_mode+1 
;firmware.c,133 :: 		break;
	GOTO        L_delay10
;firmware.c,135 :: 		}
L_delay35:
L_delay24:
L_delay22:
;firmware.c,137 :: 		if (is_physics_control)
	MOVF        _is_physics_control+0, 0 
	IORWF       _is_physics_control+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_delay36
;firmware.c,139 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,140 :: 		handle_button(0, 1);
	CLRF        FARG_handle_button_button+0 
	CLRF        FARG_handle_button_button+1 
	MOVLW       1
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,141 :: 		handle_button(1, 2);
	MOVLW       1
	MOVWF       FARG_handle_button_button+0 
	MOVLW       0
	MOVWF       FARG_handle_button_button+1 
	MOVLW       2
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,142 :: 		handle_button(2, 3);
	MOVLW       2
	MOVWF       FARG_handle_button_button+0 
	MOVLW       0
	MOVWF       FARG_handle_button_button+1 
	MOVLW       3
	MOVWF       FARG_handle_button_mode+0 
	MOVLW       0
	MOVWF       FARG_handle_button_mode+1 
	CALL        _handle_button+0, 0
;firmware.c,143 :: 		break;
	GOTO        L_delay10
;firmware.c,144 :: 		}
L_delay36:
;firmware.c,146 :: 		}
L_delay20:
;firmware.c,147 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_delay37:
	DECFSZ      R13, 1, 1
	BRA         L_delay37
	DECFSZ      R12, 1, 1
	BRA         L_delay37
	NOP
;firmware.c,103 :: 		for (i = 0; i < time; i++)
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;firmware.c,148 :: 		}
	GOTO        L_delay9
L_delay10:
;firmware.c,149 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_handle_button:

;firmware.c,151 :: 		void handle_button(int button, int mode)
;firmware.c,153 :: 		turn_off_all_led();
	CALL        _turn_off_all_led+0, 0
;firmware.c,154 :: 		if (BUTTON(&PORTB, button, 10, 0))
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
	GOTO        L_handle_button38
;firmware.c,156 :: 		while (BUTTON(&PORTB, button, 10, 0))
L_handle_button39:
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
	GOTO        L_handle_button40
;firmware.c,157 :: 		;
	GOTO        L_handle_button39
L_handle_button40:
;firmware.c,158 :: 		if (current_mode != mode)
	MOVF        _current_mode+1, 0 
	XORWF       FARG_handle_button_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__handle_button63
	MOVF        FARG_handle_button_mode+0, 0 
	XORWF       _current_mode+0, 0 
L__handle_button63:
	BTFSC       STATUS+0, 2 
	GOTO        L_handle_button41
;firmware.c,159 :: 		current_mode = mode;
	MOVF        FARG_handle_button_mode+0, 0 
	MOVWF       _current_mode+0 
	MOVF        FARG_handle_button_mode+1, 0 
	MOVWF       _current_mode+1 
L_handle_button41:
;firmware.c,160 :: 		}
L_handle_button38:
;firmware.c,161 :: 		}
L_end_handle_button:
	RETURN      0
; end of _handle_button

_turn_off_all_led:

;firmware.c,163 :: 		void turn_off_all_led()
;firmware.c,165 :: 		LATE0_bit = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;firmware.c,166 :: 		LATE1_bit = 0;
	BCF         LATE1_bit+0, BitPos(LATE1_bit+0) 
;firmware.c,167 :: 		LATE2_bit = 0;
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;firmware.c,168 :: 		}
L_end_turn_off_all_led:
	RETURN      0
; end of _turn_off_all_led

_send_led_status:

;firmware.c,170 :: 		void send_led_status(char status)
;firmware.c,172 :: 		writebuff[0] = status;
	MOVF        FARG_send_led_status_status+0, 0 
	MOVWF       1344 
;firmware.c,173 :: 		HID_Write(&writebuff, out_size);
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       1
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
;firmware.c,174 :: 		}
L_end_send_led_status:
	RETURN      0
; end of _send_led_status
