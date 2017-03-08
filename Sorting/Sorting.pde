import java.util.Random;

int[] nums;
int howMany = 1_000;
int maxNum = 1_000_000;

float screenWidth = 800;
float screenHeight = 600;

void setup() {
  size(800, 600);
  
  // Give us a random object
  Random rand = new Random();
  // Fill the array with random things
  nums = new int[howMany];
  for (int i = 0; i < howMany; i++) {
    nums[i] = rand.nextInt(maxNum);  
  }
}

void draw() {
  frameRate(600);
  selectionSort();
  //insertionSort();
}

int s_i = 0;
int s_beg_i = 0;
int s_smallestIdx = 0;
void selectionSort() {
  if (s_beg_i >= nums.length) {
    return; 
  }
  if (s_i == nums.length - 1) {
    // Put the smallest at the beginning
    int temp = nums[s_beg_i];
    drawNums(s_beg_i, s_smallestIdx);
    nums[s_beg_i] = nums[s_smallestIdx];
    nums[s_smallestIdx] = temp;
    drawNums(s_beg_i, s_smallestIdx);
    s_beg_i++;
  
    // then restart
    s_smallestIdx = s_beg_i;
    s_i = s_beg_i + 1;
  }
  // Draw one step
  drawNums(s_i, s_smallestIdx);
  if (nums[s_i] < nums[s_smallestIdx]) {
    s_smallestIdx = s_i;
  }
  // Go to the next step
  s_i++;
  /*
  // Find the smallest element after position s_i
  int smallestIdx = s_cur_i;
  for (int i = s_cur_i; i < nums.length; i++) {
    //drawNums(smallestIdx, i);
    if (nums[i] < nums[smallestIdx]) {
      smallestIdx = i;
      drawNums(i, -1);
    }
  }
  // Put the smallest at the beginning
  int temp = nums[s_cur_i];
  drawNums(s_cur_i, smallestIdx);
  nums[s_cur_i] = nums[smallestIdx];
  nums[smallestIdx] = temp;
  drawNums(s_cur_i, smallestIdx);
  s_cur_i++;
  */
}

//int i_i = 0;
int i_beg_i = 1;
int i_j = 0;
void insertionSort() {
  // If I'm finished, quit.
  if (i_beg_i >= nums.length) {
    return; 
  }
  if (i_j == 0 || nums[i_j-1] <= nums[i_j]) {
    i_beg_i++;
    i_j = i_beg_i - 1;
  }
  drawNums(i_j-1, i_j); 
  // Swap them
  int temp = nums[i_j];
  nums[i_j] = nums[i_j - 1];
  nums[i_j - 1] = temp;
  i_j--;
  /*
  int j = i_beg_i - 1;
  while (j > 0 && nums[j-1] > nums[j]) {
    drawNums(j-1, j);
    // Swap them
    int temp = nums[j];
    nums[j] = nums[j - 1];
    nums[j - 1] = temp;
    j--;
  }
  */
}

void drawNums(int id1, int id2) {
  background(255);
  noStroke();
  float rectWidth = screenWidth / nums.length;
  for (int i = 0; i < nums.length; i++) {
    // If we're looking at it, set it to be red
    if (i == id1 || i == id2) {
      fill(255, 0, 0); 
    } else {
      // Otherwise, set it to be blue.
      fill(0, 0, 255); 
    }
    rect(i * rectWidth,
         screenHeight - (float)nums[i]/maxNum * screenHeight,
         rectWidth, (float)nums[i]/maxNum * screenHeight);
  }
}