// helped by http://warp.povusers.org/Mandelbrot/

// some basic setup
float minreal = -2.0,
      maxreal =  1.0,
      minimag = -1.2,
      maximag =  1.2;

int w = 800,
    h = int(w * (maximag-minimag) / (maxreal-minreal));

// if you're just drawing a static image (no animation)
// you just need setup()
void setup() {
  size(w, h);

  // center the origin (0, 0) at the center of our canvas
  translate(w/2, h/2);

  // load the pixels of our canvas
  loadPixels();

  float realfactor = (maxreal-minreal) / (width-1),
        imagfactor = (maximag-minimag) / (height-1);
  int N = 50;

  // loop over the point at the center of every pixel
  for (int y = 0; y < height; y++) {  // rows
    for (int x = 0; x < width; x++) { // columns
      // calculate complex number c for this point, real and imaginary parts
      float creal = minreal + x * realfactor,
            cimag = maximag - y * imagfactor;

      // start our sequence z at our point c
      float zreal = creal,
            zimag = cimag;

      // test if distance of sequence from the origin is ever larger than 2
      // (if so, the sequence z will diverge)
      boolean inset = true;
      for (int n = 0; n < N; n++) {
        float zreal2 = zreal*zreal,
              zimag2 = zimag*zimag;

        // this is the same as testing
        // sqrt(zreal2 + zimag2) > 2
        if (zreal2 + zimag2 > 4) {
          inset = false;
          break;
        }
        
        // iterate forward to z_n+1
        zimag = 2*zreal*zimag + cimag;
        zreal = zreal2 - zimag2 + creal;
      }

      if (inset) {
        pixels[x + width*y] = color(0);
      } else {
        pixels[x + width*y] = color(255);
      }
    }
  }

  // update the pixels on the screen
  updatePixels();

  save("mandelbrot.png");
}
