import java.util.*; 

//globals
int[][] grid;
int rows = 40;
int cols = 40;
int cols_width;
int rows_height;

//function for creating a grid of cells with specified number of rows and columns
int[][] gameGrid(int rows, int cols) {
  Random r = new Random();
  int[][] g_grid = new int[rows][cols];
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      g_grid[i][j] = r.nextInt(2);
    }
  }
  return g_grid;
}

void setup() {
  size(480, 480);
  background(0);
  cols_width = width / cols; 
  rows_height = height / rows;
  grid = gameGrid(rows, cols);
  
}

void draw(){
  background(0);
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      int x = i * rows_height;
      int y = j * cols_width;
      if (grid[i][j] == 1){
        fill(255);
        strokeWeight(0);
        rect(x, y, cols_width, rows_height);
      }
    }
  }
  // Creating a new grid for storing the next state of the game
  int[][] new_grids = gameGrid(cols, rows);
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      int sum = 0;
      // counting the number of live neighbors
      if (i > 0){
        if (j > 0)
          sum += grid[i-1][j-1];
        sum += grid[i-1][j];
        if (j < cols-1)
          sum += grid[i-1][j+1];
      }
      if (j > 0)
        sum += grid[i][j-1];
      if (j < cols-1)
      sum += grid[i][j+1];
      if (i < rows-1){
        sum += grid[i+1][j-1];
        sum += grid[i+1][j];
        if (j < cols-1)
          sum += grid[i+1][j+1];
      }
      if (grid[i][j] == 0 && sum == 3){
        new_grid[i][j] = 1;
      }
      else if (grid[i][j] == 1 && (sum < 2 || sum > 3)){
        new_grid[i][j] = 0;
      }
      else{
        new_grid[i][j] = grid[i][j];
      }
    }
  }
  
  grid = new_grid;
  delay(200);
}
