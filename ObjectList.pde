class ObjectList {


    ArrayList<Object> shapeList;

    ObjectList() {
        this.shapeList = new ArrayList<Object>();
    }

    void add(Object shape) {
        shapeList.add(shape);
    }


    // float checkCollison(PVector point) {



    //     Object shape = shapeList.get(0);
    //     float distance = shape.eyeFromPointDistance(point);

    //     int i = 1;
    //     while(i < shapeList.size() ) {
    //         float newDistance = shapeList.get(i).eyeFromPointDistance(point);

    //         if ( distance > newDistance) {
    //             distance = newDistance;
                
    //         }
    //         i++;
    //     }

    //     return distance;

    // }



    float checkCollision(PVector point) {
        float distance = Float.MAX_VALUE;  // Initialize with a large value

        for (int i = 0; i < shapeList.size(); i++) {
            float newDistance = shapeList.get(i).eyeFromPointDistance(point);

            if ( newDistance < distance) {
                distance = newDistance;
            }

        }
        return distance;
    }



    void fill() {
        for(Object shape : shapeList) {
            shape.fill();
        }

    }



}