int soundLevel=0;

void setup()
{
  Serial.begin(9600);
  pinMode(2, OUTPUT);     
  pinMode(3, OUTPUT);  
  digitalWrite(2, LOW);    // set the LED off  
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

  int currSound = average();
  int soundDiff = currSound-soundLevel;
  
  if ((soundDiff>100)||(soundDiff<-100)){
   digitalWrite(3, HIGH);    // set the LED off    
  }
  else {
   digitalWrite(3, LOW);    // set the LED off    
  }
  Serial.println("*Diff");
  Serial.println(soundDiff);
    
  soundLevel=currSound;
  Serial.println("*Level");
  Serial.println(soundLevel);
  
  delay(200);
} 

