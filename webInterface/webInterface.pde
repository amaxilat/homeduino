#include <SPI.h>
#include <Ethernet.h>


byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192 ,168 ,1 ,29 };
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

for (int i=0;i<SensorsCount;i++){
  pinMode(i+2, OUTPUT);
  digitalWrite(i+2, LOW);
}

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
        client.println("HTTP/1.1 200 OK");
        client.println("Content-Type: text/html");
        client.println();
        client.println("<h1>");
        client.println(title);
        client.println("</h1>");
        //client.println(readString);
      if(readString.startsWith("GET /index")){

        client.println("<h2>Sensors</h2>");
        for (int i=0;i<SensorsCount;i++){  
          client.println("<br>");
          client.println("<a href=\"/");
          client.println(Sensors[i]);
          client.println("\">");
          client.println(Sensors[i]);
          client.println("</a>");
        }
      }
      else {      
          for (int i=0;i<SensorsCount;i++){
            if(readString.startsWith("GET /"+Sensors[i])){
               client.println("<br>");
                          if(readString.startsWith("GET /"+Sensors[i]+"/ON")){
                                          client.println("turning on");
                                          digitalWrite(i+2, HIGH);
                          }
                          if(readString.startsWith("GET /"+Sensors[i]+"/OFF")){
                                          client.println("turning off");
                                          digitalWrite(i+2, LOW);
                          
                          }
                                          
              String sname = Sensors[i];
              client.println("<br>");
              client.println("<a href=\"/"+sname+"/ON\"> turn on "+sname+"</a>");
              client.println("<br>");
              client.println("<a href=\"/"+sname+"/OFF\"> turn off "+sname+"</a>");
              client.println("<br>");
              client.println("<a href=\"/index\">homepage</a>");
            }
          }     
      }
      
      readString="";
     client.stop();
   }
   }
 
  }
 }
}
