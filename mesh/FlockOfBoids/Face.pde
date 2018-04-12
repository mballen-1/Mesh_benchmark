public class Face{
  
  Vector v1;
  Vector v2;
  Vector v3;

  public Vector getV1() {
    return v1;
  }

  public void setV1(Vector v1) {
    this.v1 = v1;
  }

  public Vector getV2() {
    return v2;
  }

  public void setV2(Vector v2) {
    this.v2 = v2;
  }

  public Vector getV3() {
    return v3;
  }

  public void setV3(Vector v3) {
    this.v3 = v3;
  }

  public Face(Vector v1, Vector v2, Vector v3) {

    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
  }

  public void renderFaceImmediate(){
    beginShape(TRIANGLE_STRIP);
      vertex(v1.x(),v1.y(),v1.z);
      vertex(v1.x(),v1.y(),v1.z);
      vertex(v1.x(),v1.y(),v1.z);
    endShape();
  }

  public void renderFaceRetained(){
    Shape shape = createShape();
      s.vertex(v1.x(),v1.y(),v1.z);
      s.vertex(v1.x(),v1.y(),v1.z);
      s.vertex(v1.x(),v1.y(),v1.z);
    s.endShape();
  }

}