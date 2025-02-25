#define RED LATE0_bit
#define YELLOW LATE1_bit
#define GREEN LATE2_bit

char transmit_data, receive_data;

int mode;
/* Mode of trafic light
 * 1 for always red,
 * 2 for blink yellow,
 * 3:
 *  - 5h-22h: 5s red -> 3s yellow -> 10s green -> loop
 *  - 22h-5h: blink yellow 1s
 */
int control_source;
/*
    0 for manual, 1 for auto
    Manual: use button to change mode
    Auto: use PC to change mode
*/

unsigned long seconds = 0;
unsigned short hour = 0;
unsigned short tick = 0;
unsigned long timer_ms = 0;
unsigned short last_hour = 5;

void init_timer1() {
  T1CON = 0x31;
  TMR1H = 0xD7;
  TMR1L = 0x12;
  PIR1.TMR1IF = 0;
  PIE1.TMR1IE = 1;
  INTCON = 0xC0;
}

void send(char msg) {
  transmit_data = msg;
  UART1_Write(transmit_data);
}

void turn_off_all_led() {
  RED = 0;
  YELLOW = 0;
  GREEN = 0;
}

void check_input() {

  if (UART1_Data_Ready()) {
    receive_data = UART1_Read();

    if (receive_data == 'T') {
      control_source = 1 - control_source;
      send(control_source == 0 ? 'M' : 'A');
    }

    if (control_source == 1) {
      if (receive_data == '1') {
        mode = 1;
        turn_off_all_led();
        send('Y');
      } else if (receive_data == '2') {
        mode = 2;
        turn_off_all_led();
        send('U');
      } else if (receive_data == '3') {
        mode = 3;
        turn_off_all_led();
        send('K');
      }
    }
  }

  if (control_source == 0) {
    if (BUTTON(&PORTB, 0, 10, 0)) {
      while (BUTTON(&PORTB, 0, 10, 0))
        ;
      mode = 1;
      turn_off_all_led();
      send('Y');
    } else if (BUTTON(&PORTB, 1, 10, 0)) {
      while (BUTTON(&PORTB, 1, 10, 0))
        ;
      mode = 2;
      turn_off_all_led();
      send('U');
    } else if (BUTTON(&PORTB, 2, 10, 0)) {
      while (BUTTON(&PORTB, 2, 10, 0))
        ;
      mode = 3;
      turn_off_all_led();
      send('K');
    }
  }
}

void interrupt() {
  if (PIR1.TMR1IF) {
    tick++;
    if (tick >= 20) {
      seconds += 3600;
      tick = 0;
    }
    hour = (seconds / 3600) % 24;
    timer_ms += 50;
    TMR1H = 0xD7;
    TMR1L = 0x12;
    PIR1.TMR1IF = 0;
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

  hour = 5;
  seconds = 5 * 3600;
  timer_ms = 0;
  init_timer1();

  // UART config
  UART1_Init(9600);
  Delay_ms(100);

  turn_off_all_led();
  mode = 3;
}

unsigned short state = 0;
unsigned long last_switch = 0;

void loop() {
  unsigned short current_hour = hour;
  int is_day = (current_hour >= 5 && current_hour < 22);

  check_input();

  if (mode == 1) {
    RED = 1;
  } else if (mode == 2) {
    if (timer_ms - last_switch >= 10000) {
      YELLOW = !YELLOW;
      last_switch = timer_ms;
    }
  } else if (mode == 3) {
    if ((last_hour < 5 && current_hour >= 5) ||
        (last_hour >= 22 && current_hour < 22) ||
        (last_hour < 22 && current_hour >= 22) ||
        (last_hour >= 5 && current_hour < 5)) {
      turn_off_all_led();
      state = 0;
      last_switch = timer_ms;
    }

    if (is_day) {
      if (state == 0 && timer_ms - last_switch >= 50000) {
        RED = 0;
        YELLOW = 1;
        state = 1;
        last_switch = timer_ms;
      } else if (state == 1 && timer_ms - last_switch >= 30000) {
        YELLOW = 0;
        GREEN = 1;
        state = 2;
        last_switch = timer_ms;
      } else if (state == 2 && timer_ms - last_switch >= 100000) {
        GREEN = 0;
        RED = 1;
        state = 0;
        last_switch = timer_ms;
      } else if (state == 0 && RED == 0) {
        RED = 1;
        last_switch = timer_ms;
      }
    } else {
      if (timer_ms - last_switch >= 10000) {
        YELLOW = !YELLOW;
        last_switch = timer_ms;
      }
    }
  }

  Delay_ms(1);
}

void main() {
  setup();
  while (1)
    loop();
}
