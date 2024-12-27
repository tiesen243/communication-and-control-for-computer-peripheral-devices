char TransmitData, ReceiveData;

void main()
{
    ADCON1 |= 0x0F;
    CMCON |= 7;

    // Nut nhan o chan RB0
    PORTB = 0x00;
    LATB = 0x00;
    TRISB0_bit = 1;

    // LED o chan RE1
    PORTE = 0x00;
    LATE = 0x00;
    TRISE1_bit = 0;

    LATE1_bit = 0;

    // Cau hinh USART
    UART1_Init(9600);
    Delay_ms(100);

    while (1)
    {
        if (BUTTON(&PORTB, 0, 10, 0))
        {
            while (BUTTON(&PORTB, 0, 10, 0))
                ;
            TransmitData = 'S';
            UART1_Write(TransmitData);
        }

        if (UART1_Data_Ready())
        {
            ReceiveData = UART1_Read();
            if (ReceiveData == '@')
            {
                LATE1_bit = 1;
                TransmitData = 'O';
                UART1_Write(TransmitData);
            }
            else if (ReceiveData == '$')
            {
                LATE1_bit = 0;
                TransmitData = 'F';
                UART1_Write(TransmitData);
            }
        }
    }
}