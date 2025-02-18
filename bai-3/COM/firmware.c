#define RED     LATE0_bit  // Ðèn d?  -> RE0
#define YELLOW  LATE1_bit  // Ðèn vàng -> RE1
#define GREEN   LATE2_bit // Ðèn xanh -> RE2

unsigned int red_time = 5, yellow_time = 3, green_time = 10, i = 0;
unsigned char mode = 3;

void delay_s(unsigned int seconds) {
    while (seconds--) {
        for (i = 0; i < 10; i++) {
            Delay_ms(100);
            if (UART1_Data_Ready()) {
                char cmd = UART1_Read();
                if (cmd == '1' || cmd == '2' || cmd == '3' || 
                   BUTTON(&PORTB, 0, 10, 0) || BUTTON(&PORTB, 1, 10, 0) || BUTTON(&PORTB, 2, 10, 0)) {
                    RED = 0; YELLOW = 0; GREEN = 0;
                    mode = cmd - '0';
                    return;
                }
            }
        }
    }
}

int UART_Receive_Command() {
  if (UART1_Data_Ready()) {
    char cmd = UART1_Read();

    if (cmd == '1') {
      mode = 1;
      UART1_Write('!');
      Delay_ms(100);
    }
    else if (cmd == '2') {
      mode = 2;
      UART1_Write('@');
      Delay_ms(100);
    }
    else if (cmd == '3') {
      mode = 3;
      UART1_Write('#');
      Delay_ms(100);
    }
  }
}

int Button_Receive() {
    if (BUTTON(&PORTB, 0, 10, 0)) {
       mode = 1;
       UART1_Write('#');
    }
    else if (BUTTON(&PORTB, 1, 10, 0)) {
       while (BUTTON(&PORTB, 1, 10, 0));
       mode = 2;
       UART1_Write('@');
    }
    else if (BUTTON(&PORTB, 2, 10, 0)) {
       while (BUTTON(&PORTB, 2, 10, 0));
       mode = 3;
       UART1_Write('#');
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

    UART1_Init(9600);
    Delay_ms(100);
}

void loop() {
  UART_Receive_Command();
  Button_Receive();
  
  switch(mode) {
    case 1:
      RED = 1; YELLOW = 0; GREEN = 0;
      break;
    case 2:
      while (mode == 2) {
        RED = 0; YELLOW = 1; GREEN = 0;
        delay_s(1);
        RED = 0; YELLOW = 0; GREEN = 0;
        delay_s(1);
      }
    break;
    case 3:
      while (mode == 3) {
        RED = 1; YELLOW = 0; GREEN = 0;
        delay_s(red_time);
        RED = 0; YELLOW = 1; GREEN = 0;
        delay_s(yellow_time);
        RED = 0; YELLOW = 0; GREEN = 1;
        delay_s(green_time);
      }
  }
}

void main() {
    setup();
    while (1) loop();
}