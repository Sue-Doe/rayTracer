/**
 * Represents a Plane.
 */
class Plane extends Shape {

    PVector normal;

    /**
     * Constructor
     *
     * @param center     The center position of the plane.
     * @param normal     The normal vector of the plane.
     * @param phongColor The Phong color for the plane.
     */
    Plane(PVector center, PVector normal, float[][] phongColor) {
        super(center, phongColor);
        this.normal = normal.copy().normalize();
    }

    /**
     * Computes the normal vector at a given point on the plane.
     *
     * @param point The point on the plane.
     * @return The normal vector of the plane (constant for a plane).
     */
    PVector normalVector(PVector point) {
        return normal.copy();
    }

    /**
     * Calculates the ray length from a source point in a given direction to the plane.
     *
     * @param direction The direction vector of the ray.
     * @param source    The starting point of the ray.
     * @return The distance to the intersection point along the ray.
     */
    float getRayLength(PVector direction, PVector source) {
        PVector D = direction;
        PVector F = source.copy().sub(center);

        
        float top = -1 * (normal.x * F.x + normal.y * F.y + normal.z * F.z);
        float bottom = normal.x * D.x + normal.y * D.y + normal.z * D.z;

        if (bottom == 0) {
            return Float.MAX_VALUE;
        }

        float t = top / bottom;

        return t;
    }


}
