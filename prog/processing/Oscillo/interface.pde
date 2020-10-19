class Ecran
{
  Ecran ()
  {
    USB_Port(1);
    m_Ifond = loadImage("image/fond.png");
    //m_Ioscillographe = loadImage("image/oscillographe.png");
    //image(m_Ioscillographe,10,10);
    
    m_Bcarre = new Bouton(600,100,50,50);
    m_Bcarre.icone("image/carre.png");
    m_Btriangle = new Bouton(650,100,50,50);
    m_Btriangle.icone("image/triangle.png");
    m_Bsinus = new Bouton(700,100,50,50);
    m_Bsinus.icone("image/sinus.png");
    
    m_BfHZ = new Bouton(700,310,20,40);
    m_BfHZ.name("Hz",13);
    m_BfKHZ = new Bouton(740,310,20,40);
    m_BfKHZ.name("KHz",13);
    m_BfMHZ = new Bouton(780,310,20,40);
    m_BfMHZ.name("MHz",13);
  
    m_Bcal_10 = new Bouton(600,550,40,40);
    m_Bcal_10.name("x10",13);
    m_Bcal_1 = new Bouton(640,550,40,40);
    m_Bcal_1.name("x1",13);
    
    m_BoneShot = new Bouton(50,500,50,50);
    m_BoneShot.name("Shot",13);
    
    m_Bline = new Bouton(120,500,50,50);
    m_Bline.name("Line",13);
    
    m_SLIampli= new Slide_bar(600,200,200);
    m_SLIfrequence = new Slide_bar(600,300,200);
    m_SLIvolt = new Slide_bar(300,480,500);
    m_SLIsec = new Slide_bar(300,530,500);
    
    m_Bcal_10.force_etat(3);
    m_Bcarre.force_etat(3);
    m_BfHZ.force_etat(3);
    
    m_oscillo = new Oscillographe();
    //posGraphX = 20; //mise à gauche
    //posGraphY = 200;
  }
  
  void affiche()
  {
    if(m_Bcal_10.get_etat() == 3) tx("10");
    if(m_Bcal_1.get_etat() == 3) tx("1");
    
    if(m_Bcal_10.get_etat() == 2) 
    {
      m_Bcal_10.force_etat(3);
      m_Bcal_1.force_etat(0);
    }else if(m_Bcal_1.get_etat() == 2) 
    {
      m_Bcal_10.force_etat(0);
      m_Bcal_1.force_etat(3);
    }
    
    if(m_Bcarre.get_etat() == 2) 
    {
      m_Bsinus.force_etat(0);
      m_Btriangle.force_etat(0);
      m_Bcarre.force_etat(3);
    }else if(m_Btriangle.get_etat() == 2) 
    {
      m_Bsinus.force_etat(0);
      m_Btriangle.force_etat(3);
      m_Bcarre.force_etat(0);
    }else if(m_Bsinus.get_etat() == 2) 
    {
      m_Bsinus.force_etat(3);
      m_Btriangle.force_etat(0);
      m_Bcarre.force_etat(0);
    }
    
    if(m_BfHZ.get_etat() == 2) 
    {
      m_BfMHZ.force_etat(0);
      m_BfKHZ.force_etat(0);
      m_BfHZ.force_etat(3);
    }else if(m_BfKHZ.get_etat() == 2) 
    {
      m_BfHZ.force_etat(0);
      m_BfKHZ.force_etat(3);
      m_BfMHZ.force_etat(0);
    }else if(m_BfMHZ.get_etat() == 2) 
    {
      m_BfKHZ.force_etat(0);
      m_BfMHZ.force_etat(3);
      m_BfHZ.force_etat(0);
    }
    
    if(m_BoneShot.get_etat() == 2 && mousePressed == false) 
    {
      if(m_oscillo.m_oneShot == 0)
          m_oscillo.m_oneShot=1;
      else if(m_oscillo.m_oneShot == 1)
          m_oscillo.m_oneShot=0;
    }
    
    if(m_Bline.get_etat() == 2 && mousePressed == false) 
    {
      if(m_oscillo.m_line == 0)
          m_oscillo.m_line=1;
      else if(m_oscillo.m_line == 1)
          m_oscillo.m_line=0;
    } 
    
    //Affichage de tout les élément 
    
    //graph();
    
    m_oscillo.affiche();
    image(m_Ifond,0,0);
    m_oscillo.click();
    
    m_Bcarre.afficher();
    m_Btriangle.afficher();
    m_Bsinus.afficher();
    
    m_BfHZ.afficher();
    m_BfKHZ.afficher();
    m_BfMHZ.afficher();
  
    m_Bcal_10.afficher();
    m_Bcal_1.afficher();
    
    m_BoneShot.afficher();
    m_Bline.afficher();
    
    String SLIval;// pour afficher la valeur retournée par les slides.
    m_SLIfrequence.afficher();
    SLIval = "Fréquence : " +m_SLIfrequence.get_val(1000);
    m_SLIfrequence.texte(SLIval);
    
    m_SLIampli.afficher();
    SLIval = "Amplification : " +m_SLIampli.get_val(100) +" Vpp";
    m_SLIampli.texte(SLIval);
    
    //m_SLIvolt.afficher();
    SLIval = "V/DIV : " +m_SLIvolt.get_val(20);
    m_SLIvolt.texte(SLIval);
    
    m_SLIsec.afficher();
    SLIval = "T.échantillonnage (µs) : " +m_SLIsec.get_val(1000000);
    m_SLIsec.texte(SLIval);
    if(m_SLIsec.get_etat()==2)
    {
      tx(str(m_SLIsec.get_val(1000000)));
    }
    
    if(m_oscillo.m_line == 1)
    {
      fill(255,0,0);
      rect(175,522,10,10);
    }else
    {
      fill(0,0,0);
      rect(175,522,10,10);
    }
    
    if(m_oscillo.m_oneShot == 1)
    {
      fill(255,0,0);
      rect(105,522,10,10);
    }else
    {
      fill(0,0,0);
      rect(105,522,10,10);
    }
  }
  
  private PImage m_Ifond;
  //private PImage m_Ioscillographe;
  
  private Bouton m_BoneShot; //active le oneshot ou pas
  private Bouton m_Bline;
  private Bouton m_Bcarre;
  private Bouton m_Btriangle;
  private Bouton m_Bsinus;
  
  private Bouton m_BfHZ;
  private Bouton m_BfKHZ;
  private Bouton m_BfMHZ;
  
  private Bouton m_Bcal_10;
  private Bouton m_Bcal_1;
  
  private Slide_bar m_SLIfrequence;
  private Slide_bar m_SLIampli;
  private Slide_bar m_SLIvolt;
  private Slide_bar m_SLIsec;
  
  private Oscillographe m_oscillo;
  //private float posX; // position pour le curseur sur l axe X
  
  //private int posGraphX;
  //private int posGraphY;
}