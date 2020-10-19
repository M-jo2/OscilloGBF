#include "DS.h"
#include "MAX118.h"
#include "TimerOne.h"

DS Ship_DS;
MAX118 Ship_max;


volatile bool i=true; // volatile car elle est modifiée dans une interruption

void setup() {
  pinMode(9,INPUT);
  Serial.begin(38400); 
  Ship_DS.process(1,1); 
  
  Timer1.initialize(100);         // 1 000 000 = 1s  (freq. ech.)
  Timer1.pwm(10, 512);                // setup pwm on pin 9, 50% duty cycle
  Timer1.attachInterrupt(maxrequete);  // attaches callback() as a timer overflow interrupt
  //attachInterrupt(9,maxconversion,LOW); // attache une interruption sur la patte /INT edit: finalement les interruptions sur la pattes 9 ne sont pas dispo sur la UNO
}


void loop() {
  if((digitalRead(9)==LOW)&&(i == true))
  {
    i=false;
    maxconversion();
  }
  Ship_max.transmision(); // on verifie constamment si les données sont disponnible pour l envoie.
  /*
   * lors de l echantillonage, les info récoltée sont aussitôt rangée dans un tableau, cette manoeuvre coute moins de temps que d envoyer la donnée directemment au pc.
   * une fois la conversion terminée (100 point), on envoie les 100 points au pc (voir si je peu envoyer 5points à la fois?)
   * à savoir que il y à envoie, les deux interruption ne sont pas éxécutée, car il faut d abord vidé la mémoire tampon.
   * dés que l envoie est terminé, les deux interruption sont de nouveau opérationnel.
   */
   
}

void maxrequete()
{
  Ship_max.requete(); // à chaque interruption du timer1, on envoie une demande au max pour un echantillonage.
  i=true;
}

void maxconversion()
{
  Ship_max.conversion(); // à chaque fois (suite à la requete) que /INT arrive à 0, on récupere les info.
  
}




