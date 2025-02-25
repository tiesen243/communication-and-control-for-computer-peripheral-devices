#define RED LATE0_bit
#define YELLOW LATE1_bit
#define GREEN LATE2_bit

int mode;
/* Mode of trafic light
 * 1 for always red,
 * 2 for blink yellow,
 * 3 for 5s red -> 3s yellow -> 10s green -> loop
 */

void turn_off_all_led() {
  RED = 0;
  YELLOW = 0;
  GREEN = 0;
}

void delay(int time) {
  unsigned int i;
  for (i = 0; i < time; i++) {

    if (BUTTON(&PORTB, 0, 10, 0)) {
      while (BUTTON(&PORTB, 0, 10, 0))
        ;
      mode = 1;
      turn_off_all_led();
      break;
    } else if (BUTTON(&PORTB, 1, 10, 0)) {
      while (BUTTON(&PORTB, 1, 10, 0))
        ;
      mode = 2;
      turn_off_all_led();
      break;
    } else if (BUTTON(&PORTB, 2, 10, 0)) {
      while (BUTTON(&PORTB, 2, 10, 0))
        ;
      mode = 3;
      turn_off_all_led();
      break;
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

  Delay_ms(100);
  turn_off_all_led();
  mode = 3;
}

void loop() {
  if (mode == 1) {
    RED = 1;
    delay(1);
  } else if (mode == 2) {
    YELLOW = 1;
    delay(1000);
    YELLOW = 0;
    delay(1000);
  } else if (mode == 3) {
    if (RED == 1) {
      RED = 0;
      YELLOW = 1;
      delay(3000);
    } else if (YELLOW == 1) {
      YELLOW = 0;
      GREEN = 1;
      delay(10000);
    } else if (GREEN == 1) {
      GREEN = 0;
      RED = 1;
      delay(5000);
    } else {
      RED = 1;
      delay(5000);
    }
  }
}

void main() {
  setup();
  while (1)
    loop();
}
