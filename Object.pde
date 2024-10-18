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

    float distanceBetweenPoints(PVector pointOne, PVector pointTwo) {
        return pointOne.copy().sub(pointTwo).mag();
    }

    boolean isPixelTaken(int index) {
        return buffer.pixels[index] == BLACK;
    }


    float[] objectColor(PVector point, PVector normalVector) {
        return phong(point, normalVector, EYE, LIGHT, MATERIAL, this.phongColor, PHONG_SHININESS);
    }


    abstract float getParametricT(PVector point);








}