/**********************************
 * Variables
 **********************************/
  //Total Game
  int timeTotal;
  int startTime;
  
  //Screne Variables
  // 0 -> Main Menu
  // 1 -> Instructions
  // 2 -> Game
  // 3 -> Lose Screne
  int screneType;
  
  //Face object
  Face face;
  
  //Shot Variables  
  int xS;
  int yS;
  int timeSinceLastShot;
  ArrayList<UpShot> UPshots;
  ArrayList<DownShot> DOWNshots;
  ArrayList<LeftShot> LEFTshots;
  ArrayList<RightShot> RIGHTshots;
  
  //Homework variables
  ArrayList<Homework> homeworks;
  int timeSinceLastHW;
  int timeVariable;
 
  //Point variables
  int points;

/**********************************
 * Set up window and initialize variables
 **********************************/
void setup() {
  size(1000, 700);
  background(100, 150, 150);
  
  //Total Game
  timeTotal = 0;
  startTime = millis();
  
  //Screne Variables
  screneType = 0;
  
  //Face object
  face = new Face();
  
  //Shot Variables
  xS = mouseX;
  yS = mouseY+9;
  timeSinceLastShot = millis();
  UPshots = new ArrayList<UpShot>();
  DOWNshots = new ArrayList<DownShot>();
  LEFTshots = new ArrayList<LeftShot>();
  RIGHTshots = new ArrayList<RightShot>();
  
  //Homework variables
  homeworks = new ArrayList<Homework>();
  timeSinceLastHW = millis();
  timeVariable = 3000;
  
  //Point variables
  points = 0;
}

/**********************************
 * Draw game
 **********************************/
