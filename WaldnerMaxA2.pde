PGraphics buffer;
ShapeList shapes = new ShapeList();



//steps up buffer and calls draw
void setup() {
    colorMode(RGB, 1.0f);

    buffer = createGraphics(800,800);

    draw();

}

//setting canvas size
void settings() {
    size(800,800);
}

//draws everything
void draw()  {

    buffer.beginDraw();
    buffer.colorMode(RGB, 1.0f);
    buffer.background(BLACK);
    buffer.loadPixels();

    float radius = 50;
    Shape sphereGreen = new Sphere(new PVector(-10, 10, 30), radius/10, PHONG_COLORS_GREEN);
    Shape sphereGreenTwo = new Sphere(new PVector(20, -10, 90), radius/5, PHONG_COLORS_GREEN);

    Shape sphereMirror = new SphereMirror(new PVector(0, -10, 50), radius/6, null);

    Shape cylinder = new Cylinder(new PVector(-10,0,30), 5, 10, PHONG_COLORS);    
    Shape hyperboloid = new Hyperboloid(new PVector(10,10,30), radius/10, 10, PHONG_COLORS);


    Shape plane = new Plane(new PVector(1,200,2030), new PVector(0,1,0), PHONG_COLORS_RED);

    shapes.addShape(plane);
    shapes.addShape(sphereMirror);
    shapes.addShape(sphereGreen);
    shapes.addShape(sphereGreenTwo);
    shapes.addShape(cylinder);
    shapes.addShape(hyperboloid);

    shapes.fill();

    buffer.updatePixels();
    buffer.endDraw();
    image(buffer, 0, 0); 

}