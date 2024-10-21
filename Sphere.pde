/**
 * Represents a sphere.
 */
class Sphere extends Shape {

    float radius;  // The radius of the sphere

    /**
     * Constructor for the Sphere class.
     *
     * @param center The center position of the sphere as a PVector.
     * @param radius The radius of the sphere.
     * @param phongColor The color properties for the sphere.
     */
    Sphere(PVector center, float radius, float[][] phongColor) {
        super(center, phongColor);
        this.radius = radius;
    }

    /**
     * Computes the normal vector at a given point on the sphere.
     *
     * @param point The point at which to calculate the normal.
     * @return The normal vector as a PVector.
     */
    PVector normalVector(PVector point) {
        return point.copy().sub(center.copy()).normalize();
    }

    // /**
    //  * Gets the ray length from the eye to a point on the sphere.
    //  *
    //  * @param point The point on the sphere.
    //  * @return The distance to the intersection point.
    //  */
    // float getRayLength(PVector point) {
    //     return getRayLength(getDirectionVector(point), EYE);
    // }

    // /**
    //  * Gets the shadow ray length from the light to a point on the sphere.
    //  *
    //  * @param point The point on the sphere.
    //  * @return The distance to the intersection point for shadow calculations.
    //  */
    // float getShadowRayLength(PVector point) {
    //     return getRayLength(getLightDirectionVector(point), LIGHT);
    // }

    // /**
    //  * Gets the reflected ray length at a given point using the normal vector.
    //  *
    //  * @param point The point on the sphere.
    //  * @param normal The normal vector at the point.
    //  * @return The distance to the reflection intersection point.
    //  */
    // float getReflectRayLength(PVector point, PVector normal) {
    //     return getRayLength(normal.copy(), point.copy());
    // }

    /**
     * Calculates the ray length for a given direction from a source.
     *
     * @param direction The direction of the ray as a PVector.
     * @param source The starting point of the ray as a PVector.
     * @return The distance to the intersection point, or -1 if no intersection.
     */
    float getRayLength(PVector direction, PVector source) {
        PVector D = direction;
        PVector F = source.copy().sub(center.copy());

        float bQuad = 2 * (D.dot(F));
        float cQuad = F.magSq() - (radius * radius);
        float[] result = solveQuadratic(1, bQuad, cQuad);
        float t = -1;

        if (result != null) { 
            // Check the first root for valid intersection
            if (0 < result[0] && result[0] < result[1]) {
                t = result[0];
            }
        }

        return t;
    }
}
