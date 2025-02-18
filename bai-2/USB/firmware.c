int current_mode, is_physics_control, i;
char transmit_data, receive_data;

void turn_off_all_led();
void switch_mode(int mode);
void handle_button(int button, int mode);
void update_led_status();
void send_led_status(char status);
void delay(int time);

void main()
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

    // UART config
    UART1_Init(9600);
    Delay_ms(100);

    current_mode = 3;
    is_physics_control = 1;
    turn_off_all_led();

    while (1)
    {
        if (UART1_Data_Ready())
        {
            receive_data = UART1_Read();
            switch (receive_data)
            {
            case 'Z':
                is_physics_control = 1;
                transmit_data = 'E';
                UART1_Write(transmit_data);
                break;
            case 'X':
                is_physics_control = 0;
                transmit_data = 'D';
                UART1_Write(transmit_data);
                break;
            case '1':
                if (!is_physics_control && current_mode != 1)
                    switch_mode(1);
                break;
            case '2':
                if (!is_physics_control && current_mode != 2)
                    switch_mode(2);
                break;
            case '3':
                if (!is_physics_control && current_mode != 3)
                    switch_mode(3);
                break;
            }
        }

        handle_button(0, 1);
        handle_button(1, 2);
        handle_button(2, 3);

        update_led_status();
    }
}

void handle_button(int button, int mode)
{
    if (!is_physics_control)
        return;
    if (BUTTON(&PORTB, button, 10, 0))
    {
        while (BUTTON(&PORTB, button, 10, 0))
            ;
        if (current_mode != mode)
            switch_mode(mode);
    }
}

void update_led_status()
{
    switch (current_mode)
    {
    case 1:
        send_led_status('R');
        LATE0_bit = 1;
        delay(1000);
        break;
    case 2:
        send_led_status('Y');
        LATE1_bit = 1;
        delay(1000);
        send_led_status('O');
        LATE1_bit = 0;
        delay(1000);
        break;
    case 3:
        send_led_status('R');
        LATE2_bit = 0;
        LATE0_bit = 1;
        delay(5000);
        send_led_status('Y');
        LATE0_bit = 0;
        LATE1_bit = 1;
        delay(3000);
        send_led_status('G');
        LATE1_bit = 0;
        LATE2_bit = 1;
        delay(10000);
        break;
    }
}

void switch_mode(int mode)
{
    turn_off_all_led();

    switch (mode)
    {
    case 1:
        current_mode = 1;
        transmit_data = '!';
        break;
    case 2:
        current_mode = 2;
        transmit_data = '@';
        break;
    case 3:
        current_mode = 3;
        transmit_data = '#';
        break;
    }
    UART1_Write(transmit_data);
}

void turn_off_all_led()
{
    LATE0_bit = 0;
    LATE1_bit = 0;
    LATE2_bit = 0;
}

void send_led_status(char status)
{
    transmit_data = status;
    UART1_Write(transmit_data);
}

void delay(int time)
{
    for (i = 0; i < time; i++)
    {
        if ((is_physics_control && (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))) ||
            (UART1_Data_Ready() && !is_physics_control && (receive_data == '1' || receive_data == '2' || receive_data == '3')) ||
            (UART1_Data_Ready() && (receive_data == 'Z' || receive_data == 'X')))
            break;
        Delay_ms(1);
    }
}