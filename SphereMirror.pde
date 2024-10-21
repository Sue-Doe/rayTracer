/**
 * Represents a spherical mirror.
 */
class SphereMirror extends Sphere {

    /**
     * Constructor for the SphereMirror 
     *
     * @param center The center  of the sphere .
     * @param radius The radius of the sphere .
     * @param phongColor The color  for the sphere mirror.
     */
    SphereMirror(PVector center, float radius, float[][] phongColor) {
        super(center, radius, phongColor);
    }

    /**
     * Fills the mirror by checking for collisions and applying the mirror color.
     */
    void fill() {
        for (int i = 0; i < W; i++) {
            for (int j = 0; j < H; j++) {
                PVector point = rasterPoint(i, j);
                int index = i + j * W; 

                PVector intPoint = intersectionPoint(point.copy()); 
                if (intPoint != null) {
                    if (didNotCollide(intPoint.copy())) {
                        if (didNotCollideShadow(intPoint.copy())) {
                            buffer.pixels[index] = mirrorColor(intPoint.copy());
                        } else {
                            fillShadowPixel(intPoint, index); 
                        }
                    }
                }
            }
        }
    }

    /**
     * Checks for reflection collisions with other shapes and returns the color
     *
     * @param point The point to check for reflection collisions.
     * @return An array color from the closest shape that reflects light to the point
     */
    float[] didNotCollideReflection(PVector point) {
        float minT = Float.MAX_VALUE; 
        float[] colorOtherShape = null;
        for (Shape shape : shapes.shapes) {
            if (shape != this) { 
                float currDistance = shape.getReflectRayLength(point, normalVector(point)); 
                if (minT > currDistance && currDistance > 0) { 
                    minT = currDistance; 
                    colorOtherShape = shape.objectColor(point); 
                }
            }
        }
        return colorOtherShape; 
    }

    /**
     * Determines the color to fill the mirror at a given point based on reflection.
     *
     * @param point The point on the mirror.
     * @return The color to fill at the point
     */
    color mirrorColor(PVector point) {
        float[] colorToFill = didNotCollideReflection(point); 

        if (colorToFill == null) {
            return BLACK;  
        }
        color colorInt = color(colorToFill[0], colorToFill[1], colorToFill[2]); 
        return colorInt;  
    }

    /**
     * Calculates the length of the reflected ray from a point given a normal vector.
     *
     * @param point The point from which to calculate the reflection.
     * @param normal The normal vector at the point.
     * @return The distance to the reflection intersection point
     */
    float getReflectRayLength(PVector point, PVector normal) {
        PVector D = normal; 
        PVector F = point.copy().sub(center.copy()); 

        float bQuad = 2 * (D.dot(F)); 
        float cQuad = F.magSq() - (radius * radius); 
        float[] result = solveQuadratic(1, bQuad, cQuad); 
        float t = -1; 

        if (result != null) {
    
            if (0 < result[0] && result[0] < result[1]) {
                t = result[0]; 
            }
        }
        return t; 
    }
}
