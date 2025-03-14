#define LED_RED LATE0_bit
#define LED_YELLOW LATE1_bit
#define LED_GREEN LATE2_bit
int DURATIONS[4] = {5, 3, 10, 1}; // Red, Yellow, Green, Blink duration

char SEND_MSG[9] = {'K', 'Z', 'E', 'R', 'G', 'O', 'Y', 'M', 'A'};
char RECEIVE_MSG[8] = {'1', '2', '3', 'T', 'D', 'N', 'I', 'S'};

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

#define inp_size 7
#define out_size 7
unsigned char readbuff[inp_size] absolute 0x500;
unsigned char writebuff[out_size] absolute 0x540;

void setup_communication() {
  UPUEN_bit = 1;
  FSEN_bit = 1;

  HID_Enable(&readbuff, &writebuff);

  USBIF_bit = 0;
  USBIE_bit = 1;
  GIE_bit = 1;
  PEIE_bit = 1;
}

void send_data(char msg) {
  writebuff[0] = msg;
  HID_Write(&writebuff, out_size);
}

char receive_data() {
  if (HID_Read() != 0)
    return readbuff[0];
  return 0;
}

int set_time() {
  // Format: "SRRYYGG"
  //          ^ Command, R: red_time, Y: yellow_time, G: green_time
  int red_time = (readbuff[1] - '0') * 10 + (readbuff[2] - '0');
  int yellow_time = (readbuff[3] - '0') * 10 + (readbuff[4] - '0');
  int green_time = (readbuff[5] - '0') * 10 + (readbuff[6] - '0');

  if (red_time > 99 || red_time < 1 || yellow_time > 99 || yellow_time < 1 ||
      green_time > 99 || green_time < 1)
    return 0;

  DURATIONS[0] = (readbuff[1] - '0') * 10 + (readbuff[2] - '0'); // Red
  DURATIONS[1] = (readbuff[3] - '0') * 10 + (readbuff[4] - '0'); // Yellow
  DURATIONS[2] = (readbuff[5] - '0') * 10 + (readbuff[6] - '0'); // Green

  return 1;
}

/* Main functions */

void ovr_delay(int time);

void interrupt(void) {
  if (USBIF_bit == 1) {
    USBIF_bit = 0;
    USB_Interrupt_Proc();
  }
}

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
    } else if (res == RECEIVE_MSG[7]) {
      int isSet = set_time();
      if (mode == 3 && isSet) {
        reset_leds();
        i = time * 10 + 1;
      }
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
