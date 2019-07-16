import java.util.ArrayList;


ArrayList<PVector> points;

void setup() {
  
  //render params
  size(1024, 640);
  
  //noSmooth();
  //fullScreen();
  frameRate(400);
  strokeWeight(3);
  point(640,56);
  
  PVector[] points;
  int pointsNumber = 100;
  points = RandomPoints(pointsNumber);
  color[] colors;
  colors = randomColors(pointsNumber);
  
  // random point drawing
  for(PVector p : points){
    //print(p.x+","+p.y+"\n");
    point(p.x,p.y); 
  }
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
         distances[i]  = euclideanDistance(point,points[i]);
     }  

  }
  else{
    
     for(int i = 0; i < points.length;i++){
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

void voronoi(PVector[] points, color[] colors){
   
    for(int i = 0; i < height * width;i++){
      
      
      
    }
  
}
