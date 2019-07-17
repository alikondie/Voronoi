import java.util.ArrayList;
import controlP5.*;
PVector[] points;
color[] colors;
int pointsNumber = 50;
int graphWidth = 1024;
int graphHeight = 640;
boolean keepPoints = false;
boolean distance = true;
void setup() {
  
  //render params
  size(1324, 640);
  background(228, 235, 228);
  //noSmooth();
  //fullScreen();
  frameRate(400);
  
  
  //PVector[] points;
  

  guiLayout();
  //voronoi(points,colors,false);

  // GUI
}


PVector[] RandomPoints(int pointsNumber){
  int range = graphWidth * graphHeight;
  PVector[] points = new PVector[pointsNumber];
  for(int i = 0; i < pointsNumber;i++){
    int rPoint = round(random(range));
    int xPos = rPoint / graphWidth;
    int yPos = rPoint - ( xPos * graphWidth);
    points[i] = new PVector(yPos,xPos);
    
  }
  
  return points;
}

float euclideanDistance(PVector p1, PVector p2){
  
  return(sqrt(sq(p1.x-p2.x)+sq(p1.y-p2.y)));
  
}

float manhattanDistance(PVector p1, PVector p2){
  
  return(abs(p1.x - p2.x)+abs(p1.y - p2.y));
  //return 0;
}

color[] randomColors(int pointsNumber){
  
  color[] colors = new color[pointsNumber];
  for(int i = 0; i < pointsNumber;i++){
    colors[i] = color(random(20,235),random(20,235),random(20,235));
  }
  return (colors);
}

int minDistanceIndex(PVector point, PVector[] points,boolean isManhattan){
  
  
  
  float[] distances = new float[points.length];
  if(!isManhattan){
    
     for(int i = 0; i < points.length;i++){
         if(point.x == points[i].x && point.y == points[i].y)
           return -5;
         distances[i]  = euclideanDistance(point,points[i]);
     }  

  }
  else{
    
     for(int i = 0; i < points.length;i++){
         if(point.x == points[i].x && point.y == points[i].y)
           return -5;
         distances[i]  = manhattanDistance(point,points[i]);
     }  
  }
  
  float min = Integer.MAX_VALUE;
  int minIndex = -1;
  
  for(int i = 0; i < distances.length;i++){
    if(distances[i] < min){
      min = distances[i];
      minIndex = i;
    }
  }
  return minIndex;
  
}
void draw(){
  
}
void voronoi(PVector[] points, color[] colors,boolean isManhattan){
    //strokeWeight(3);
    PVector point;
    int xPos;
    int yPos;
    int index;
    for(int i = 0; i < graphHeight * graphWidth;i++){
        xPos = i / graphWidth;
        yPos = i - ( xPos * graphWidth);
        point = new PVector(yPos,xPos);
        if(!isManhattan)
          index = minDistanceIndex(point,points,false);
        else
          index = minDistanceIndex(point,points,true);
        if(index == -5)
        {
          
          stroke(color(0,0,0));
          fill(color(0,0,0));
          circle(yPos, xPos, 5);
        }
        else{
          stroke(colors[index]);
          point(yPos,xPos);
        }
    }
  
}
void guiLayout(){
      cp5 = new ControlP5(this);
  cp5.addButton("Draw",1,1110,220,80,40).setId(1);
  cp5.addTextlabel("Number of points").setText("Number Of Points").setPosition(1110,270).setColorValue(0x00000000);
  cp5.addNumberbox("pointsSlider")
     .setPosition(1110,290)
     .setSize(100,14)
     .setScrollSensitivity(1.1)
     .setValue(50).setId(2);
  cp5.addTextlabel("Distance").setText("Distance").setPosition(1110,315).setColorValue(0x00000000);
  cp5.addButton("Manhattan",1,1110,330,80,40).setId(3);
  
  //cp5.getController("pointsSlider").setMax(255);
  cp5.getController("pointsSlider").setMin(2);
  
  
  cp5.addTextlabel("keep current points").setText("Keep current points").setPosition(1110,380).setColorValue(0x00000000);
  cp5.addCheckBox("checkBox")
                .setPosition(1110, 400)
                .setSize(20, 20)
                .setItemsPerRow(3)
                .setSpacingColumn(30)
                .setSpacingRow(20)
                .addItem("0", 0).setId(4);

}

void clearCanvas(){
  /*stroke(color(228, 235, 228));
      PVector point;
    int xPos;
    int yPos;
    int index;
    for(int i = 0; i < graphHeight * graphWidth;i++){
        xPos = i / graphWidth;
        yPos = i - ( xPos * graphWidth);
        point(yPos,xPos);
    }*/
    background( 228, 235, 228 );

}

public void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.getId());
  switch(theEvent.getId()) {
    case(1): // numberboxA is registered with id 1
    //myColorRect = (int)(theEvent.getController().getValue());
    if(keepPoints){
      if(points == null && colors == null){
        points = RandomPoints(pointsNumber);
        colors = randomColors(pointsNumber);
      }
    }
    else{
      points = RandomPoints(pointsNumber);
      colors = randomColors(pointsNumber);
    }
     clearCanvas();
     voronoi(points,colors,distance);
    break;
    case(2):  // numberboxB is registered with id 2
      pointsNumber = (int)(theEvent.getController().getValue());
      
    break;
    case(3):  // numberboxB is registered with id 2
      distance = !distance;
      theEvent.getController().setCaptionLabel(distance ? "Manhattan" : "Euclidean" );
    break;
    case(4):  // numberboxB is registered with id 2
      keepPoints = (theEvent.getArrayValue()[0] == 0) ? false:true;
      print(keepPoints);
    break;
  }
}
