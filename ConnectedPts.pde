Dot[] dots;
int count= 100;
PVector gravity;

void setup(){
  size(1280, 1024, P2D);
  frameRate(24);
  //set the gravity
  gravity = new PVector(0.2, 0.1);
  //initialize array of objects
  dots = new Dot[count];
  for(int i = 0; i < dots.length; i++){
   dots[i] = new Dot(); 
  }
}

void draw(){
  background(0);
  //iterate through all dots each time
  for(int i = 0; i < dots.length; i++){
    //apply gravity on space bar
    if(keyPressed == true){
      if(key == ' '){
   dots[i].applyForce(gravity);
      }
    }
   dots[i].move();
   dots[i].checkEdges();
   //dots[i].display();
  }
  strokeWeight(8);
  closestPoints(dots, 3);
  saveFrame("ConnectedPts-######.jpg");
}
//prototype function that connects all points to one another (not in use)
void connectLine(Dot[] pts){
  for(int i = 0; i < pts.length; i++){
    for(int j = i + 1; j < pts.length; j++){
   line(pts[i].location.x, pts[i]. location.y, pts[j].location.x, pts[j].location.y);
  }
}
}
//function that connects lines to the numPts closest points
void closestPoints(Dot[] pts, int numPts){
  //iterate through each point
  for(int i = 0; i < pts.length; i++){
    //create a list of points that are close to each point
    int[] list = new int[numPts];
      //iterate through the list
      for(int j = 0; j < list.length; j++){
        //initialize value for the longest diameter for each list
        float shortestD = 0;
          //iterate through each point for the list
        for(int k = 0; k < pts.length - 1; k++){
          //pythagorean theorem for length of hypotenuse
          float d1 = sqrt(pow(pts[i].location.x - pts[k].location.x, 2) + pow(pts[i].location.y - pts[k].location.y, 2));
          float d2 = sqrt(pow(pts[i].location.x - pts[k+1].location.x, 2) + pow((pts[i].location.y - pts[k+1].location.y), 2));
          //if the current point is less than the next point
        if(d1 < d2){
          //an exception for if the first iteration follows the rule
          if(j==0){
          list[j] = k;
          shortestD = d1;
          }
          //if both k was the same as the last point collected and if d1 is less than shortest distance
          else if((list[j-1] != k && d1 < shortestD)){
            list[j] = k;
            shortestD = d1;
          }
          
        }else{
          if(j == 0){
            list[j] = k+1;
           shortestD = d2;
          }
           else{
           shortestD = d2;  
           }
        }
        }
      }
    
     for(int l = 0; l < list.length; l++){
       stroke(pts[i].lineColor);
       line(pts[i].location.x, pts[i].location.y, pts[list[l]].location.x, pts[list[l]].location.y);
     }
   }
}
//an object that tracks and draws the 2d space and physics of each dot
class Dot{
 PVector location;
 PVector velocity;
 PVector acceleration;
 color dotColor;
 color lineColor;
 
 Dot(){
  location = new PVector(random(0, width), random(0, height));
  velocity = new PVector(random(-10,10), random(-15, 15));
  acceleration = new PVector(0,0);
  dotColor = color(random(255), random(50), random(255));
  lineColor = color(random(255), random(50), random(255));
 }
 
 void checkEdges(){
  if(location.x < 0 || location.x > width){
   velocity.x *= -1; 
  }
  if(location.y < 0 || location.y > height){
   velocity.y *= -1; 
  }
 }
 
 void move(){
  velocity.add(acceleration);
  location.add(velocity);
  acceleration.mult(0);
 }
 
 void display(){
  stroke(dotColor);
  strokeWeight(15);
  point(location.x, location.y);
 }
 
 void applyForce(PVector force){
   acceleration.add(force);
 }
}