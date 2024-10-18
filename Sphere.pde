class Sphere extends Object{

    
    float radius;


    Sphere( PVector center, float radius, float[][] phongColor) {
        super(center,phongColor);
        this.radius = radius;
    }

    PVector normalVector(PVector point) {
        return point.copy().sub(center).normalize();
    }


    void fill() {
        for (int i = 0; i < W; i++) {
            for (int j = 0; j < H; j++) {

                PVector point = rasterPoint(i,j);

                int index = i+j * W;       
                float t = getParametricT(point);
                if ( t > 0) {
                    PVector D = point.sub(EYE).normalize();
                    PVector newPoint = super.pointOnShape(t, D);
                    if (!isPixelTaken(newPoint, index)) {
                        PVector normalVector = normalVector(newPoint).normalize();
                        float[] colorToFill =objectColor(newPoint, normalVector);
                        color bruh = color(colorToFill[0], colorToFill[1], colorToFill[2]);
                        buffer.pixels[index] = bruh;
                        // println("filling circle");
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
        

        PVector D = point.sub(EYE).normalize();
        PVector F = EYE.copy().sub(center);

        float bQuad = 2* (D.dot(F));
        float cQuad = F.magSq() - (radius*radius);
        float[] result = solveQuadratic(1,bQuad,cQuad);
        float t  =  -1;
        if ( result != null) { 
            if ( 0 < result[0] && result[0] < result[1]) {
                t = result[0];
            }
        }
        return t;
    }

    // float getParametricT(PVector point) {
    //     PVector D = point.sub(EYE).normalize();  // Ray direction
    //     PVector F = EYE.copy().sub(center);  // Vector from eye to center of sphere

    //     // Coefficients for the quadratic equation
    //     float bQuad = 2 * D.dot(F);
    //     float cQuad = F.magSq() - (radius * radius);
        
    //     float[] result = solveQuadratic(1, bQuad, cQuad);
    //     float t = -1;

    //     // If valid roots exist
    //     if (result != null) {
    //         // We select the smallest positive root
    //         if (result[0] > 0 && result[1] > 0) {
    //             t = Math.min(result[0], result[1]);
    //         } else if (result[0] > 0) {
    //             t = result[0];  // Only the first root is positive
    //         } else if (result[1] > 0) {
    //             t = result[1];  // Only the second root is positive
    //         }
    //     }

    //     return t;  // Return the smallest positive t, or -1 if no valid t
    // }


}