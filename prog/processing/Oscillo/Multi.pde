class Multi{
  Multi()
  {
    m_max = 0;
    m_min = 0;
    m_pos = 0;
    m_stat = 0;
    m_oldpos = 0;
    m_oldstat = 0; 
    m_amplitude = 0;
    
    m_posFenetreX = 20;
    m_posFenetreY = 20;
  }
  
  void tension (float pos)
  {
    m_pos = (pos - 128)/25.6; //128 = 5v et -128= -5v
    
    if ( m_oldpos > m_pos ) m_stat =1 ; 
    if ( m_oldpos < m_pos ) m_stat =0 ; 
    
    if ( m_stat != m_oldstat )
    {
      if(m_stat == 1) m_max = m_pos;
      if(m_stat == 0) m_min= m_pos;
      m_oldstat = m_stat;
    }
    
    m_amplitude = m_max-m_min;
    m_oldpos = m_pos;
  }
  
  void affiche()
  {
    strokeWeight(1);
    fill(255,255,255);
    stroke(0,0,0);
    rect(m_posFenetreX,m_posFenetreY,200,100);
    fill(0,0,0);
    
    textAlign(LEFT,TOP);
    text("Vmax : "+str(m_max),m_posFenetreX+3,m_posFenetreY + 10);
    text("Vmin : "+str(m_min),m_posFenetreX+3,m_posFenetreY + 22);
    text("Vpp : "+str(m_amplitude),m_posFenetreX+3,m_posFenetreY + 34);
    text(str(m_stat),m_posFenetreX+3,m_posFenetreY + 46);
    //println(m_pos);
    text(str(m_pos),m_posFenetreX+3,m_posFenetreY + 58);
  }
  
  private int m_posFenetreX;
  private int m_posFenetreY;
  private float m_max;
  private float m_min;
  private float m_amplitude;
  
  private float m_pos;
  private float m_stat;
  
  private float m_oldpos;
  private float m_oldstat; 
}