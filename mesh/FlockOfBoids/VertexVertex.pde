public class VertexVertex{
    List<Vector> vertexList;

    public VertexVertex(List<Vector> vertexList) {
        this.vertexList = vertexList;
    }

    public void renderMesh(String renderMode){
        if(renderMode == "Immediate"){
            beginShape(TRIANGLE_STRIP);
                vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                //System.out.println("immediate vertex vertex");
            endShape();
        }
        else {
            if (renderMode == "Retained") {
                beginShape(TRIANGLE_STRIP);
                    vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                    vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                    vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                    vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                    vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                    vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                    System.out.println("retained vertex vertex");
                endShape();
            }
        }


    }


}