/**
 * Represents a Shape.
 */
abstract class Shape {

    PVector center;
    float[][] phongColor;

    /**
     * Constructor
     *
     * @param center     The center position of the shape.
     * @param phongColor The Phong color parameters for the shape.
     */
    Shape(PVector center, float[][] phongColor) {
        this.center = center;
        this.phongColor = phongColor;
    }

    /**
     * Fills the shape by iterating over each pixel and determining if it should be colored
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
                            fillPixel(intPoint, index);
                        } else {
                            fillShadowPixel(intPoint, index);
                        }
                    }
                }
            }
        }
    }

    /**
     * Computes the normal vector at a given point on the shape.
     *
     * @param point The point on the shape.
     * @return The normal vector at the given point.
     */
    abstract PVector normalVector(PVector point);

    /**
     * Calculates the ray length from a source point in a given direction to the shape.
     *
     * @param direction The direction vector of the ray.
     * @param source    The starting point of the ray.
     * @return The distance to the intersection point along the ray.
     */
    abstract float getRayLength(PVector direction, PVector source);

    /**
     * Gets the ray length from the eye to a point on the shape.
     *
     * @param point The point on the shape.
     * @return The distance to the intersection point.
     */
    float getRayLength(PVector point) {
        return getRayLength(getDirectionVector(point), EYE);
    }

    /**
     * Gets the shadow ray length from the light to a point on the shape.
     *
     * @param point The point on the shape.
     * @return The distance to the intersection point for shadow calculations.
     */
    float getShadowRayLength(PVector point) {
        return getRayLength(getDirectionVector(point), LIGHT);
    }

    /**
     * Gets the reflected ray length at a given point using the normal vector.
     *
     * @param point  The point on the shape.
     * @param normal The normal vector at the point.
     * @return The distance to the reflection intersection point.
     */
    float getReflectRayLength(PVector point, PVector normal) {
        return getRayLength(normal.copy(), point.copy());
    }

    /**
     * Calculates the intersection point of a ray from the eye through a given point with the shape.
     *
     * @param point The point through which the ray is cast.
     * @return The intersection point with the shape
     */
    PVector intersectionPoint(PVector point) {
        float t = getRayLength(point);
        PVector D = getDirectionVector(point);

        PVector newPoint = null;

        if (t > 0) {
            newPoint = EYE.copy().add(D.mult(t));
        }
        return newPoint;
    }

    /**
     * Calculates the color of the object at a given point using the Phong illumination model.
     *
     * @param point The point on the object's surface.
     * @return An array representing the RGB color 
     */
    float[] objectColor(PVector point) {
        return phong(point, normalVector(point), EYE, LIGHT, MATERIAL, this.phongColor, PHONG_SHININESS);
    }

    /**
     * Calculates the color of the object in shadow at a given point using the Phong model.
     *
     * @param point The point on the object's surface.
     * @return An array representing the RGB color  at the point in shadow
     */
    float[] objectShadowColor(PVector point) {
        if (this.phongColor != null) {
            return shadowPhong(point, normalVector(point), EYE, LIGHT, MATERIAL, this.phongColor, PHONG_SHININESS);
        } else {
            return null;
        }
    }

    /**
     * Fills a pixel in the buffer with the object's color at the intersection point.
     *
     * @param intPoint The intersection point on the object.
     * @param index    The index of the pixel in the buffer.
     */
    void fillPixel(PVector intPoint, int index) {
        float[] colorToFill = objectColor(intPoint);
        color colorInt = color(colorToFill[0], colorToFill[1], colorToFill[2]);
        buffer.pixels[index] = colorInt;
    }

    /**
     * Fills a pixel in the buffer with the object's shadow color at the intersection point.
     *
     * @param intPoint The intersection point on the object.
     * @param index    The index of the pixel in the buffer.
     */
    void fillShadowPixel(PVector intPoint, int index) {
        float[] colorToFill = objectShadowColor(intPoint);
        if (colorToFill != null) {
            color colorInt = color(colorToFill[0], colorToFill[1], colorToFill[2]);
            buffer.pixels[index] = colorInt;
        }
    }

    /**
     * Determines if there is no collision between the ray and other shapes before reaching this shape.
     *
     * @param point The point on the shape.
     * @return True if there is no collision
     */
    boolean didNotCollide(PVector point) {
        float minT = shapes.checkColloisions(point);
        float currT = getRayLength(point);
        return currT <= minT;
    }

    /**
     * Determines if there is no collision between the shadow ray and other shapes before reaching this shape.
     *
     * @param point The point on the shape.
     * @return True if there is no collision
     */
    boolean didNotCollideShadow(PVector point) {
        float minT = shapes.checkShadowColloisions(point);
        float currT = getShadowRayLength(point);
        return currT <= minT;
    }

}
