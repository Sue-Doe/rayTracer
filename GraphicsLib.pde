// draw a pixel at the given location
void setPixel(float x, float y) {
//   int index = indexFromXYCoord(x, y);
    int index = (int)x * (int)y;
  if (0 <= index && index < buffer.pixels.length) {
    buffer.pixels[index] = stateColor;
  } else {
    println("ERROR:  this pixel is not within the raster.");
  }
}

void setPixel(PVector p) {
  setPixel(p.x, p.y);
}

// helper functions for pixel calculations
int indexFromXYCoord(float x, float y) {
  int col = colNumFromXCoord(x);
  int row = rowNumFromYCoord(y);
  return indexFromColRow(col, row);
}

int indexFromColRow(int col, int row) {
  return row*width + col;
}

int colNumFromXCoord(float x) {
  return (int) (x + width/2);
}

int rowNumFromYCoord(float y) {
  return (int) (height/2 - y);
}
