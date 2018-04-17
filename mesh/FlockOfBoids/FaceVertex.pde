import java.util.List;

public class FaceVertex{

    List<Face> faceList;
    List<Vector> vertexList;
    Map<Vector, Face[]> neighbors;
    

    public List<Face> getFaceList() {
        return faceList;
    }

    public void setFaceList(List<Face> faceList) {
        this.faceList = faceList;
    }

    public List<Vector> getVertexList() {
        return vertexList;
    }

    public void setVertexList(List<Vector> vertexList) {
        this.vertexList = vertexList;
    }

    public FaceVertex(List<Face> faceList, List<Vector> vertexList, Map<Vector, Face[]> neighbor_faces) {

        this.faceList = faceList;
        this.vertexList = vertexList;
        this.neighbors = neighbor_faces;
    }

    void renderMeshImmediate(){        
      for(Face face : faceList) {
        face.renderFaceImmediate();
       }       
        faceList = null;
        vertexList = null;
    }
    
    PShape renderMeshRetained(){
      PShape shapeFace = createShape();
      shapeFace.beginShape();
      for(Face face : faceList) {
        shapeFace.vertex(face.v1.x(), face.v1.y(), face.v1.z());
        shapeFace.vertex(face.v2.x(), face.v2.y(), face.v2.z());
        shapeFace.vertex(face.v3.x(), face.v3.y(), face.v3.z());
      }
      shapeFace.endShape();
      return shapeFace;
    }

}