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
                    if (isPixelTaken(index)) {
                        PVector normalVector = normalVector(newPoint).normalize();
                        float[] colorToFill =objectColor(newPoint, normalVector);
                        color bruh = color(colorToFill[0], colorToFill[1], colorToFill[2]);
                        buffer.pixels[index] = bruh;
                    }                
                }
            }
        }
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


}