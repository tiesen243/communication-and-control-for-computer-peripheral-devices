int current_mode, can_control, i;
char transmit_data, receive_data;

void mode_1();           // Always Red
void mode_2();           // Blinking Yellow 1s
void mode_3();           // Auto mode (Red 5s -> Yellow 3s -> Green 10s)
void delay(int time);    // Delay function with break condition
void turn_off_all_led(); // Turn off all LEDs

void main()
{
    ADCON1 |= 0x0F; // Configure all ports as digital
    CMCON |= 7;     // Disable comparators

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

    // Init at MODE 3
    can_control = 1;
    current_mode = 3;
    turn_off_all_led();

    while (1)
    {
        if (UART1_Data_Ready()) // Check if data is received
            receive_data = UART1_Read();

        if ((can_control && BUTTON(&PORTB, 0, 10, 0)) || (!can_control && receive_data == '1'))
        { // Check if button 1 is pressed or data received is 1
            while (BUTTON(&PORTB, 0, 10, 0))
                ;
            if (current_mode != 1)
            {
                turn_off_all_led();
                current_mode = 1;
                transmit_data = '!';
                UART1_Write(transmit_data);
            }
        }
        else if ((can_control && BUTTON(&PORTB, 1, 10, 0)) || (!can_control && receive_data == '2'))
        { // Check if button 2 is pressed or data received is 2
            while (BUTTON(&PORTB, 1, 10, 0))
                ;
            if (current_mode != 2)
            {
                turn_off_all_led();
                current_mode = 2;
                transmit_data = '@';
                UART1_Write(transmit_data);
            }
        }
        else if ((can_control && BUTTON(&PORTB, 2, 10, 0)) || (!can_control && receive_data == '3'))
        { // Check if button 3 is pressed or data received is 3
            while (BUTTON(&PORTB, 2, 10, 0))
                ;
            if (current_mode != 3)
            {
                turn_off_all_led();
                current_mode = 3;
                transmit_data = '#';
                UART1_Write(transmit_data);
            }
        }

        if (receive_data == 'C')
            can_control = 1;
        else if (receive_data == 'U')
            can_control = 0;

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

void mode_3()
{ // Auto mode (Red 5s -> Yellow 3s -> Green 10s)
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

void mode_2()
{ // Blinking Yellow 1s
    LATE1_bit = 1;
    delay(1000);
    LATE1_bit = 0;
    delay(1000);
}

void mode_1()
{ // Always Red
    LATE0_bit = 1;
    delay(1000);
}

void delay(int time)
{
    receive_data = UART1_Read();
    for (i = 0; i < 0.8 * time; i++)
    { // if data received, break the loop
        if (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0) ||
            (UART1_Data_Ready()) && (receive_data == '1' || receive_data == '2' || receive_data == '3'))
            break;
        Delay_ms(1);
    }
}

void turn_off_all_led()
{
    LATE0_bit = 0;
    LATE1_bit = 0;
    LATE2_bit = 0;
}