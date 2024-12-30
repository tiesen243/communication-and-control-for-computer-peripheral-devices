int current_mode, i;

void mode1();
void mode2();
void mode3();
void delay(int time);
void turn_off_all_led();

void main()
{
    ADCON1 |= 0x0F;
    CMCON |= 7;

    // Nut nhan o chan RB0-2 (MODE 1, MODE 2, MODE 3)
    PORTB = 0x00;
    LATB = 0x00;
    TRISB0_bit = 1;
    TRISB1_bit = 1;
    TRISB2_bit = 1;

    // LED o chan RE0-RE2 (Do, Vang, Xanh)
    PORTE = 0x00;
    LATE = 0x00;
    TRISE0_bit = 0;
    TRISE1_bit = 0;
    TRISE2_bit = 0;

    current_mode = 3;
    turn_off_all_led();

    while (1)
    {
        if (BUTTON(&PORTB, 0, 10, 0))
        {
            while (BUTTON(&PORTB, 0, 10, 0))
                ;
            turn_off_all_led();
            current_mode = 1;
        }
        else if (BUTTON(&PORTB, 1, 10, 0))
        {
            while (BUTTON(&PORTB, 1, 10, 0))
                ;
            turn_off_all_led();
            current_mode = 2;
        }
        else if (BUTTON(&PORTB, 2, 10, 0))
        {
            while (BUTTON(&PORTB, 2, 10, 0))
                ;
            turn_off_all_led();
            current_mode = 3;
        }

        switch (current_mode)
        {
        case 1:
            mode1();
            break;
        case 2:
            mode2();
            break;
        case 3:
            mode3();
            break;
        default:
            break;
        }
    }
}

void mode3()
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

void mode2()
{
    LATE1_bit = 1;
    delay(1000);
    LATE1_bit = 0;
    delay(1000);
}

void mode1()
{
    LATE0_bit = 1;
    delay(1000);
}

void delay(int time)
{
    for (i = 0; i < 0.8 * time; i++)
    {
        if (BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0))
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