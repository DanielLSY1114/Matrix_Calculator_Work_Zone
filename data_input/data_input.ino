// the setup function runs once when you press reset or power the board
void setup() {
  // data input
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(6, OUTPUT);

  // enter input
  pinMode(5, OUTPUT);

}

// the loop function runs over and over again forever
void loop() {
  
  // intialize the input
  digitalWrite(13, LOW);
  digitalWrite(12, LOW);
  digitalWrite(11, LOW);
  digitalWrite(10, LOW);
  digitalWrite(9, LOW);
  digitalWrite(8, LOW);
  digitalWrite(7, LOW);
  digitalWrite(6, LOW);
  digitalWrite(5, LOW);
  delay(500);


  int array[32];  // Declare an array of 32 integers, each integer is 4-bit

  for (int i = 0; i < 32; i++) {
    array[i] = 15;
  }

  delay(500);

  for (int j = 0; j < 32; j=j+2){
    digitalWrite(13, (array[j] >> 3) & 1);
    digitalWrite(12, (array[j] >> 2) & 1);
    digitalWrite(11, (array[j] >> 1) & 1);
    digitalWrite(10, (array[j] >> 0) & 1);
    digitalWrite(9, (array[j+1] >> 3) & 1);
    digitalWrite(8, (array[j+1] >> 2) & 1);
    digitalWrite(7, (array[j+1] >> 1) & 1);
    digitalWrite(6, (array[j+1] >> 0) & 1);

    delay(500);
    digitalWrite(5, HIGH);
    delay(500);
    digitalWrite(5, LOW);
  }

  while (1) {
    // do nothing
    delay(2400);
  }

}
