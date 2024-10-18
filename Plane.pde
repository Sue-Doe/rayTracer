class Plane extends Object {

    PVector normal;

    Plane(PVector center, PVector normal, float[][] phongColor) {
        super(center, phongColor);
        this.normal = normal;
    }

   void fill() {

        for (int i = 0; i < W; i++) {
            for (int j = 0; j < H; j++) {
                
                PVector point = rasterPoint(i, j);
                PVector D = PVector.sub(point, EYE).normalize();
            
                float t = getParametricT(point);
                if (t > 0) {
                    PVector newPoint = super.pointOnShape(t,D);

                    int index = i+j * W;       
                    if ( !isPixelTaken(newPoint, index)) {
                        float[] colorToFill = objectColor(newPoint,normal);
                        color toFill = color(colorToFill[0], colorToFill[1], colorToFill[2]);
                        buffer.pixels[index] = toFill;
                    }
                }
            }
        }
    }
   


    float getParametricT(PVector point) {
        PVector D = PVector.sub(point,EYE).normalize();
        float denom = normal.dot(D);

        float t = -1;
        if (abs(denom) > 1e-6) {
             t = normal.dot(PVector.sub(center.copy(), EYE)) / denom;
        }
        return t;
    }




    float findZvaluePointShape(float x, float y) {
        float xValue = normal.x * (x-center.x);
        float yValue = normal.y * (y-center.y);
        float result = 0;

        if ( normal.z != 0) {
            result =  center.z - (xValue - yValue) / center.z;
        } else {
            result = center.z;
        }
        // println(result);
        return result;
    }

}