import java.util.ArrayList;
ArrayList<PVector> points;
color[] colors;
void setup() {
  
  //render params
  size(1024, 640);
  
  //noSmooth();
  //fullScreen();
  frameRate(400);
  
  
  PVector[] points;
  int pointsNumber = 20;
  points = RandomPoints(pointsNumber);
  
  colors = randomColors(pointsNumber);
  
  voronoi(points,colors,false);
}


PVector[] RandomPoints(int pointsNumber){
  int range = width * height;
  PVector[] points = new PVector[pointsNumber];
  for(int i = 0; i < pointsNumber;i++){
    int rPoint = round(random(range));
    int xPos = rPoint / width;
    int yPos = rPoint - ( xPos * width);
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

void voronoi(PVector[] points, color[] colors,boolean isManhattan){
    //strokeWeight(3);
    PVector point;
    int xPos;
    int yPos;
    int index;
    for(int i = 0; i < height * width;i++){
        xPos = i / width;
        yPos = i - ( xPos * width);
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
        //print(index+"\n");
        
        
    }
  
}
