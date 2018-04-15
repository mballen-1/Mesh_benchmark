public class VertexVertex{
    List<Vector> vertexList;

    public VertexVertex(List<Vector> vertexList) {
        this.vertexList = vertexList;
    }

    public void renderMesh(String renderMode){
        if(renderMode == "Immediate"){
            beginShape(TRIANGLE_STRIP);
                vertex(vertexList.get(0));
                vertex(vertexList.get(1));
                vertex(vertexList.get(2));
                vertex(vertexList.get(0));
                vertex(vertexList.get(1));
                vertex(vertexList.get(3));
                vertex(vertexList.get(0));
                vertex(vertexList.get(3));
                vertex(vertexList.get(2));
                vertex(vertexList.get(3));
                vertex(vertexList.get(1));
                vertex(vertexList.get(2));
            endShape();
        }
        else {
            if (renderMode == "Retained") {
                beginShape(TRIANGLE_STRIP);
                vertex(vertexList.get(0));
                vertex(vertexList.get(1));
                vertex(vertexList.get(2));
                vertex(vertexList.get(0));
                vertex(vertexList.get(1));
                vertex(vertexList.get(3));
                vertex(vertexList.get(0));
                vertex(vertexList.get(3));
                vertex(vertexList.get(2));
                vertex(vertexList.get(3));
                vertex(vertexList.get(1));
                vertex(vertexList.get(2));
                endShape();
            }
        }


    }


}