/*
Conway's Game of Life
Rules:
Any live cell with fewer than two live neighbours dies, as if caused by under-population.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overcrowding.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
*/

boolean GO = false;

// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 100;
int rows = 100;

int i,j;

void setup() {
  size(700,700);
  grid = new Cell[cols][rows];
  for (i = 0; i < cols; i++) {
    for (j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*7,j*7,7,7,i,j);
    }
  }
  
  /*/////////////////Arbitrary Starting Point
  grid[1][1].alive = true;
  grid[1][2].alive = true;
  grid[1][3].alive = true; */
  
}

void draw() {
  background(255);
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
 
 
  if(keyPressed) {  
  for (i = 0; i < cols; i++) {
      for (j = 0; j < rows; j++) {
        grid[i][j].checkNeighbors();
        grid[i][j].setFill();
      }
    }
  
  for (i = 0; i < cols; i++) {
    for (j = 0; j < rows; j++) {
      grid[i][j].changeState();
    }
  }
 }
 
  for (i = 0; i < cols; i++) {
    for (j = 0; j < rows; j++) {
      grid[i][j].display();
    }
  }
  
}

void mouseClicked() {
  if((int(mouseX/7)<cols)&&(int(mouseY/7)<rows)&&(mouseX>=0)&&(mouseY>=0)) { 
    grid[int(mouseX/7)][int(mouseY/7)].swapState();
    grid[int(mouseX/7)][int(mouseY/7)].checkNeighbors();
    grid[int(mouseX/7)][int(mouseY/7)].numAliveNeighbors=-1;
    grid[int(mouseX/7)][int(mouseY/7)].setFill();
  }
}

void mouseDragged() {
  if((int(mouseX/7)<cols)&&(int(mouseY/7)<rows)&&(mouseX>=0)&&(mouseY>=0)) { 
    grid[int(mouseX/7)][int(mouseY/7)].alive=true;
    grid[int(mouseX/7)][int(mouseY/7)].checkNeighbors();
    grid[int(mouseX/7)][int(mouseY/7)].numAliveNeighbors=-1;
    grid[int(mouseX/7)][int(mouseY/7)].setFill();
  }
}

// A Cell object
class Cell {
  boolean alive;
  int numAliveNeighbors,iID,jID;
  float x,y;   // x,y location
  float w,h;   // width and height
  color paintbrush;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, int tempI, int tempJ) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    iID = tempI;
    jID = tempJ;
    alive = false;
    paintbrush=color(255);
    numAliveNeighbors=-1;
  } 
  
  // Oscillation means increase angle
  void checkNeighbors() {
    if(numAliveNeighbors==-1) numAliveNeighbors++;
    int up=(jID==0?rows-1:jID-1), dn=(jID==(rows-1)?0:jID+1), left=(iID==0?cols-1:iID-1), right=(iID==(cols-1)?0:iID+1);
    if (grid[iID][up].alive) ++numAliveNeighbors;
    if (grid[iID][dn].alive) ++numAliveNeighbors;
    if (grid[left][jID].alive) ++numAliveNeighbors;
    if (grid[right][jID].alive) ++numAliveNeighbors;
    if (grid[left][up].alive) ++numAliveNeighbors;
    if (grid[right][up].alive) ++numAliveNeighbors;
    if (grid[left][dn].alive) ++numAliveNeighbors;
    if (grid[right][dn].alive) ++numAliveNeighbors;
  }
  
  void changeState() {
   /* DAY & NIGHT  Born if 3,6,7,8 
    if((numAliveNeighbors==3)||(numAliveNeighbors>=6)) this.alive=true;
    else if(numAliveNeighbors==4) {} //do nothing
    else this.alive=false;
   */
   
   /* HighLife B36/S23 
     if((numAliveNeighbors==3)||(numAliveNeighbors==6)) this.alive=true;
     else if(numAliveNeighbors==2) {} //do nothing
     else this.alive=false;
   */
   
   /* GAME OF LIFE */
    if((numAliveNeighbors>3)||(numAliveNeighbors<2)) this.alive = false;
    else if(numAliveNeighbors==3) this.alive=true;
   
   
    numAliveNeighbors=0;
  }
  
  void swapState() {
   if(this.alive) this.alive=false;
   else this.alive=true; 
  }
  
  void setFill() {
    stroke(0);
    switch(this.numAliveNeighbors) {
     case 0: paintbrush = color(255); break;
     case 1: paintbrush = color(90,175,175); break;
     case 2: paintbrush = color(90,175,90); break;
     case 3: paintbrush = color(175,200,0); break;
     case 4: paintbrush = color(0,255,0); break;
     case 5: paintbrush = color(0,90,255); break;
     case 6: paintbrush = color(90,90,175); break;
     case 7: paintbrush = color(175,175,90); break;
     case 8: paintbrush = color(255,0,0); break;
     default: paintbrush = color(255);
    }
  }

  void display() {
    //this.checkNeighbors();
    fill(this.paintbrush);
    if(this.alive) rect(x,y,w,h); 
  }
}

void swap(boolean variable) {
  if(variable) variable=false;
  else variable=true;  
}

