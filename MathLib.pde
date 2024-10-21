/**
 * Converts raster (pixel) coordinates to a point in 3D space.
 *
 * @param i The horizontal pixel coordinate.
 * @param j The vertical pixel coordinate.
 * @return PVector representing the point in 3D space .
 */
PVector rasterPoint(int i, int j) {

    // Calculate the x-coordinate in 3D space
    float x = (float)L + (((float)R - (float)L) / (float)W) * ((float)i + 0.5f);
    // Calculate the y-coordinate in 3D space
    float y = (float)B + (((float)T - (float)B) / (float)H) * ((float)j + 0.5f);
    // Return the point with the calculated x, y, and constant z-coordinate N
    return new PVector(x, y, N);
}

/**
 * Solves the quadratic equation 
 *
 * @param a The quadratic coefficient.
 * @param b The linear coefficient.
 * @param c The constant term.
 * @return An array containing the two roots.
 */
float[] solveQuadratic(float a, float b, float c) {

    
    float discriminant = b * b - 4 * a * c;
    
    if (discriminant < 0) {
        return null;
    }

    float root1 = (-b - sqrt(discriminant)) / (2 * a);
    float root2 = (-b + sqrt(discriminant)) / (2 * a);

    return new float[] { root1, root2 };
}

/**
 * Computes the normalized direction vector from the eye to a given point.
 *
 * @param point The target point in 3D space.
 * @return A normalized PVector to the direction from the eye to the point.
 */
PVector getDirectionVector(PVector point) {
    return PVector.sub(point.copy(), EYE.copy()).normalize();
}

/**
 * Computes the normalized direction vector from the light source to a given point.
 *
 * @param point The target point in 3D space.
 * @return PVector of light to the point.
 */
PVector getLightDirectionVector(PVector point) {
    return PVector.sub(point.copy(), LIGHT.copy()).normalize();
}

/**
 * Computes the normalized reflection direction vector at a point given the normal vector.
 *
 * @param point  The point of reflection in 3D space.
 * @param normal The normal vector at the point of reflection.
 * @return PVector of the reflection direction.
 */
PVector getReflectDirectionVector(PVector point, PVector normal) {
    return PVector.sub(point.copy(), normal.copy()).normalize();
}

/**
 * Calculates the reflection of an incoming vector off a surface with a given normal vector.
 *
 * @param incomingVector The incoming (incident) vector.
 * @param normalVector   The normal vector of the surface at the point of reflection.
 * @return A PVector representing the reflected vector.
 */
PVector reflectVector(PVector incomingVector, PVector normalVector) {
    
    // Calculate the projection of the incoming vector onto the normal vector
    PVector projection = PVector.mult(normalVector, incomingVector.dot(normalVector));
    // Calculate the reflected vector using the reflection formula
    PVector reflectedVec = PVector.sub(PVector.mult(projection, 2), incomingVector);
    
    return reflectedVec;
}

