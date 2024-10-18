class ObjectList {


    ArrayList<Object> shapeList;

    ObjectList() {
        this.shapeList = new ArrayList<Object>();
    }

    void add(Object shape) {
        shapeList.add(shape);
    }


    // boolean checkCollison(PVector D, float t) {

    //     for(Object shape : shapeList) {
    //         shape.pointOnShape(t, D);

    //     }
    // }

    void fill() {
        for(Object shape : shapeList) {
            shape.fill();
        }

    }



}