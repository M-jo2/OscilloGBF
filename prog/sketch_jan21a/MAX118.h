#ifndef MAX118_H_INCLUDED
#define MAX118_H_INCLUDED


#include <Arduino.h>

class MAX118
{
    public:
    
    MAX118();
    void sample();
    void requete();
    void conversion();
    void transmision();
    
    private:
    
    const unsigned char RD = 5;
    const unsigned char WR = 12;
    //const unsigned char INTERRUPT = 9;
    const unsigned char MUX = 8;
    const unsigned char D[8] = {A0, A1, A2, A3, A4, A5, 6, 7};

    unsigned char m_valeur=0; // enregistre le dernier échantillon
    unsigned char m_oldValeur=0; // enregistre l'avant dernier échantillon
    unsigned char m_ancreValeur=128; // ancrage à définir ! (128 par défaut)
    unsigned char m_curseurStock;//enregistre la dernière position modifiée de m_stock
    unsigned char m_stock[250]; //enregistre 100 valeur avant qu elles soient envoyées.
    String m_envoi; // passerel pour l envoie au pc
    int m_i=0; // utilisé pour les boucles
    int m_j=0; // utilisé pour les boucles dans les boucle
    int m_k=0; // utilisé pour les boucles dans les boucle
    
    bool m_autorise=true; // peut on echantilloner ? 
    bool m_actEnvoie=false; // en train d'envoyer ou pas ? 
};

#endif // DS_H_INCLUDED
