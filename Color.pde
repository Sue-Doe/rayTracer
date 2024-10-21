/**
 * Calculates the color at a point  using the Phong model.
 * This method adjusts the lighting components to simulate a shadowed area.
 *
 * @return An array containing the RGB color
 */
float[] phong(PVector p, PVector n, PVector eye, PVector light, float[] material, float[][] fillColor,
        float shininess) {

    PVector Lvector = PVector.sub(light, p).normalize();
    PVector Rvector = reflectVector(Lvector, n);
    PVector V = PVector.sub(eye, p).normalize();

    float[] phongColor = new float[NUM_COLOR_CHANNELS];

    for (int i = 0; i < phongColor.length; i++) {

        float ambientLight = fillColor[A][i] * material[A];

        float diffuseLight = 0;
        if (Lvector.dot(n) > 0) {
            diffuseLight = (Lvector.dot(n)) * fillColor[D][i] * material[D];
        }

        float specularLight = 0;
        if (Rvector.dot(V) > SPECULAR_FLOOR) {
            if (Rvector.dot(V) > 0) {
                specularLight = pow(Rvector.dot(V), shininess) * fillColor[S][i] * material[S];
            }
        }
                // println("Ambient: " + ambientLight + " Diffuse: " + diffuseLight + " Specular: " + specularLight);

        phongColor[i] = ambientLight + diffuseLight + specularLight;
    }

    return phongColor;
}


/**
 * Calculates the color at a point in shadow using the Phong model.
 *
 * @return An array containing the RGB color
 */
float[] shadowPhong(PVector p, PVector n, PVector eye, PVector light, float[] material, float[][] fillColor,
        float shininess) {

    PVector Lvector = PVector.sub(light, p).normalize();
    PVector Rvector = reflectVector(Lvector, n);
    PVector V = PVector.sub(eye, p).normalize();

    float[] phongColor = new float[NUM_COLOR_CHANNELS];

    // Adjust darkening factors for each component if needed
    float ambientFactor = 0.5;  // Darken ambient component
    float diffuseFactor = 0.5;  // Darken diffuse component
    float specularFactor = 0.5; // Darken specular component

    for (int i = 0; i < phongColor.length; i++) {
        // Ambient light calculation (darkened by ambientFactor)
        float ambientLight = fillColor[A][i] * material[A] * ambientFactor;

        // Diffuse light calculation (darkened by diffuseFactor)
        float diffuseLight = 0;
        if (Lvector.dot(n) > 0) {
            diffuseLight = (Lvector.dot(n)) * fillColor[D][i] * material[D] * diffuseFactor;
        }

        // Specular light calculation (darkened by specularFactor)
        float specularLight = 0;
        if (Rvector.dot(V) > SPECULAR_FLOOR) {
            if (Rvector.dot(V) > 0) {
                specularLight = pow(Rvector.dot(V), shininess) * fillColor[S][i] * material[S] * specularFactor;
            }
        }

        // Combine all components
        phongColor[i] = ambientLight + diffuseLight + specularLight;
    }

    return phongColor;
}
