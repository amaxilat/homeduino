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
  
void loop()
{

  

  float currSound = average(0);
  /*
  total+=currSound;
  count++;
  int mean = total/count;
    Serial.println(mean);  
  */
  

  float soundDiff = currSound-soundLevel;
  
  float value = soundDiff/soundLevel;

  //  Serial.println(soundLevel);  
   if ((value>8)||(value<-8)){
       Serial.println(value);  
   digitalWrite(5, HIGH);    // set the LED off    
   count=0;
   Serial.println("case1");
//   if ((value>0.1)||(value<-0.1)){
//    Serial.println("case2");
//    digitalWrite(3, HIGH);    // set the LED off    
   //}
//   Serial.println(value);

  }
  else {  
    if (--count==0){
   digitalWrite(3, LOW);    // set the LED off    
   digitalWrite(5, LOW);    // set the LED off    
    }
  }
  //Serial.println("*Diff");
  //Serial.println(soundDiff);
    
  soundLevel=currSound;
  //Serial.println("*Level");
  //Serial.println(soundLevel);
  
  delay(20);
} 

