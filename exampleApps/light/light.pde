int lightLevel=0;

void setup()
{
  Serial.begin(9600);

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

  int currLight = average();
  lightLevel=currLight;
  Serial.println("*Level");
  Serial.println(lightLevel);
  
  delay(500);
} 

