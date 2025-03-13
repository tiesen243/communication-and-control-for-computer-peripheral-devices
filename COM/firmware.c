#define LED_RED LATE0_bit
#define LED_YELLOW LATE1_bit
#define LED_GREEN LATE2_bit
int DURATIONS[4] = {5, 3, 10, 1}; // Red, Yellow, Green, Blink duration

char SEND_MSG[9] = {'K', 'Z', 'E', 'R', 'G', 'O', 'Y', 'M', 'A'};
char RECEIVE_MSG[7] = {'1', '2', '3', 'T', 'D', 'N', 'I'};

/* Mode:
 * mode 1: red
 * mode 2: blinking yellow
 * mode 3:
 * - day mode: red -> yellow -> green -> red
 * - night mode: blinking yellow
 */
int mode = 3, is_night_mode = 0;
/* Control source:
 * 0: button
 * 1: serial
 */
int control_source = 0;

/* Communication functions */

void setup_communication() {
  UART1_Init(9600);
  Delay_ms(100);
}

void send_data(char msg) { UART1_Write(msg); }

char receive_data() {
  if (UART1_Data_Ready())
    return UART1_Read();
  return 0;
}

/* Main functions */

void ovr_delay(int time);

int main() {
  ADCON1 |= 0x0F;
  CMCON |= 0X07;

  // Button setup (RB0, RB1, RB2)
  PORTB = 0x00;
  LATB = 0x00;
  TRISB = 0x07;

  // LED setup (RE0, RE1, RE2)
  PORTE = 0x00;
  LATE = 0x00;
  TRISE = 0x00;

  setup_communication();

  while (1) {
    if (mode == 1) {
      LED_RED = 1;
      send_data(SEND_MSG[3]);
      ovr_delay(DURATIONS[0]);
    } else if (mode == 2) {
      LED_YELLOW = 1 - LED_YELLOW;
      send_data(SEND_MSG[5 + LED_YELLOW]);
      ovr_delay(DURATIONS[3]);
    } else if (mode == 3) {
      if (is_night_mode) {
        LED_YELLOW = 1 - LED_YELLOW;
        send_data(SEND_MSG[5 + LED_YELLOW]);
        ovr_delay(DURATIONS[3]);
      } else {
        if (LED_RED) {
          LED_RED = 0;
          LED_YELLOW = 1;
          send_data(SEND_MSG[6]);
          ovr_delay(DURATIONS[1]);
        } else if (LED_YELLOW) {
          LED_YELLOW = 0;
          LED_GREEN = 1;
          send_data(SEND_MSG[4]);
          ovr_delay(DURATIONS[2]);
        } else {
          LED_GREEN = 0;
          LED_RED = 1;
          send_data(SEND_MSG[3]);
          ovr_delay(DURATIONS[0]);
        }
      }
    }
  }

  return 0;
}

void reset_leds() {
  LED_RED = 0;
  LED_YELLOW = 0;
  LED_GREEN = 0;
}

void switch_mode(int newMode) {
  reset_leds();
  mode = newMode;
  send_data(SEND_MSG[mode - 1]);
}

void ovr_delay(int time) {
  int i, j;

  for (i = 0; i < time * 10; i++) {
    char res = receive_data();

    // Serial control
    if (res == RECEIVE_MSG[3]) {
      control_source = 1 - control_source;
      send_data(SEND_MSG[control_source + 7]);
    } else if (res == RECEIVE_MSG[4]) {
      is_night_mode = 0;
      if (mode == 3) {
        reset_leds();
        i = time * 10 + 1;
      }
    } else if (res == RECEIVE_MSG[5]) {
      is_night_mode = 1;
      if (mode == 3) {
        reset_leds();
        i = time * 10 + 1;
      }
    } else if (res == RECEIVE_MSG[6]) {
      send_data(SEND_MSG[mode - 1]);
      Delay_ms(100);
      send_data(SEND_MSG[control_source + 7]);
    } else if (control_source == 1) {
      int newMode = res - '0';
      if (newMode >= 1 && newMode <= 3 && newMode != mode) {
        switch_mode(newMode);
        i = time * 10 + 1;
      }
    }

    // Button control
    for (j = 0; j < 3; j++)
      if (BUTTON(&PORTB, j, 10, 0) && control_source == 0) {
        while (BUTTON(&PORTB, j, 10, 0))
          ;
        if (j + 1 != mode) {
          switch_mode(j + 1);
          i = time * 10 + 1;
        }
      }

    Delay_ms(100);
  }
}
