#include <SPI.h>
#include <Ethernet.h>


byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192 ,168 ,1 ,60 };
byte gateway[] = { 192 ,168 ,1 ,1 };
byte subnet[] = { 255 ,255 ,255 ,0 };

Server server(80); 

String readString = String(30);

String title = "Arduino web interface";
String Sensors[] = { "light1","light3","light2" };
int SensorsCount = 3;

void setup(){
  
Ethernet.begin(mac, ip, gateway, subnet);
delay(1000);

pinMode(3, OUTPUT);
digitalWrite(3, LOW);
pinMode(4, OUTPUT);
digitalWrite(4, LOW);
pinMode(5, OUTPUT);
digitalWrite(5, LOW);
pinMode(6, OUTPUT);
digitalWrite(6, LOW);
pinMode(7, OUTPUT);
digitalWrite(7, LOW);

//Serial.begin(9600);
} 

void loop(){

  Client client = server.available();
  if (client) {
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
      if (readString.length() < 30){
        readString = readString + c;
      }
      if (c == '\n') {
        //Serial.print(readString);
        client.println("HTTP/1.1 200 OK");
        client.println("Content-Type: text/html");
        client.println();

      if(readString.startsWith("GET /index")){
        client.print("<h1>");
        client.print(title);
        client.print("</h1>");
      }
    }
   }
  }
 }
}
