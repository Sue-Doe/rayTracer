/**
 * Represents a hyperboloid shape
 */
class Hyperboloid extends Shape {

    float radius;  // The radius of the hyperboloid
    float height;  // The height of the hyperboloid

    /**
     * Constructor .
     *
     * @param center The center position of the hyperboloid as a PVector.
     * @param radius The radius of the hyperboloid.
     * @param height The height of the hyperboloid.
     * @param phongColor The color properties for the hyperboloid.
     */
    Hyperboloid(PVector center, float radius, float height, float[][] phongColor) {
        super(center, phongColor);
        this.radius = radius;
        this.height = height;
    }

    /**
     * Computes the normal vector at a given point on the hyperboloid.
     *
     * @param point The point at which to calculate the normal.
     * @return The normal vector as a PVector.
     */
    PVector normalVector(PVector point) {
        PVector normal = new PVector(point.x - center.x , point.y + center.y, point.z - center.z );
        normal.normalize();
        return normal.copy();
    }

    /**
     * Gets the ray length from the eye to a point on the hyperboloid.
     *
     * @param point The point on the hyperboloid.
     * @return The distance to the intersection point.
     */
    float getRayLength(PVector point) {
        return getRayLength(getDirectionVector(point), EYE);
    }

    /**
     * Gets the shadow ray length from the light to a point on the hyperboloid.
     *
     * @param point The point on the hyperboloid.
     * @return The distance to the intersection point for shadow calculations.
     */
    float getShadowRayLength(PVector point) {
        return getRayLength(getDirectionVector(point), LIGHT);
    }

    /**
     * Gets the reflected ray length at a given point using the normal vector.
     *
     * @param point The point on the hyperboloid.
     * @param normal The normal vector at the point.
     * @return The distance to the reflection intersection point.
     */
    float getReflectRayLength(PVector point, PVector normal) {
        return getRayLength(normal.copy(), point.copy());
    }

    /**
     * Calculates the ray length for a given direction from a source.
     *
     * @param direction The direction of the ray as a PVector.
     * @param source The starting point of the ray as a PVector.
     * @return The distance to the intersection point, or -1 if no intersection.
     */
    float getRayLength(PVector direction, PVector source) {
        float heightMin = center.y - height / 2.0;
        float heightMax = center.y + height / 2.0;

        PVector D = direction.copy(); 
        PVector F = source.copy().sub(center);

        float a = D.x * D.x - D.y * D.y + D.z * D.z;
        float b = 2 * (F.x * D.x - F.y * D.y + F.z * D.z);
        float c = (F.x * F.x - F.y * F.y + F.z * F.z) - radius * radius;

        float[] result = solveQuadratic(a, b, c);
        float t = -1;

        if (result != null) {
            int i = 0;
            boolean found = false;
            while (result.length > i && !found) {
                PVector intersectionPoint = source.copy().add(D.copy().mult(result[i]));
                float yValue = intersectionPoint.y;

                if (yValue >= heightMin && yValue <= heightMax) {
                    t = result[i];
                    found = true;
                }
                i++;
            }
        }
        return t; 
    }
}
