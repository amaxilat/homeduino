int soundLevel=0;
double total=0,  count = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(2, OUTPUT);     
  pinMode(3, OUTPUT);  
  pinMode(4, OUTPUT);     
  pinMode(5, OUTPUT);  
  digitalWrite(2, LOW);    // set the LED off  
  digitalWrite(4, LOW);    // set the LED off  
  digitalWrite(5, LOW);    // set the LED off  

}

int average(int pin)
{
  int x = 0;
  int y = 0;
  
  
  for (int i = 0; i < 10; i++)
  {
    x = analogRead(pin);
    y += x;
  }
  
  //Serial.println(y);
  return y/10;
}
  
void loop(){

  float currSound = average(0);

  float soundDiff = currSound-soundLevel;
  
  float value = soundDiff/soundLevel;
  Serial.println(value);  
  //  Serial.println(soundLevel);  
   if ((value>120)||(value<-120)){

       digitalWrite(5, HIGH);    // set the LED off    
       count=0;
       digitalWrite(3, LOW);    // set the LED off    
       delay(value+1);
  }
  else if ((value>20)||(value<-20)){
       digitalWrite(3, HIGH);    // set the LED off    
       count=0;
       digitalWrite(5, LOW);    // set the LED off    
       delay(value+1);
  } else {  
      digitalWrite(3, LOW);    // set the LED off    
      digitalWrite(5, LOW);    // set the LED off    
  }

  //Serial.println("*Diff");
  //Serial.println(soundDiff);
    
  soundLevel=currSound;
  //Serial.println("*Level");
  //Serial.println(soundLevel);
  
  delay(20);
} 

