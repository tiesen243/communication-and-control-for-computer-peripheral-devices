/*
 * Button at PORTB0, PORTB1, PORTB2
 * - PORTB0: Mode 1
 * - PORTB1: Mode 2
 * - PORTB2: Mode 3
 * LED at PORTB5, PORTB6, PORTB7
 * - PORTB5: Led red
 * - PORTB6: Led yellow
 * - PORTB7: Led green
 */
const int Buttons[3] = {0b00000001, 0b00000010, 0b00000100};
const int Leds[3] = {0b00100000, 0b01000000, 0b10000000};
const int reset = 0b00000000;

char send_msgs[11] = {'1', '2', '3', 'M', 'A', 'R', 'O', 'Y', 'G', 'E', 'S'};
char receive_msgs[7] = {'T', 'D', 'N', 'S'};
int durations[4] = {5, 3, 10, 1}; /* Red, yellow, green, blink yellow */

/* Mode
 * - 1: Ony red led
 * - 2: Blink yellow led 1s
 * - 3:
 *   + Day mode: 5s red -> 3s yellow -> 10s green -> loop
 *   + Night mode: blink yellow led 1s
 */
int mode = 3;
int is_night_mode = 0;

/* Control mode
 * - 0: Manual mode
 * - 1: Auto mode
 */
int control_mode = 0;

/* Communication */
const int PORT = 9600;

void setup_communication() {
  UART1_Init(PORT);
  Delay_ms(100);
}

void send_msg(char msg) {
  if (!UART1_Tx_Idle())
    return;

  UART1_Write(msg);
  Delay_ms(100);
}

char receive_msg() {
  if (!UART1_Data_Ready())
    return 0;
  return UART1_Read();
}

void set_time() {
  int i;
  char time[7];

  for (i = 0; i < 6; i++) {
    while (!UART1_Data_Ready())
      ;
    time[i] = UART1_Read();

    if (time[i] == 'S')
      i = -1;
  }
  time[6] = '\0';

  for (i = 0; i < 6; i++) {
    if (i % 2 == 0 && (time[i] < '0' || time[i] > '5')) {
      send_msg(send_msgs[9]);
      return;
    } else if (i % 2 == 1 && (time[i] < '0' || time[i] > '9')) {
      send_msg(send_msgs[9]);
      return;
    }
  }

  durations[0] = (time[0] - '0') * 10 + (time[1] - '0');
  durations[1] = (time[2] - '0') * 10 + (time[3] - '0');
  durations[2] = (time[4] - '0') * 10 + (time[5] - '0');

  send_msg(send_msgs[10]);
}

/* Main */

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  TRISB = 0b00000111;
  PORTB = 0b00000000;

  setup_communication();
}

void switch_mode(int newMode) {
  mode = newMode;
  send_msg(send_msgs[newMode - 1]);
  PORTB = reset;
  Delay_ms(100);
}

void delay(int duration) {
  int i, j;

  for (i = 0; i < duration * 10; i++) {

    // Check receive message
    char msg = receive_msg();
    if (msg == receive_msgs[0]) {
      control_mode = 1 - control_mode;
      send_msg(send_msgs[3 + control_mode]);
    } else if (msg == receive_msgs[1]) {
      is_night_mode = 0;
      if (mode == 3) {
        PORTB = reset;
        return;
      }
    } else if (msg == receive_msgs[2]) {
      is_night_mode = 1;
      if (mode == 3) {
        PORTB = reset;
        return;
      }
    } else if (msg == receive_msgs[3]) {
      set_time();
      if (mode == 3) {
        PORTB = reset;
        return;
      }
    } else if (control_mode == 1) {
      int newMode = msg - '0';
      if (newMode >= 1 && newMode <= 3) {
        switch_mode(newMode);
        return;
      }
    }

    // Check button
    for (j = 0; j < 3; j++)
      if (Button(&PORTB, j, 10, 0) && control_mode == 0) {
        while (Button(&PORTB, j, 10, 0))
          ;
        switch_mode(j + 1);
        return;
      }

    Delay_ms(100);
  }
}

void loop() {
  if (mode == 1) {
    PORTB = Leds[0];
    send_msg(send_msgs[5]);
    delay(durations[0]);
  } else if (mode == 2 || (mode == 3 && is_night_mode)) {
    PORTB ^= Leds[1];
    send_msg(send_msgs[(PORTB & Leds[1]) ? 7 : 6]);
    delay(durations[3]);
  } else if (mode == 3 && !is_night_mode) {
    if ((PORTB & 0xE0) == (Leds[0] & 0xE0)) {
      PORTB = Leds[1];
      send_msg(send_msgs[7]);
      delay(durations[1]);
    } else if ((PORTB & 0xE0) == (Leds[1] & 0xE0)) {
      PORTB = Leds[2];
      send_msg(send_msgs[8]);
      delay(durations[2]);
    } else {
      PORTB = Leds[0];
      send_msg(send_msgs[5]);
      delay(durations[0]);
    }
  }
}

int main() {
  setup();
  while (1)
    loop();
  return 0;
}
