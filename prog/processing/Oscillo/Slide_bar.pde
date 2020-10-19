class Slide_bar
{
  Slide_bar (int x,int y,int l)
  {
    m_slider_l=20;
    m_slider_h=10;
    m_x=x;
    m_y=y;
    m_long=l;
    m_haut=7;
    m_debut=m_x;
    m_fin=m_x+m_long;
    m_etat=0;
    m_couleur=color(150,150,150);
    m_text="";
    //m_icone=loadImage("image/slider.png");
  }
  void position(int x,int y)
  {
     m_x=x;
     m_y=y;
  }
  float get_val(float max)
  {
    float valeur=max*(m_slider_x-m_debut)/(m_fin-m_debut);
    return valeur;
  }
  
  
  void texte(String text)
  {
    m_text =text;
  }
  
  void afficher()
  {
    if((m_etat==2)&&(mousePressed ==true))
    {
      m_etat=2;
    }else if((mouseX >=m_slider_x-(m_slider_l/2))&&(mouseX <=m_slider_x+(m_slider_l/2))&&(mouseY >=m_slider_y-(m_slider_h/2))&&(mouseY <=m_slider_y+(m_slider_h/2))) //un peu plus long que la hitbox bouton, mais ici le slider est centré !
     {
       if(mousePressed ==true)
       {
         m_etat=2;
       }else
       {
         m_etat=1;
       }
     }else
     {
       m_etat=0;
     }
     
     if(m_etat ==0)
     {
       m_couleur=color(100,100,100);
     }else if(m_etat ==1)
     {
       m_couleur=color(150,150,150);
     }else if(m_etat == 2)
     {
       m_slider_x=mouseX;
       m_couleur=color(190,200,190);
     }
     //verouillage
     m_slider_y=m_y;
     if(m_slider_x < m_debut) m_slider_x= m_debut;
     if(m_slider_x > m_fin) m_slider_x= m_fin;
     
     stroke(0);
     strokeWeight(1);
     rectMode(CORNER);
     fill(150,150,150);
     rect(m_x,m_y-(m_haut/2),m_long,m_haut);//affichage barre
     
     rectMode(CENTER);
     fill(m_couleur);
     rect(m_slider_x,m_slider_y,m_slider_l,m_slider_h,2);//afficher slider
     rectMode(CORNER);
     
     if(m_text != null)//pareil pour le texte
      {
        fill(255,255,255);
        textSize(15);
        textAlign(LEFT,CENTER);
        text(m_text,m_x,m_y-20);
      }
  }
  int get_etat()
  {
      return m_etat;
  }
  
  private int m_slider_l;
  private int m_slider_h;
  private int m_slider_x;
  private int m_slider_y;
  private int m_debut;
  private int m_fin;
  private int m_x;
  private int m_y;
  private int m_long;
  private int m_haut;
  private int m_etat;
  private color m_couleur;
  private String m_text;
  private PImage m_icone;
};