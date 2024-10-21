/**
 * Represents a Cylinder shape
 */
class Cylinder extends Shape {
    float radius;
    float height;

    /**
     * Constructs a Cylinder object with a center point, radius, height, and Phong color parameters.
     *
     * @param center     The center position of the cylinder.
     * @param radius     The radius of the cylinder.
     * @param height     The height of the cylinder.
     * @param phongColor The Phong color for the cylinder.
     */
    Cylinder(PVector center, float radius, float height, float[][] phongColor) {
        super(center, phongColor);
        this.radius = radius;
        this.height = height;
    }

    /**
     * Computes the normal vector at a given point on the cylinder's surface.
     *
     * @param point The point on the cylinder.
     * @return The normal vector at the given point.
     */
    PVector normalVector(PVector point) {
        PVector normal = new PVector(point.x - center.x , 0, point.z - center.z );
        normal.normalize();
        return normal.copy();
    }

    /**
     * Calculates the ray length from a source point in a given direction to the cylinder.
     *
     * @param direction The direction vector of the ray.
     * @param source    The starting point of the ray.
     * @return The distance to the intersection point along the ray
     */
    float getRayLength(PVector direction, PVector source) {

        float heightMin = center.y - height / 2.0f;
        float heightMax = center.y + height / 2.0f;

        PVector D = direction;

        PVector F = source.copy().sub(center.copy());

        float aQuad = D.x * D.x + D.z * D.z;
        float bQuad = 2 * (F.x * D.x + F.z * D.z);
        float cQuad = F.x * F.x + F.z * F.z - (radius * radius);
        
        float[] result = solveQuadratic(aQuad, bQuad, cQuad);
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
