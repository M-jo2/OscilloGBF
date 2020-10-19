#ifndef DS_H_INCLUDED
#define DS_H_INCLUDED


#include <Arduino.h>

class DS
{
    public:
    
    DS();
    void pulse_CLK();
    void send_DQ(int valeur);
    void process(int Pot_0, int Pot_1);

    private:
    
    const unsigned char RST_DS=4;
    const unsigned char DQ_DS=2;
    const unsigned char CLK_DS=3;//3pins

    int Pot_0;
    int Pot_1;
    int i;
    int masque;
};

#endif // DS_H_INCLUDED
