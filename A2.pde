PGraphics buffer;
final color BLACK = color(0);
color stateColor = color(255, 0, 0);

final int N = 16;
final int L = -10;
final int R = 10;
final int B = -10;
final int T = 10;
final int W = 800;
final int H = 800;


PVector EYE = new PVector(0, 0, 0); 

PVector LIGHT = new PVector(100, 100, -100); 
ObjectList shapes = new ObjectList();
void setup() {
    colorMode(RGB, 1.0f);

    buffer = createGraphics(800,800);

    draw();

}

void settings() {
    size(800,800);
}

void draw()  {

    buffer.beginDraw();
    buffer.colorMode(RGB, 1.0f);
    buffer.background(BLACK);

    buffer.loadPixels();


    
    float radius = 50;
    Object sphereGreen = new Sphere(new PVector(-45, 50, 150), radius/2,PHONG_COLORS_GREEN);
    Object sphereBlue = new Sphere(new PVector(45, 50, 120), radius/2, PHONG_COLORS);
    Object plane = new Plane(new PVector(1,1,2000), new PVector(0,1,0), PHONG_COLORS_GREEN);
    Object cylinder = new Cylinder(new PVector(0,0,100), 10, 40, PHONG_COLORS);    

    
    shapes.add(sphereGreen);
    shapes.add(sphereBlue);
    shapes.add(plane);
    shapes.add(cylinder);

    shapes.fill();


    buffer.updatePixels();
    buffer.endDraw();
    image(buffer, 0, 0); 

}
// useful constants
final int NUM_DIMENSIONS = 3;

// when you store (r,g,b) values in an array,
// USE THESE NAMED CONSTANTS to access the entries

final int NUM_COLOR_CHANNELS = 3;

// when you store (ambient,diffuse,specular) values in an array,
// USE THESE NAMED CONSTANTS to access the entries
final int A = 0;
final int D = 1;
final int S = 2;
final int NUM_LIGHT_COMPONENTS = 3;

// colors for drawing and filling triangles
final float[] OUTLINE_COLOR = {1.0f, 0.3f, .1f};
final float[] FLAT_FILL_COLOR = {1f, 1f, 1f};
final float[][] PHONG_COLORS = {{0.15f, 0.65f, 1f}, {0.15f, 0.65f, 1f}, {0.08f, 0.08f, 0.08f}} ; // A, D, S colors
final float[][] PHONG_COLORS_GREEN = {
    {0.15f, 1f, 0.15f},  // Ambient color (A) - greenish tint
    {0.15f, 1f, 0.15f},  // Diffuse color (D) - greenish tint
    {0.08f, 0.08f, 0.08f}         // Specular color (S) - white
};

final float[] MATERIAL = {0.4, 0.5, 0.5}; // A, D, S
final float PHONG_SHININESS = 100; // exponent

final float SPECULAR_CUTOFF = 0.01;
final float SPECULAR_FLOOR = (float)Math.pow(SPECULAR_CUTOFF, 1/PHONG_SHININESS);

float[] phong(PVector p, PVector n, PVector eye, PVector light, float[] material, float[][] fillColor,
        float shininess) {

    PVector Lvector = PVector.sub(light, p).normalize();
    PVector Rvector = reflectVector(Lvector, n);
    PVector V = PVector.sub(eye, p).normalize();

    float[] phongColor = new float[NUM_COLOR_CHANNELS];

    for (int i = 0; i < phongColor.length; i++) {

        float ambientLight = fillColor[A][i] * material[A];

        float diffuseLight = 0;
        if (Lvector.dot(n) > 0) {
            diffuseLight = (Lvector.dot(n)) * fillColor[D][i] * material[D];
        }

        float specularLight = 0;
        if (Rvector.dot(V) > SPECULAR_FLOOR) {
            if (Rvector.dot(V) > 0) {
                specularLight = pow(Rvector.dot(V), shininess) * fillColor[S][i] * material[S];
            }
        }
                // println("Ambient: " + ambientLight + " Diffuse: " + diffuseLight + " Specular: " + specularLight);

        phongColor[i] = ambientLight + diffuseLight + specularLight;
    }

    return phongColor;
}