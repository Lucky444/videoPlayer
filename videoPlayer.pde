//Video Information
ArrayList<JSONArray> frames = new ArrayList<JSONArray>();

int framecount = 0;
int w = 0;
int h = 0;

float f = 0;

//System Information
boolean loaded = false;
boolean playing = false;
int pixelsize = 150;

void setup(){ 
  size(1080,1080); 
  
  //Text 1
  background(0);
  textAlign(CENTER);
  textSize(25);
  text("Please wait, loading Data ...", width/2, height/2);
  
  //Loading
  JSONArray values = loadJSONArray("data.json");
  framecount = values.size();
  
  for(int i = 0; i < values.size(); i++){
      JSONArray lines = values.getJSONArray(i);
      frames.add(lines);
  }
  
  h = frames.get(0).size();
  w = frames.get(0).getJSONArray(0).size();
  
  pixelsize = height / h;
  
  //Text 2
  background(0);
  text("Data Loaded", width/2, height/2);
  text("press any button to start video", width/2, height/2+25); 
  noStroke();
  loaded = true;
}

void draw(){
  if(keyPressed && !playing && loaded){playing = true;}
   
  if(playing){
     
  noStroke();
  fill(0);
  background(0);
     
  for(int y = 0; y < h; y ++){
   
    JSONArray line = frames.get(int(f)).getJSONArray(y);
   
    for(int x = 0; x < w; x ++){
      color c = color(0);
      if(line.get(x).toString().equals("1")){c = color(255);}
      fill(c);
      rect(x*pixelsize,y*pixelsize,pixelsize,pixelsize);
      }
    }
    
  f++;
  if(f >= framecount){exit(); stop();}
  
  fill(100);
  rect(0,h * pixelsize, w * pixelsize, pixelsize);
  fill(200);
  
  float progressValue = (f / framecount) * (w * pixelsize);
  
  rect(0,h * pixelsize, progressValue, pixelsize);
  noStroke();
  }
}
