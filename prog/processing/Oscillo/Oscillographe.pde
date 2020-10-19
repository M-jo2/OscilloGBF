class Oscillographe{
  Oscillographe()
  {
    m_Ioscillographe = loadImage("image/oscillographe.png");
    image(m_Ioscillographe,10,10);
    m_TimeDivValeur = 10;
    m_TimeDivMultiple = 1/1000;
    m_VoltDivValeur = 1;
    m_VoltDivMultiple = 1;
    m_line=1;
    m_decaX =5;
    m_oneShot = 0;
    m_buffer = 5;
    m_lastModif=0;
    m_posX = 20;
    m_posY_0 = 200;
    
    multi = new Multi();
  }
  void calibrage(float x, float y) 
  {
    float cal_valX = 1;
    float cal_valY = 1.56;
    
    // que vaut réelement x=0 et y=0? regler dans le constructeur
    // pour 1 pixel quel valeur en x et en y ? 
    // place le point dans un string à spliter après
    
    m_oldPosY_0 = m_reelPosY;
    m_reelPosY=(-(y)*cal_valY)+m_posY_0+200;
    
    m_reelPosX=(x*cal_valX)+m_posX;
  }
  void Set_TimeDiv(float valeur, float multiple)
  {
    m_TimeDivValeur = valeur;
    m_TimeDivMultiple = multiple;
  }
  void Set_VoltDiv(float valeur, float multiple)
  {
    m_VoltDivValeur = valeur;
    m_VoltDivMultiple = multiple;
  }
  void Pos_graph(float x, float y) //curseur de l oscillographe
  {
    fill(255,255,255);
    stroke(200,200,200);
    triangle(530,y,540,y+5,540,y-5);
    triangle(x,430,x+5,440,x-5,440);
  }
  
  
  void click() //on défini le point 'origine pour le graph
  {
    if(((mouseX >20)&&(mouseX <520)&&(mouseY >20)&&(mouseY <420)) 
      && (mousePressed ==true)) 
      {
        m_posY_0 = mouseY;
      }
    Pos_graph(m_posX,m_posY_0);
  }
  
  void affiche()
  {
    if(m_oneShot == 1)
    {
      m_lastModif=0;
      Data = null;
    }else
    {
      if(Data!=null)
      {
        String [] inputString = split(Data,':');
        float[] pointY = new float[inputString.length];
        Data = null;
        for(int i=0;i<pointY.length;i++) 
        {
          pointY[i] = float(inputString[i]);
          m_posYS[m_lastModif] = pointY[i];
          multi.tension(m_posYS[i]);
          m_lastModif++;
        }
        
      }
    }
    
    if(m_lastModif > 99)
    {
      m_lastModif=0; // réinitialisation du curseur
    }
    
      float posX = 0; // position changeante du curseur (on place les point à l'écran)
      image(m_Ioscillographe,10,10);
      for(int i=0;i<100;i++)
      {
          stroke(255,0,50);
          //println(str(m_posYS[i]));
          calibrage(posX,m_posYS[i]);
          multi.affiche();
          stroke(250,0,0);
          posX+=m_decaX;
          if(m_line == 1)
          { 
            strokeWeight(2);
            if(i != 0)//car (i=0)-1 n éxiste pas ET que l option line soit activée
              line(m_reelPosX-m_decaX,m_oldPosY_0,m_reelPosX,m_reelPosY); // ces données sont gerer dans calibrage();
          }else{
            strokeWeight(3);
            point(m_reelPosX,m_reelPosY);
          }
          strokeWeight(1);
          fill(255,0,0);
      }
  }
  
  private int m_buffer; //cadence d'envoie de requête 
  
  private float[] m_posYS = new float [1000]; 
  private int m_lastModif; //enregistre la dernière cellule modifiée du tableau m_posXS
  
  private float m_posY_0; // position d origine pour le graph (oscillo)
  private float m_oldPosY_0; //ancienne position du curseur en Y (oscillo)
  private float m_posY_1; // position d origine pour le graph (GBF)
  private float m_oldPosY_1; //ancienne position du curseur en Y (GBF)
  private float m_posX; // position d origine pour le graph
  
  private float m_reelPosX;
  private float m_reelPosY;
  
  private float m_decaX; // nombre de pixel après le prochain point en X
  
  public int m_line; // option ligne ou point
  
  public int m_oneShot;
 
  private float m_TimeDivValeur;
  private float m_TimeDivMultiple;
  private float m_VoltDivValeur;
  private float m_VoltDivMultiple;
  private PImage m_Ioscillographe;
  
  private Multi multi;
  
};