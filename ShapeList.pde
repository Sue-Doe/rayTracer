/**
 * Manages a collection of shapes for collision and shadow detection.
 */
class ShapeList {

    ArrayList<Shape> shapes = new ArrayList<Shape>();  // List to hold shapes

    /**
     * constructor 
     */
    ShapeList() {}

    /**
     * Adds a shape to the collection.
     *
     * @param shape The shape to be added.
     */
    void addShape(Shape shape) {
        shapes.add(shape);
    }

    /**
     * Checks for collisions with a point in the scene.
     *
     * @param point The point to check for collisions.
     * @return The closest intersection distance, or MAX_VALUE if no collision .
     */
    float checkColloisions(PVector point) {
        float compareT = Float.MAX_VALUE;  

        for (Shape shape : shapes) {
            float newT = shape.getRayLength(point);  

            
            if (newT > 0 && newT < compareT) {
                compareT = newT; 
            }
        }
        return compareT;  
    }

    /**
     * Checks for shadow collisions with a point in the scene.
     *
     * @param point The point to check for shadow collisions.
     * @return The closest shadow intersection distance, or Float.MAX_VALUE if no shadow is detected.
     */
    float checkShadowColloisions(PVector point) {
        float compareT = Float.MAX_VALUE;  

        for (Shape shape : shapes) {
            float newT = shape.getShadowRayLength(point);  

            
            if (newT > 0 && newT < compareT) {
                compareT = newT; 
            }
        }
        return compareT;  
    }

    /**
     * Fills all shapes in the collection.
     */
    void fill() {
        for (Shape shape : shapes) {
            shape.fill();  
        }
    }
}
