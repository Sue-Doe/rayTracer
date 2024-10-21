final color BLACK = color(0);
final color WHITE = color(255);
color stateColor = color(255, 0, 0);

final int N = 16;
final int L = -10;
final int R = 10;
final int B = -10;
final int T = 10;
final int W = 800;
final int H = 800;


PVector EYE = new PVector(0, 0, 0); 
PVector LIGHT = new PVector(10, 0, -50); 

final int A = 0;
final int D = 1;
final int S = 2;
final int NUM_COLOR_CHANNELS = 3;

final float[][] PHONG_COLORS = 
    {{0.15f, 0.65f, 1f}, 
    {0.15f, 0.65f, 1f}, 
    {0.08f, 0.08f, 0.08f}} ; 
    
final float[][] PHONG_COLORS_GREEN = {
    {0.15f, 1f, 0.15f},  
    {0.15f, 1f, 0.15f},  
    {0.08f, 0.08f, 0.08f}     
};
final float[][] PHONG_COLORS_RED = {
    {1f, 0.15f, 0.15f},  
    {1f, 0.15f, 0.15f},  
    {0.08f, 0.08f, 0.08f} 
};

final float[] MATERIAL = {0.4, 0.5, 0.5}; // A, D, S
final float PHONG_SHININESS = 100; // exponent

final float SPECULAR_CUTOFF = 0.01;
final float SPECULAR_FLOOR = (float)Math.pow(SPECULAR_CUTOFF, 1/PHONG_SHININESS);
