



PVector rasterPoint(int i, int j) {
    // Interpolate x and y coordinates based on raster dimensions
    float x = (float)L + (( (float)R - (float)L) / (float) W) * ((float)i + 0.5); // Map i to x-coordinate
    float y = (float)B + (((float)T - (float)B) / (float) H) * ((float)j + 0.5); // Map j to y-coordinate
    return new PVector(x, y, N);  // Return 3D point on raster at z = N
}

PVector ray(float t, PVector point) {

    PVector D = point.copy().sub(EYE);
    D.normalize();
    D.mult(t);
    PVector rayVector = EYE.copy().add(D);
    return rayVector;
}

float[] solveQuadratic(float a, float b, float c) {

    float discriminant = b * b - 4 * a * c;


    if (discriminant < 0) {
        return null;  
    }
    
    
    float root1 = (-b - sqrt(discriminant)) / (2 * a);
    float root2 = (-b + sqrt(discriminant)) / (2 * a);


    return new float[] { root1, root2 };
}

PVector reflectVector(PVector incomingVector, PVector normalVector) {
    
    PVector projection = PVector.mult(normalVector, incomingVector.dot(normalVector));
    PVector reflectedVec = PVector.sub(PVector.mult(projection, 2), incomingVector);
    
    return reflectedVec;
}
