class Bouton
{
  Bouton()
  {
     m_x=0;
     m_y=0;
     m_long=80;
     m_haut=50;
     m_couleur= color(50,50,50);
     m_taille_text=15;
  }
  Bouton(int x,int y)
  {
     m_x=x;
     m_y=y;
     m_long=80;
     m_haut=50;
     m_couleur= color(50,50,50);
     m_taille_text=15;
  }
  Bouton(int x,int y, int h, int l)
  {
     m_x=x;
     m_y=y;
     m_long=l;
     m_haut=h;
     m_couleur=color(50,50,50);
     m_taille_text=15;
  }
  void name(String text,int taille)
  {
    m_taille_text=taille;
    m_text =text;
  }
  void icone( String loc)
  {
    m_icone=loadImage(loc);
  }
  void position(int x,int y)
  {
     m_x=x;
     m_y=y;
  }
  int get_position(char axe)
  {
    if(axe=='y')
    {
      return m_y;
    }else if(axe=='x')
    {
      return m_x;
    }else
    {
      return 0;
    }
  }
  void afficher()
  {
    
    int bord=0;//arrondissement des bord
     if((mouseX >m_x)&&(mouseX <m_x+m_long)&&(mouseY >m_y)&&(mouseY <m_y+m_haut)) //si le curseur se trouve sur le bouton
     {
       if(mousePressed ==true)// si on clique
       {
         m_etat=2;
       }else // si on survol
       {
         m_etat=1;
       }
     }else//si on est en dehors
     {
       m_etat=0;
     }
     
     if(m_forceEtat != 0) m_etat=3;
  
     if(m_etat ==0)
     {
       bord=0;
       m_couleur=color(100,100,100);
     }else if(m_etat ==1)
     {
       bord=2;
       m_couleur=color(150,150,150);
     }else if(m_etat == 2)
     {
       bord=5;
       m_couleur=color(190,200,190);
     }else if(m_etat == 3)
     {
       bord=0;
       m_couleur=color(70,70,70);
     }
     stroke(0);
     strokeWeight(1);
     rectMode(CORNER);
     fill(m_couleur);
     rect(m_x,m_y,m_long,m_haut,bord);
     
     if(m_icone != null) // permet d afficher l icone si il existe
     {
       imageMode(CENTER);
       image(m_icone,m_x+(m_long/2),m_y+(m_haut/2));
       imageMode(CORNER);
     }
    if(m_text != null)//pareil pour le texte
    {
      fill(255,255,255);
      textSize(m_taille_text);
      textAlign(CENTER,CENTER);
      text(m_text,m_x+(m_long/2),m_y+(m_haut/2));
    }
  }
  
  void force_etat(int etat)
  {
      m_forceEtat=etat;
  }
  int get_etat()
  {
      return m_etat;
  }
   
  private int m_x;
  private int m_y;
  private int m_long;
  private int m_haut;
  private int m_etat;
  private int m_forceEtat;
  private color m_couleur;
  private String m_text;
  private PImage m_icone;
  private int m_taille_text;
};