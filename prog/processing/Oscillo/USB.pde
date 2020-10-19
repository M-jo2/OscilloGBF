Serial portUSB;
String Data;//variable où on stocke l info

void USB_Port(int port)
{
  printArray(Serial.list());
  portUSB= new Serial(this,Serial.list()[port],38400);
}
  
void tx(String envoi)
{
  portUSB.write(envoi +"\n");
}

void serialEvent(Serial port)
{
  String data;
  data =  port.readStringUntil('\n');
  
  if(data != null)
  {
    Data=Data+data;
    println(Data);
    port.clear();
  }
}