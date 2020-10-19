#include "DS.h"

DS::DS()
{
    Pot_0=1;
    Pot_1=1;

    int i=0;
    int masque=0b00000001;

    pinMode(RST_DS, OUTPUT);
    pinMode(CLK_DS, OUTPUT);
    pinMode(DQ_DS, OUTPUT);

    digitalWrite(RST_DS,LOW);
    digitalWrite(CLK_DS, LOW);
}

void DS::pulse_CLK()
{
    digitalWrite(CLK_DS, HIGH);
    delay(1);
    digitalWrite(CLK_DS, LOW);
    delay(1);
}

void DS::send_DQ(int valeur)
{
    if(valeur>0)
    {
        digitalWrite(DQ_DS,HIGH);
    }else{
        digitalWrite(DQ_DS,LOW);
    }
    pulse_CLK();
}

void DS::process(int Pot_0, int Pot_1)
{
    digitalWrite(RST_DS, HIGH); // d�but detransmission, rst � 1
    digitalWrite(DQ_DS,LOW);   // Stack bit 0 non utilis�
    pulse_CLK();

    masque=0b00000001;//r�init du masque
    for(i=0;i<8;i++)//envoie des 8bits de pot 0
    {
        send_DQ(Pot_0 & masque);
        masque = masque << 1;
    }
    masque=0b00000001;//r�init du masque

    /*for(i=0;i<8;i++)//envoie des 8bits de pot 1
    {
        send_DQ(Pot_1 & masque);
        masque = masque << 1;
    }*/

    digitalWrite(RST_DS,LOW);//fin de transmission
    digitalWrite(DQ_DS,LOW);// r�z
}




