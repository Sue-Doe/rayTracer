abstract class Object {


    PVector center;
    float[][] phongColor;
    Object(PVector center, float[][] phongColor) {
        this.center = center;
        this.phongColor = phongColor;
    }


    abstract void fill();

    PVector pointOnShape(float t, PVector D) {
        return EYE.copy().add(D.mult(t));
    }



    float eyeFromPointDistance(PVector point) {
        return findZvaluePointShape(point.x,point.y);
    }

    // boolean isPixelTaken(PVector point, int index) {
    //     boolean taken = buffer.pixels[index] != BLACK;

    //     if (taken) {
    //         float currDistance  = eyeFromPointDistance(point);
    //         if ( currDistance <= shapes.checkCollison(point)) {
    //             taken = false;
    //         }
    //     }
    //     return taken;
    // }

    boolean isPixelTaken(PVector point, int index) {
        boolean taken = buffer.pixels[index] != BLACK;

        if (taken) {
            float currDistance = eyeFromPointDistance(point);
            float collisionDistance = shapes.checkCollision(point);
        
            if (currDistance <= collisionDistance) {
                taken = false;  
                // print("bruh");
            }
        }
        return taken;
    }



    abstract float findZvaluePointShape(float x, float y);

    float[] objectColor(PVector point, PVector normalVector) {
        return phong(point, normalVector, EYE, LIGHT, MATERIAL, this.phongColor, PHONG_SHININESS);
    }


    abstract float getParametricT(PVector point);






}