void draw() {
  if (screneType == 0){
    //Main Menu
    
    background(100, 150, 150);
    cursor(ARROW);
    rectMode(CORNER);
    stroke(0);
    strokeWeight(5);
    
    //"Face Monster"
    textSize(90);
    fill(0);
    text("Face Monster", width/2 - 295, 115);
    fill(153,0,153);
    text("Face Monster", width/2 - 290, 120);
    
    //Play
    fill(150, 150, 0);
    rect(width/2 - 200, 200, 400, 150, 10, 10, 10, 10);
    fill(50);
    textSize(90);
    text("PLAY", width/2 - 100, 310);
    
    //Instructions
    fill(150, 150, 0);
    rect(width/2 - 300, 500, 600, 150, 10, 10, 10, 10);
    fill(50);
    textSize(80);
    text("INSTRUCTIONS", width/2 - 285, 610);
    
    if (mousePressed){
      if (mouseX > width/2 - 200 && mouseX < width/2 + 400 && mouseY > 200 && mouseY < 350){
        screneType = 2;
      }
      else if (mouseX > width/2 - 300 && mouseX < width/2 + 300 && mouseY > 500 && mouseY < 650){
        screneType = 1;
      }
    }
  }
  else if (screneType == 1){
    //Instructions
    
    strokeWeight(1);
    background(100, 150, 150);
    
    //Instruction paragraph
    fill(0);
    textSize(30);
    text("The mouse controls where the face goes.", 150, 100);
    text("Shoot at the homework in the middle square.", 150, 140);
    text("Shoot using the arrow keys.", 150, 180);
    text("", 150, 220);
    text("When 20 homeworks stay in the square, you lose.", 150, 260);
    
    //Main Menu
    fill(150, 150, 0);
    rect(20, 550, 150, 130, 10, 10, 10, 10);
    fill(50);
    textSize(40);
    text("Main", 45, 600);
    text("Menu", 40, 650);
    
    if (mousePressed){
      if (mouseX > 20 && mouseX < 170 && mouseY > 550 && mouseY < 680){
        screneType = 0;
      }
    }
  }
  else if (screneType == 3){
    //Lose screne
    
    textSize(150);
    fill(0);
    text("YOU LOSE", 148, 298);
    fill(200, 0, 0);
    text("YOU LOSE", 150, 300);
    if (mousePressed){
      homeworks.clear();
      screneType = 0;
    }
  }
  else if (screneType == 2){ 
    //Game
    
    //Outline color red
    strokeWeight(1);
    stroke(200, 50, 50);
  
    //Add new shot in different directions depending on arrow key presses
    //Only allow 1 shot every 300 ms
    if (keyPressed){
      if (key == CODED) {
        if (millis() - timeSinceLastShot >= 500){
          timeSinceLastShot = millis();
        
          xS = face.xFace-2;
          yS = face.yFace+10;
        
          if (keyCode == UP) {
            UPshots.add(new UpShot(xS, yS));
          }
          else if (keyCode == DOWN) {
            DOWNshots.add(new DownShot(xS, yS));
          }
          else if (keyCode == LEFT) {
            LEFTshots.add(new LeftShot(xS, yS));
          } 
          else if (keyCode == RIGHT) {
            RIGHTshots.add(new RightShot(xS, yS));
          } 
        }
      }
    }
  
    //Draw the face where the mouse is
    face.move();
  
    //Draw barrier
    noFill();
    rect(99, 99, width - 198, height - 198);
  
    //Draw the shots as they move
    for (int i = 0; i < UPshots.size(); i++){
      if (UPshots.get(i).checkSpot()){
        UPshots.get(i).move();
      }
      else{
        UPshots.remove(i);
      }
    }
    for (int i = 0; i < DOWNshots.size(); i++){
      if (DOWNshots.get(i).checkSpot()){
        DOWNshots.get(i).move();
      }
      else{
        DOWNshots.remove(i);
      }
    }
    for (int i = 0; i < LEFTshots.size(); i++){
      if (LEFTshots.get(i).checkSpot()){
        LEFTshots.get(i).move();
      }
      else{
        LEFTshots.remove(i);
      }
    }
    for (int i = 0; i < RIGHTshots.size(); i++){
      if (RIGHTshots.get(i).checkSpot()){
        RIGHTshots.get(i).move();
      }
      else{
        RIGHTshots.remove(i);
      }
    }
  
    //Add homework every few seconds
    if(millis() - timeSinceLastHW >= timeVariable){
      timeSinceLastHW = millis();
     
      //Decrement time between homeworks
      timeTotal = millis() - startTime;
      timeVariable = 1000 * (2 ^ (-(3/4) * timeTotal));
    
      homeworks.add(new Homework(int(random(100,100+(width-100)/2)), int(random(100,100+(height-100)/2))));
    }
    
    if (homeworks.size() == 20){
      screneType = 3;
    }
  
    //Draw the homework as it moves
    for (int i = 0; i < homeworks.size(); i++){
      homeworks.get(i).move();
    }
  
    //Set flag if a homework is deleted
    boolean HWdeleted = false;
  
    //Check to see if Shots have hit Homework
    int j = 0;
    while(!HWdeleted && j < homeworks.size()){
      HWdeleted = false;
    
      int a = 0;
      while(!HWdeleted && a < UPshots.size()){
        if(homeworks.get(j).xHW < UPshots.get(a).xShot + 5 && (homeworks.get(j).xHW + homeworks.get(j).Width) > UPshots.get(a).xShot + 5
            && homeworks.get(j).yHW < UPshots.get(a).yShot + 5 && (homeworks.get(j).yHW + homeworks.get(j).Height) > UPshots.get(a).yShot + 5){
            
              homeworks.remove(j);
              UPshots.remove(a);
              points++;
              HWdeleted = true;
         }
         a++;
      }
    
      a = 0;
      while(!HWdeleted && a < DOWNshots.size()){
        if(homeworks.get(j).xHW < DOWNshots.get(a).xShot + 5 && (homeworks.get(j).xHW + homeworks.get(j).Width) > DOWNshots.get(a).xShot + 5
            && homeworks.get(j).yHW < DOWNshots.get(a).yShot + 5 && (homeworks.get(j).yHW + homeworks.get(j).Height) > DOWNshots.get(a).yShot + 5){
              
              homeworks.remove(j);
              DOWNshots.remove(a);
              points++;
              HWdeleted = true;
         }
         a++;
      }
    
      a = 0;
      while(!HWdeleted && a < LEFTshots.size()){
        if(homeworks.get(j).xHW < LEFTshots.get(a).xShot + 5 && (homeworks.get(j).xHW + homeworks.get(j).Width) > LEFTshots.get(a).xShot + 5
            && homeworks.get(j).yHW < LEFTshots.get(a).yShot + 5 && (homeworks.get(j).yHW + homeworks.get(j).Height) > LEFTshots.get(a).yShot + 5){
              
              homeworks.remove(j);
              LEFTshots.remove(a);
              points++;
              HWdeleted = true;
         }
         a++;
      }
      
      while(!HWdeleted && a < RIGHTshots.size()){
        if(homeworks.get(j).xHW < RIGHTshots.get(a).xShot + 5 && (homeworks.get(j).xHW + homeworks.get(j).Width) > RIGHTshots.get(a).xShot + 5
            && homeworks.get(j).yHW < RIGHTshots.get(a).yShot + 5 && (homeworks.get(j).yHW + homeworks.get(j).Height) > RIGHTshots.get(a).yShot + 5){
              
              homeworks.remove(j);
              RIGHTshots.remove(a);
              points++;
              HWdeleted = true;
         }
         a++;
      }
      
      j++;
    }
  
    //Draw score
    String s = "Score: " + points;
    fill(153,0,153);
    textSize(20);
    text(s, 10, 10, 200, 80);
    
    //Draw Main Menu directions
    fill(0);
    textSize(20);
    text("Press ENTER = Main Menu", 350, 10, 300, 80);
    
    if(keyPressed){
      if(key == ENTER){
        homeworks.clear();
        screneType = 0;
      }
    }
  }
}

/**********************************
 * Face class
 **********************************/
class Face{
  int xFace;
  int yFace;

  Face(){ 
    xFace = 0;
    yFace = 0;
  }
  
