#include "MAX118.h"

MAX118::MAX118()
{
  m_curseurStock =0;
  pinMode(RD,OUTPUT);
  pinMode(MUX,OUTPUT);
  digitalWrite(RD,HIGH);
  digitalWrite(MUX,LOW);
  //pinMode(INTERRUPT,INPUT);
  pinMode(WR,INPUT);
  pinMode(D[7],INPUT);
  pinMode(D[6],INPUT);
  pinMode(D[5],INPUT);
  pinMode(D[4],INPUT);
  pinMode(D[3],INPUT);
  pinMode(D[2],INPUT);
  pinMode(D[1],INPUT);
  pinMode(D[0],INPUT);
}

void MAX118::sample()
{
  m_oldValeur = m_valeur;
  m_valeur = 0;
  for(m_i=7;m_i>=0;m_i--)
  {
    if(digitalRead(D[m_i]) == 1)
    {
      bitSet(m_valeur,m_i);
    }
  }
  /*if(m_valeur == 0)
    Serial.println("PROBLEME : "+String(m_valeur));
    */
}

void MAX118::requete()
{
  if(m_actEnvoie == false) // si on n envoie rien
  {
    digitalWrite(RD,LOW);
    //Serial.println("REQUETE");
  }
}

void MAX118::conversion()
{
  sample();
  if(m_autorise == true) // il faut d abord définir une valeur d ancrage, pour avoir un signal fixe à l ecran.
  {
    m_stock[m_curseurStock] = m_valeur;
    m_oldValeur= m_valeur;
    m_curseurStock ++; 
    //Serial.println(String(m_curseurStock));
    if(m_curseurStock >= 250)  //si on arrive à la fin du tbleau, on devra tout envoyer au pc avant de ontinuer à echantillonner.
    {
      m_curseurStock = 0;
      m_autorise = false;
      m_actEnvoie = true; // on commence à envoyer.
    }
  }else if((abs(m_valeur-m_ancreValeur) <100) && (m_valeur > m_oldValeur)) // on trouve avant de recommencer l echantillonage, le point d ancrage
  {
    m_autorise = true;
    //Serial.println(String(m_curseurStock));
  }
  digitalWrite(RD,HIGH);
}

void MAX118::transmision()
{
  m_k=0;
  if(m_actEnvoie == true)
  {
    for(m_i=0 ; m_i<5 ; m_i+=5)
    {
      for(m_j=0 ; m_j<50 ; m_j++)
      {
        m_envoi = m_envoi + String(m_stock[m_k])+":";
        m_k++;
        //problème ici, dans le tableau on a que 250 valeur, alors qu ici on en envoie 500
      }
      Serial.println(m_envoi);
      //delay(5);
    }
    m_actEnvoie=false; // envoie fini, retour à l echantillonnage.
    //m_autorise = true;
  }
}





