import java.util.List;

public class FaceVertex{

    List<Face> faceList;
    List<Vector> vertexList;

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

    public FaceVertex(List<Face> faceList, List<Vector> vertexList) {

        this.faceList = faceList;
        this.vertexList = vertexList;
    }

    void renderMesh(){        
      for(Face face : faceList) {
        face.renderFaceImmediate();
       }       
        faceList = null;
        vertexList = null;
        //System.gc();
    }
    
    void renderMesh(PShape shape){
      for(Face face : faceList) {
        face.renderFaceRetained(shape);
      }
      faceList = null;
      vertexList = null;
    }

}