  /*
   * 0 => free movement
   * 1 => move x
   * 2 => move y
   */
  int checkSpot(){
    if ((xFace < 100 || xFace > width - 100) && (yFace < 100 || yFace > height - 100) && mouseX - 25 < width - 100 && mouseX + 25 > 100 
          && mouseY - 25 < height - 100 && mouseY + 25 > 100)
      return 3;
    else if ((yFace < 100 || yFace > height - 100) && mouseX - 25 < width - 100 && mouseX + 25 > 100 
          && mouseY - 25 < height - 100 && mouseY + 25 > 100)
      return 1;
    else if ((xFace < 100 || xFace > width - 100) && mouseX - 25 < width - 100 && mouseX + 25 > 100 
          && mouseY - 25 < height - 100 && mouseY + 25 > 100)
      return 2;
    else
      return 0;
  }
  
  void move(){
    int check = checkSpot();
    
    if (check == 2){
      cursor(CROSS);
    
      xFace = xFace;
      yFace = mouseY;
    }
    else if (check == 1){
      cursor(CROSS);
    
      xFace = mouseX;
      yFace = yFace;
    }
    else if (check == 3) {
      cursor(CROSS);
      xFace = xFace;
      yFace = yFace;
    }
    else{
      noCursor();
    
      xFace = mouseX;
      yFace = mouseY;
    }
    
    //Clear screen
    background(100, 150, 150);
  
    //Draw face
    ellipseMode(CENTER);
    //Green face
    fill(150, 150, 0);
    ellipse(xFace, yFace, 50, 50);
    //White of eyes
    fill(255);
    ellipse(xFace-15, yFace, 20, 20);
    ellipse(xFace+15, yFace, 20, 20);
    //Blue iris
    fill(0,0,255);
    ellipse(xFace-15, yFace, 10, 10);
    ellipse(xFace+15, yFace, 10, 10);
    //Black puple
    fill(0);
    ellipse(xFace-15, yFace, 4, 4);
    ellipse(xFace+15, yFace, 4, 4);
  
    //Eyebrows
    fill(0);
    arc(xFace, yFace+20, 10, 25, -PI, 0); // 180 degrees
    arc(xFace-15, yFace-20, 25, 10, 2*PI/2, 13*PI/6);
    arc(xFace+15, yFace-20, 25, 10, 5*PI/6, 4*PI/2);
  }
}

/**********************************
 * Shot classes
 **********************************/
 
/**********************************
 * Left moving shot
 **********************************/ 
class LeftShot extends Shot{

  LeftShot(int xS, int yS){
    super(xS, yS);
  }
  
  void move() {
    super.move();
    xShot--;
  }
}

/**********************************
 * Right moving shot
 **********************************/ 
class RightShot  extends Shot{

  RightShot(int xS, int yS){
    super(xS, yS);
  }

  void move() {
    super.move();
    xShot++;
  }
}

/**********************************
 * Up moving shot
 **********************************/ 
class UpShot extends Shot{

  UpShot(int xS, int yS){
    super(xS, yS);
  }
  
  void move() {
    super.move();
    yShot--;
  }
}

/**********************************
 * Down moving shot
 **********************************/ 
class DownShot extends Shot{
  
  DownShot(int xS, int yS){
    super(xS, yS);
  }
  
  void move() {
    super.move();
    yShot++;
  }
}

/**********************************
 * Main shot class
 **********************************/ 
class Shot{
  int xShot;
  int yShot;
  
  Shot(int xS, int yS){
    xShot = xS;
    yShot = yS;
  }
  
  //Checks that object is within the screen
  boolean checkSpot(){
    if (xShot < width && yShot < height)
      return true;
    else
      return false;
  }
  
  //Draws object at new coordinates
  void move() {
    ellipseMode(CORNER);
    fill(153,0,153);
    ellipse(xShot, yShot, 10, 10);
  }
}

/**********************************
 * Moving homework
 **********************************/ 
class Homework{
  int xHW;
  int yHW;
  int Width;
  int Height;
  int xdirection;
  int ydirection;
  
  Homework(int xH, int yH){
    xHW = xH;
    yHW = yH;
    Width = 40;
    Height = 50;
    xdirection = 1;
    ydirection = 1;
  }
  
  //Draws object at new coordinates
  void move() {
    rectMode(CORNER);
    stroke(0);
    fill(255);
    rect(xHW, yHW, Width, Height);
    line(xHW + 5, yHW + 20, xHW + (Width - 5), yHW + 20);
    line(xHW + 5, yHW + 30, xHW + (Width - 5), yHW + 30);
    line(xHW + 5, yHW + 40, xHW + (Width - 5), yHW + 40);

    if (xHW + Width > width-100 || xHW < 100) {
      xdirection *= -1;
    }
    if (yHW + Height > height-100 || yHW < 100) {
      ydirection *= -1;
    }
    
    xHW = xHW + xdirection;
    yHW = yHW + ydirection;
  }
}
