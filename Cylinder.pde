class Cylinder extends Object{

    float radius;
    float height;


    Cylinder(PVector center, float radius, float height ,float[][] phongColor) {
        super(center, phongColor);
        this.radius = radius;
        this.height = height;
    }

    PVector normalVector(PVector point) {
        return point.copy().sub(center).normalize();
    }



    void fill() {
        for (int i = 0; i < W; i++) {
            for (int j = 0; j< H; j++) {
                int index = i+j * W;
                PVector point = rasterPoint(i,j);
                float t = getParametricT(point);
                if ( t > 0 ) {
                    PVector D = point.sub(EYE).normalize();
                    PVector newPoint = super.pointOnShape(t, D);
                    if (!isPixelTaken(newPoint, index)) {
                        PVector normalVector = normalVector(newPoint).normalize();
                        float[] colorToFill =objectColor(newPoint, normalVector);
                        color bruh = color(colorToFill[0], colorToFill[1], colorToFill[2]);
                        buffer.pixels[index] = bruh;
                        
                    }   
                }
            }
        }
    }

    float findZvaluePointShape(float x, float y) {
        float zValue = Float.MAX_VALUE;

        float xValue = pow((x - center.x), 2);
        float yValue = pow((y - center.y), 2);

        float result = pow(( abs(pow(radius, 2) - xValue - yValue)),0.5) + center.z;
        

        
        float minZ = result - radius;
        float maxZ = result + radius;

        if( minZ == result ) {
            zValue = result;
        }
        
        return result;
    }





float getParametricT(PVector point) {
    
    float heightMin = center.y - height / 2.0;
    float heightMax = center.y + height / 2.0;

    
    PVector D = point.sub(EYE).normalize();
    
    PVector F = EYE.copy().sub(center);

    
    float aQuad = D.x * D.x + D.z * D.z;
    float bQuad = 2 * (F.x * D.x + F.z * D.z);
    float cQuad = F.x * F.x + F.z * F.z - (radius * radius);
    
    
    float[] result = solveQuadratic(aQuad, bQuad, cQuad);
    float t = -1;

    // Check if there are valid solutions
    if (result != null) {
        // Check both solutions to find the correct intersection point
        for (int i = 0; i < result.length; i++) {
            float possibleT = result[i];
            if (possibleT > 0) {
                // Compute the intersection point
                PVector intersectionPoint = EYE.copy().add(D.copy().mult(possibleT));
                float yValue = intersectionPoint.y;
                
                // Check if the y-coordinate is within the height bounds of the cylinder
                if (yValue >= heightMin && yValue <= heightMax) {
                    t = possibleT;
                    break; // We found a valid intersection
                }
            }
        }
    }

    return t; // Return the valid 't', or -1 if no valid intersection
}







}