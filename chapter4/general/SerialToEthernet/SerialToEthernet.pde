/*
  Serial To Ethenet
 Language: Wiring/Arduino
 
 */

#include <SPI.h>
#include <Ethernet.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {
  0x00, 0xAA, 0xBB, 0xCC, 0xDE, 0x01 };
byte ip[] = { 
  128,122,151,6 };
byte server[] = { 
  173,236,203,251 }; // My site

// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP):
Client client(server, 80);


void setup() {
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);
  // start the serial library:
  Serial.begin(9600);

  // give the Ethernet shield a second to initialize:
  delay(1000);

}

void loop()
{

  if (client.connected()) {
    //if you're connected, pass bytes from client to serial:
    if (client.available()) {
      char netChar = client.read();
      Serial.write(netChar);
    } 
    //pass bytes from serial to client:
    if (Serial.available()) {
      char serialChar = Serial.read();
      client.write(serialChar);
    }
  }  
  else {
    // if you're not connected, and you get a serial C,
    // attempt to connect:
    if (Serial.available()) {
      char serialChar = Serial.read();
      if (serialChar == 'C') {
        connectToServer(); 
      }
    }
  }
}

void connectToServer() {
  // attempt to connect, and wait a millisecond:
  Serial.println("connecting...");
  client.connect();
  delay(1);
  if (client.connected()) {
    // if you get a connection, report back via serial:
    Serial.println("connected");

  }   
  else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
    client.stop();
  } 
}




















