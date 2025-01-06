int current_mode, allow_control, i;
char transmit_data, receive_data;

void mode_1();
void mode_2();
void mode_3();
void switch_mode(int mode);
void delay(int time);
void turn_off_all_led();

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
    allow_control = 1;
    turn_off_all_led();

    while (1)
    {

        if (UART1_Data_Ready())
            receive_data = UART1_Read();

        if (receive_data == 'A')
        {
            allow_control = 1;
            transmit_data = 'E';
            UART1_Write(transmit_data);
        }
        else if (receive_data == 'U')
        {
            allow_control = 0;
            transmit_data = 'D';
            UART1_Write(transmit_data);
        }

        if (allow_control)
        {
            if (BUTTON(&PORTB, 0, 10, 0))
            {
                while (BUTTON(&PORTB, 0, 10, 0))
                    ;
                if (current_mode != 1)
                    switch_mode(1);
            }
            else if (BUTTON(&PORTB, 1, 10, 0))
            {
                while (BUTTON(&PORTB, 1, 10, 0))
                    ;
                if (current_mode != 2)
                    switch_mode(2);
            }
            else if (BUTTON(&PORTB, 2, 10, 0))
            {
                while (BUTTON(&PORTB, 2, 10, 0))
                    ;
                if (current_mode != 3)
                    switch_mode(3);
            }
        }
        else
        {
            if (receive_data == '1')
            {
                if (current_mode != 1)
                    switch_mode(1);
            }
            else if (receive_data == '2')
            {
                if (current_mode != 2)
                    switch_mode(2);
            }
            else if (receive_data == '3')
            {
                if (current_mode != 3)
                    switch_mode(3);
            }
        }

        switch (current_mode)
        {
        case 1:
            mode_1();
            break;
        case 2:
            mode_2();
            break;
        case 3:
            mode_3();
            break;
        default:
            break;
        }
    }
}

void mode_1()
{
    LATE0_bit = 1;
    delay(1000);
}

void mode_2()
{
    LATE1_bit = 1;
    delay(1000);
    LATE1_bit = 0;
    delay(1000);
}

void mode_3()
{
    LATE2_bit = 0;
    LATE0_bit = 1;
    delay(5000);
    LATE0_bit = 0;
    LATE1_bit = 1;
    delay(3000);
    LATE1_bit = 0;
    LATE2_bit = 1;
    delay(10000);
}

void switch_mode(int mode)
{
    turn_off_all_led();

    switch (mode)
    {
    case 1:
        current_mode = 1;
        transmit_data = '!';
        UART1_Write(transmit_data);
        break;
    case 2:
        current_mode = 2;
        transmit_data = '@';
        UART1_Write(transmit_data);
        break;
    case 3:
        current_mode = 3;
        transmit_data = '#';
        UART1_Write(transmit_data);
        break;
    }
}

void turn_off_all_led()
{
    LATE0_bit = 0;
    LATE1_bit = 0;
    LATE2_bit = 0;
}

void delay(int time)
{
    for (i = 0; i < 0.8 * time; i++)
    {
        if (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0) ||
            (UART1_Data_Ready()) && (receive_data == '1' || receive_data == '2' || receive_data == '3'))
            break;
        Delay_ms(1);
    }
}
