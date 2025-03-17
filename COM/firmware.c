/*
 * Button at PORTB0, PORTB1, PORTB2
 * - PORTB0: Mode 1
 * - PORTB1: Mode 2
 * - PORTB2: Mode 3
 * LED at PORTB5, PORTB6, PORTB7
 * - PORTB3: Led red
 * - PORTB4: Led yellow
 * - PORTB5: Led green
 */
const int BUTTONS[3] = {0b00000001, 0b00000010, 0b00000100};
const int LEDS[3] = {0b00001000, 0b00010000, 0b00100000};
const int OFF = 0b00000000;

const char SEND_MSGS[11] = {'1', '2', '3', 'M', 'A', 'R',
                            'O', 'Y', 'G', 'E', 'S'};
const char RECEIVE_MSGS[5] = {'T', 'D', 'N', 'I', 'S'};
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

void send_msg(int index) {
  if (!UART1_Tx_Idle())
    return;

  UART1_Write(SEND_MSGS[index]);
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
    if (time[i] < '0' || time[i] > '9') {
      return;
    }
  }

  durations[0] = (time[0] - '0') * 10 + (time[1] - '0');
  durations[1] = (time[2] - '0') * 10 + (time[3] - '0');
  durations[2] = (time[4] - '0') * 10 + (time[5] - '0');
  send_msg(10);
}

/* Main */

void delay(int duration);

void setup() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  TRISB = 0b00000111;
  PORTB = OFF;

  setup_communication();
}

void loop() {
  if (mode == 1) {
    PORTB = LEDS[0];
    send_msg(5);
    delay(durations[0]);
  } else if (mode == 2 || (mode == 3 && is_night_mode)) {
    PORTB ^= LEDS[1];
    send_msg((PORTB & 0x38) == LEDS[1] ? 7 : 6);
    delay(durations[3]);
  } else if (mode == 3) {
    if ((PORTB & 0x38) == LEDS[0]) {
      PORTB = LEDS[1];
      send_msg(7);
      delay(durations[1]);
    } else if ((PORTB & 0x38) == LEDS[1]) {
      PORTB = LEDS[2];
      send_msg(8);
      delay(durations[2]);
    } else {
      PORTB = LEDS[0];
      send_msg(5);
      delay(durations[0]);
    }
  }
}

void main() {
  setup();
  while (1)
    loop();
}

int switch_mode(int newMode) {
  if (mode == newMode)
    return 0;

  PORTB = OFF;
  mode = newMode;
  send_msg(newMode - 1);
  return 1;
}

void delay(int delay_s) {
  int i, j;

  for (i = 0; i < delay_s * 10; i++) {

    // Check receive message
    char msg = receive_msg();
    if (msg == RECEIVE_MSGS[0]) {
      control_mode = 1 - control_mode;
      send_msg(control_mode + 3);
    } else if (msg == RECEIVE_MSGS[1]) {
      is_night_mode = 0;
      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (msg == RECEIVE_MSGS[2]) {
      is_night_mode = 1;
      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (msg == RECEIVE_MSGS[3]) {
      send_msg(mode - 1);
      Delay_ms(100);
      send_msg(control_mode + 3);
    } else if (msg == RECEIVE_MSGS[4]) {
      set_time();

      if (mode == 3) {
        PORTB = OFF;
        return;
      }
    } else if (control_mode == 1) {
      int newMode = msg - '0';
      if (newMode >= 1 && newMode <= 3) {
        if (switch_mode(newMode))
          return;
      }
    }

    // Check button
    for (j = 0; j < 3; j++)
      if (Button(&PORTB, j, 10, 0) && control_mode == 0) {
        while (Button(&PORTB, j, 10, 0))
          ;
        if (switch_mode(j + 1))
          return;
      }

    Delay_ms(100);
  }
}
