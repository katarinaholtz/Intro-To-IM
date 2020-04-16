/* 
 
 Elon Musk Tweet Generator
 by Katarina Holtzapple
 with help from Marcelo Sandoval and Mark Grossmann
 
 April 2020
 
 data_elonmusk.csv found at: https://www.kaggle.com/kulgen/elon-musks-tweets/data
 images found by Google search for 'Elon Musk funny', cited in github at:
 https://github.com/katarinaholtz/Intro-To-IM/tree/master/April14
 
 INSTRUCTIONS:
 Click to change the tweet and image
 
 */

//Universal variables:

Table table;

//Variables related to tweets
String [] array_of_tweets; //creates an array of tweets
int current_tweet;         //indicates the randomly chosen tweet
String first_half;         //if tweet over char_count, split to first_half
String second_half;        //if tweeet over char_count, split to second_half
String print_tweet;         //new tweet of first_half + \n + second_half
String [] array_of_dates;  //creates an array of the dates 
int char_limit = 120;       //the number of characters over which a tweet needs two lines   

boolean update;            //to change the tweet when MouseClicked

//Varibles related to the photos:
PImage [] array_of_pictures;  //creates an array from called pictures
String [] pic_paths = {"elonmeh.jpeg", "elonjoint.jpeg", "eloncat.jpg", "elontpoint.jpeg", "elonsmirking.jpeg", "elonzipline.jpeg", "elonthinking.jpeg"};
int current_image;            //the displayed image
int counter;                  
float x_img;                  //x position of image
float y_img;                  //y position of image

int TwitterBlue = #243447;    //background color
int white = 250;              //tweet box color
int black = 0;                //text color



void setup() {
  size(1200, 600);          
  background(TwitterBlue);
  fill(white);
  rect(width/20, height/20, width/1.5, height/8, 5);    //create a white 'tweet bubble' 

  table = loadTable("data_elonmusk.csv", "header");   //load csv data

  array_of_tweets = new String[table.getRowCount()];  //creates an empty array with slots for all the rows of tweets

  //populates the array_of_tweets from column 'Tweet'
  int i = 0;
  for (TableRow row : table.rows()) {
    String tweet = row.getString("Tweet");
    array_of_tweets[i] = tweet;
    i++;
  }

  array_of_dates = new String[table.getRowCount()];   //creates an empty array with slots for all the rows of tweets/dates

  //populates the array_of_dates from column 'Time'
  int k = 0;
  for (TableRow row : table.rows()) {
    String date = row.getString("Time");
    array_of_dates[k] = date;
    k++;
  }

  array_of_pictures = new PImage[7];    //creates an empty arraw with slots for the photos

  //populates the array_of_pictures with the photos
  int j = 0;
  for (String path : pic_paths) {
    array_of_pictures[j] = loadImage(path);
    j++;
  }
  counter = 0;  //sets counter to 0
  x_img = 0;    //sets x position to 0
  y_img = 0;    //sets y position to 0
}




void draw() {
  //if mouseClicked = true:
  if (update) {                      
    current_tweet = int(random(0, table.getRowCount()));  //call random row of Tweet
    update = false;   //set mouseClicked to false to prevent sensitive mouse click changes             
    current_image++;  //call next image in array         
    if (current_image > 6) {    //if last image in array, return to first
      current_image = 0;
    }
  }
  background(TwitterBlue);
  fill(white);
  rect(width/20, height/20, width/1.5, height/8, 5);      //create a white 'tweet bubble' 

  //creates a new line if tweet over a character length
  if (array_of_tweets[current_tweet].length() > char_limit) {
    first_half = array_of_tweets[current_tweet].substring(0, char_limit); //creates a new string with first half of characters
    second_half = array_of_tweets[current_tweet].substring(char_limit);   //creates a new string with remaining characters
    print_tweet = first_half + "-" + '\n' + second_half;                   //creates a new string with \n for a line break between
  } else {
    print_tweet = array_of_tweets[current_tweet];        //if not longer than char_limit, tweet is from array without a line break
  }

  //draw text 
  fill(black);
  text(print_tweet, width/13, height/12);
  text(array_of_dates[current_tweet], width/1.8, height/7);
  
  PImage img = array_of_pictures[current_image];

  if (counter % 10 == 0) {
    counter = 0;
    x_img = random(width);
    y_img = random(50, height);
  }

  image(img, x_img, y_img, img.width, img.height);

  counter++;
}


void mouseClicked() {
  update = true;
}

void mouseReleased() {
  update = false;
}
