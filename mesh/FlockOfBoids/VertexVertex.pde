public class VertexVertex{
    
    Map<Integer, Integer[]> neighbors;
    List<Vector> vertexList;
    PShape shapeVertex = createShape();

    public VertexVertex(List<Vector> vertexList, Map<Integer, Integer[]> neighbors) {
        this.vertexList = vertexList;
        this.neighbors = neighbors;
    }

    void renderMeshImmediate(){
        for(int current_vertex: neighbors.keySet()){
            Integer current_neighbors = neighbors.entrySet().iterator().next().getValue();
            List<Integer> magic = new ArrayList(current_neighbors); 
            for(int neighbors: current_neighbors){
                line(vertexList.get(current_vertex).x(), vertexList.get(current_vertex).y(), vertexList.get(current_vertex).z(), vertexList.get(neighbors).x(),vertexList.get(neighbors).y(),vertexList.get(neighbors).z());
            }
        }

    }


    public PShape renderMesh(String renderMode){
        if(renderMode == "Immediate"){
           renderMeshImmediate();
        }
        else {
            if (renderMode == "Retained") {
              
                shapeVertex.beginShape();
                    shapeVertex.vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    shapeVertex.vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    shapeVertex.vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                shapeVertex.endShape();
                shapeVertex.beginShape(TRIANGLE_STRIP);
                    shapeVertex.vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    shapeVertex.vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    shapeVertex.vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
               shapeVertex.endShape(); 
               shapeVertex.beginShape(TRIANGLE_STRIP);
                    shapeVertex.vertex(vertexList.get(0).x(), vertexList.get(0).y(), vertexList.get(0).z());
                    shapeVertex.vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                    shapeVertex.vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
               shapeVertex.endShape();
               shapeVertex.beginShape(TRIANGLE_STRIP);
                    shapeVertex.vertex(vertexList.get(3).x(), vertexList.get(3).y(), vertexList.get(3).z());
                    shapeVertex.vertex(vertexList.get(1).x(), vertexList.get(1).y(), vertexList.get(1).z());
                    shapeVertex.vertex(vertexList.get(2).x(), vertexList.get(2).y(), vertexList.get(2).z());
                    //System.out.println("retained vertex vertex");
                shapeVertex.endShape();
               
               return shapeVertex;
            }
            
        }
        return shapeVertex;

    }


}