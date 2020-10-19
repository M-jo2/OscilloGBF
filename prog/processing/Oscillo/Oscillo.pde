import processing.serial.*;

Ecran ecran;
PFont police;

void setup()
{
  size (1000,600);
  frameRate(60);
  clear();
  police = loadFont("SimplifiedArabicFixed-15.vlw");
  textFont(police);
  ecran = new Ecran();
}

void draw()
{
  ecran.affiche();
  view_FPS();
}


int temps =0;
int old_temps =temps;
int compteur =0;
int FPS=compteur;

void view_FPS()
{
  temps = millis();
  compteur ++;
  if(temps-old_temps >= 1000)
  {
    FPS = compteur;
    old_temps = temps;
    compteur = 0;
  }
  fill(200,255,0);
  textSize(15);
  textAlign(CENTER,CENTER);
  text(str(FPS),930,21);
}