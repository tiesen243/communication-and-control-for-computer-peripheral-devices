#define RED LATE0_bit
#define YELLOW LATE1_bit
#define GREEN LATE2_bit

char transmit_data, receive_data;

int mode, is_night_mode;
/* Mode of trafic light
 * 1 for always red,
 * 2 for blink yellow,
 * 3 for:
 * - day mode: 5s red -> 3s yellow -> 10s green -> loop
 * night mode: blink yellow
 */
int control_source;
/*
 * 0 for manual, 1 for auto
 * Manual: use button to change mode
 * Auto: use PC to change mode
 */

void send(char msg) {
  transmit_data = msg;
  UART1_Write(transmit_data);
}

void turn_off_all_led() {
  RED = 0;
  YELLOW = 0;
  GREEN = 0;
}

void delay(int time) {
  unsigned int i;
  for (i = 0; i < time; i++) {
    if (UART1_Data_Ready()) {
      receive_data = UART1_Read();

      if (receive_data == 'T') {
        control_source = 1 - control_source;
        send(control_source == 0 ? 'M' : 'A');
      } else if (receive_data == 'D') {
        turn_off_all_led();
        is_night_mode = 0;
      } else if (receive_data == 'N') {
        turn_off_all_led();
        is_night_mode = 1;
      }

      if (control_source == 1) {
        if (receive_data == '1') {
          mode = 1;
          turn_off_all_led();
          send('K');
          Delay_ms(100);
          break;
        } else if (receive_data == '2') {
          mode = 2;
          turn_off_all_led();
          send('Z');
          Delay_ms(100);
          break;
        } else if (receive_data == '3') {
          mode = 3;
          turn_off_all_led();
          send('E');
          Delay_ms(100);
          break;
        }
      }
    }

    if (control_source == 0) {
      if (BUTTON(&PORTB, 0, 10, 0)) {
        while (BUTTON(&PORTB, 0, 10, 0))
          ;
        mode = 1;
        turn_off_all_led();
        send('K');
        Delay_ms(100);
        break;
      } else if (BUTTON(&PORTB, 1, 10, 0)) {
        while (BUTTON(&PORTB, 1, 10, 0))
          ;
        mode = 2;
        turn_off_all_led();
        send('Z');
        Delay_ms(100);
        break;
      } else if (BUTTON(&PORTB, 2, 10, 0)) {
        while (BUTTON(&PORTB, 2, 10, 0))
          ;
        mode = 3;
        turn_off_all_led();
        send('E');
        Delay_ms(100);
        break;
      }
    }

    Delay_ms(1);
  }
}

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

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

  turn_off_all_led();
  mode = 3;
  control_source = 0;
  is_night_mode = 0;
}

void loop() {
  if (mode == 1) {
    RED = 1;
    send('R');
    delay(10000);
  } else if (mode == 2) {
    YELLOW = 1;
    send('Y');
    delay(1000);
    YELLOW = 0;
    send('O');
    delay(1000);
  } else if (mode == 3) {
    if (is_night_mode) {
      YELLOW = 1;
      send('Y');
      delay(1000);
      YELLOW = 0;
      send('O');
      delay(1000);
    } else {
      if (RED == 1) {
        RED = 0;
        YELLOW = 1;
        send('Y');
        delay(3000);
      } else if (YELLOW == 1) {
        YELLOW = 0;
        GREEN = 1;
        send('G');
        delay(10000);
      } else if (GREEN == 1) {
        GREEN = 0;
        RED = 1;
        send('R');
        delay(5000);
      } else {
        RED = 1;
        send('R');
        delay(5000);
      }
    }
  }
}

void main() {
  setup();
  while (1)
    loop();
}