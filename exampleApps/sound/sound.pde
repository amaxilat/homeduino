int soundLevel=0;

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

int average()
{
  int x = 0;
  int y = 0;
  
  for (int i = 0; i <= 10; i++)
  {
    x = analogRead(0);
    y += x;
  }
  
  //Serial.println(y);
  return y/10;
}
  
void loop()
{

  float currSound = average();
  float soundDiff = currSound-soundLevel;
  
  float value = soundDiff/soundLevel;
  
  if ((value>0.15)||(value<-0.15)){
   digitalWrite(3, HIGH);    // set the LED off    
   Serial.println("case1");
   if ((value>0.25)||(value<-0.25)){
    Serial.println("case2");
    digitalWrite(5, HIGH);    // set the LED off    
   }
   Serial.println(value);

  }
  else {  
   digitalWrite(3, LOW);    // set the LED off    
   digitalWrite(5, LOW);    // set the LED off    
  }
  //Serial.println("*Diff");
  //Serial.println(soundDiff);
    
  soundLevel=currSound;
  //Serial.println("*Level");
  //Serial.println(soundLevel);
  
  delay(150);
} 

