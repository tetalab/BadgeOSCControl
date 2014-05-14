import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int c;

final int nbuts = 4;
ADbutton[] buttons = new ADbutton[nbuts];
PImage img;

void setup() 
{
  //size( 500, 500 );
  //frameRate( 100 );
  orientation(PORTRAIT);
  img = loadImage("logotetalab.jpg");
  oscP5 = new OscP5(this, 12001);
  remoteLocation = new NetAddress("192.168.0.13", 12001); //(1)
  
  buttons[0]= new ADbutton(width/2-80, 280, 80, 80, 7, "Blink");
  buttons[1]= new ADbutton(width/2, 280,80, 80, 7, "Salle 1"); 
  buttons[2]= new ADbutton(width/2-80, 360, 80, 80, 7, "Salle 2");
  buttons[3]= new ADbutton(width/2, 360, 80, 80, 7, "Salle 3");
}

void draw ()
{

  
  
  
  background(#AEAEAE);

  image(img,width/2-160, 0,320,240);
    for (int i=0; i<nbuts; i++)
      if (buttons[i].update()) buttonRun(buttons[i].getLabel());
  
  
  
  
}

void buttonRun(String ID)
{
  println("button "+ID+" was pressed...");
   OscBundle myBundle = new OscBundle();
   
  OscMessage myMessage = new OscMessage("/"); 
  if (ID=="Blink"){
     myMessage.clear();
     myMessage.setAddrPattern("/blink");

   myMessage.add("valeur"); 
   
  }
  
   if (ID=="Salle 1"){
      myMessage.clear();
     myMessage.setAddrPattern("/salle"); 
   myMessage.add("valeur"); 
 
  }
    if (ID=="Salle 2"){
     myMessage.clear(); 
     myMessage.setAddrPattern("/salle");
   myMessage.add("valeur"); 
   
  }
   
  if (ID=="Salle 3"){
    myMessage = new OscMessage("/balle"); 
   myMessage.add("valeur"); 
  }
  
  myBundle.add(myMessage);
  oscP5.send(myBundle, remoteLocation);
    background(#FF0000);


  
}

void keyPressed(){

  if (keyPressed == true){
   
   
  }else{
   
    OscMessage myMessage = new OscMessage("ii"); 
    myMessage.add(0); 
    oscP5.send(myMessage, remoteLocation);
  }
  

}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("i"))  
  {
    c =  theOscMessage.get(0).intValue();
  }
}

