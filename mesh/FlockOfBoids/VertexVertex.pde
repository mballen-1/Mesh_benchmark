public class VertexVertex{
    
    Map<Integer, Integer[]> neighbors;
    List<Vector> vertexList;
    PShape shapeVertex = createShape();

    public VertexVertex(List<Vector> vertexList, Map<Integer, Integer[]> neighbors) {
        this.vertexList = vertexList;
        this.neighbors = neighbors;
    }

    void renderMeshImmediate(){//powerfull
        for(int current_vertex: neighbors.keySet()){
            Integer[] current_neighbors = neighbors.entrySet().iterator().next().getValue();
            for(int neighbors: current_neighbors){
                line(vertexList.get(current_vertex).x(), vertexList.get(current_vertex).y(), vertexList.get(current_vertex).z(), vertexList.get(neighbors).x(),vertexList.get(neighbors).y(),vertexList.get(neighbors).z());
            }
        }

    }
    
    
    PShape renderMeshRetained(){
      
      shapeVertex.beginShape(TRIANGLE_STRIP);
        for(int current_vertex: neighbors.keySet()){
            Integer[] current_neighbors = neighbors.entrySet().iterator().next().getValue();
            for(int neighbors: current_neighbors){
                shapeVertex.vertex(vertexList.get(current_vertex).x(), vertexList.get(current_vertex).y(), vertexList.get(current_vertex).z());
                shapeVertex.vertex(vertexList.get(neighbors).x(),vertexList.get(neighbors).y(),vertexList.get(neighbors).z());
                //shapeVertex.vertex(vertexList.get(0).x(),vertexList.get(0).y(),vertexList.get(0).z());//tricky
            }
        }
        shapeVertex.endShape();        
        return shapeVertex;

    }
}