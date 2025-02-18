#define in_size 1
#define out_size 1
unsigned char readbuff[in_size] absolute 0x500;
unsigned char writebuff[out_size] absolute 0x540;

int current_mode, is_physics_control, i;

void turn_off_all_led();
void handle_button(int button, int mode);
void send_led_status(char status);
void delay(int time);
void setup();
void loop();

void interrupt(void) {
     if (USBIF_bit == 1)
     {
        USBIF_bit = 0;
        USB_Interrupt_Proc();
     }
}

void main()
{
    setup();
    while (1) loop();
}

void setup()
{
    ADCON1 |= 0x0F;
    CMCON |= 7;

    // Button at RB0-2 (MODE 1, MODE 2, MODE 3)
    PORTB = 0x00;
    LATB = 0x00;
    TRISB0_bit = 1;
    TRISB1_bit = 1;
    TRISB2_bit = 1;

    // LED  at RE0-RE2 (RED, YELLOW, GREEN)
    PORTE = 0x00;
    LATE = 0x00;
    TRISE0_bit = 0;
    TRISE1_bit = 0;
    TRISE2_bit = 0;

    // USB config
    UPUEN_bit = 1;
    FSEN_bit = 1;
    HID_Enable(&readbuff, &writebuff);

    USBIF_bit = 0;
    USBIE_bit = 1;
    PEIE_bit = 1;
    GIE_bit = 1;

    Delay_ms(100);

    current_mode = 3;
    is_physics_control = 1;
    turn_off_all_led();
}

void loop()
{
    switch (current_mode)
    {
    case 1:
        send_led_status('R');
        LATE0_bit = 1;
        delay(100);
        break;
    case 2:
        send_led_status('Y');
        LATE1_bit = 1;
        delay(100);
        send_led_status('O');
        LATE1_bit = 0;
        delay(100);
        break;
    case 3:
        send_led_status('R');
        LATE2_bit = 0;
        LATE0_bit = 1;
        delay(500);
        send_led_status('Y');
        LATE0_bit = 0;
        LATE1_bit = 1;
        delay(300);
        send_led_status('G');
        LATE1_bit = 0;
        LATE2_bit = 1;
        delay(1000);
        break;
    }
}



void delay(int time)
{
    for (i = 0; i < time; i++)
    {
        if ((is_physics_control && (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))) || 
            HID_Read() != 0 && readbuff[0]) {
                if (readbuff[0] == 'Z')
                {
                    is_physics_control = 1;
                    send_led_status('E');
                }
                else if (readbuff[0] == 'X')
                {
                    is_physics_control = 0;
                    send_led_status('D');
                }
                else if (readbuff[0] == '1' && is_physics_control ==0)
                {
                    turn_off_all_led();
                    current_mode = 1;
                    break;
                }
                else if (readbuff[0] == '2' && is_physics_control == 0)
                {
                    turn_off_all_led();
                    current_mode = 2;
                    break;
                }
                else if (readbuff[0] == '3' && is_physics_control == 0)
                {
                    turn_off_all_led();
                    current_mode = 3;
                    break;
                    break;
                }

                if (is_physics_control)
                {
                    turn_off_all_led();
                    handle_button(0, 1);
                    handle_button(1, 2);
                    handle_button(2, 3);
                    break;
                }
                
            }
        Delay_ms(10);
    }
}

void handle_button(int button, int mode)
{
    turn_off_all_led();
    if (BUTTON(&PORTB, button, 10, 0))
    {
        while (BUTTON(&PORTB, button, 10, 0))
            ;
        if (current_mode != mode)
            current_mode = mode;
    }
}

void turn_off_all_led()
{
    LATE0_bit = 0;
    LATE1_bit = 0;
    LATE2_bit = 0;
}

void send_led_status(char status)
{
    writebuff[0] = status;
    HID_Write(&writebuff, out_size);
}