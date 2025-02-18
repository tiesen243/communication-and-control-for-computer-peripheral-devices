//------------------------------ DEFINE ------------------------------
#define RED     LATE0_bit
#define YELLOW  LATE1_bit
#define GREEN   LATE2_bit

#define in_size 1
#define out_size 1
unsigned char readbuff[in_size] absolute 0x500;
unsigned char writebuff[out_size] absolute 0x540;

int mode;

// ------------------------------ UTILS ------------------------------

void send(char msg) {
    writebuff[0] = msg;
    HID_Write(&writebuff, out_size);
}

void delay(int time) {
    unsigned int i;
    for (i = 0; i < time; i++) {
        Delay_ms(1);
    }
}


// ------------------------------ PROGRAM ------------------------------

void interrupt(void) {
     if (USBIF_bit == 1) {
        USBIF_bit = 0;
        USB_Interrupt_Proc();
     }
}



void setup() {
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

    // USB interrupt config
    USBIF_bit = 0;
    USBIE_bit = 1;
    PEIE_bit = 1;
    GIE_bit = 1;

    
    Delay_ms(100);
    mode = 3;
    turn_off_all_led();
}

void loop()
{
    if (mode == 1) {
        RED = 1;
        delay(1);
    } else if (mode == 2) {
        YELLOW = 1; delay(1000);
        YELLOW = 0; delay(1000);
    } else if (mode == 3) {
        RED = 1; GREEN = 0; delay(5000);
        YELLOW = 1; RED = 0; delay(3000);
        GREEN = 1; YELLOW = 0; delay(10000);
    }
}

void main() {
    setup();
    while (1) loop();
}