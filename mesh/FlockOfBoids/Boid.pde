class Boid{
  Node node;
  int grabsMouseColor;
  int avatarColor;
  // fields
  Vector position, velocity, acceleration, alignment, cohesion, separation;
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 4; // maximum magnitude for the velocity vector
  float maxSteerForce = .1f; // maximum magnitude of the steering vector
  float sc = 4; // scale factor for the render of the boid
  float flap = 0;
  float t = 0;
  
  int representation, renderMode;
  
  List<Face> faceList = new ArrayList<Face>(); //list face-vertex face
  List<Vector> vertexList = new ArrayList<Vector>(); //list face-vertex vertices
  
  Face f1,f2,f3,f4; // tetrahedron faces
  Vector a1, a2, a3, a4;// tetrahedron vertices
  
  VertexVertex vertexVertexMesh;
  FaceVertex faceVertexMesh;
  PShape shapeBoid;

  Boid(Vector inPos, int representation, int renderMode) {
    
    this.representation = representation;
    this.renderMode = renderMode;
    //this.shape = shape;
    
    grabsMouseColor = color(0, 0, 255);
    avatarColor = color(255, 255, 0);
    position = new Vector();
    position.set(inPos);
    node = new Node(scene) {
      

      // Note that within visit() geometry is defined at the
      // node local coordinate system.
      @Override
      public void visit() {
        if (animate)
          run(flock);
        render();
        
      }
      // Behaviour: tapping over a boid will select the node as
      // the eye reference and perform an eye interpolation to it.
      @Override
      public void interact(frames.input.Event event) {
        // the event shortcut type tell us about the event type itself:
        if(event.shortcut() instanceof TapShortcut)
          if (avatar != this && scene.eye().reference() != this) {
            avatar = this;
            scene.eye().setReference(this);
            scene.interpolateTo(this);
          }
      }
    };
    node.setPosition(position);
    velocity = new Vector(random(-1, 1), random(-1, 1), random(1, -1));
    acceleration = new Vector();
    neighborhoodRadius = 100;
  }

  void run(ArrayList<Boid> boids) {
    t += .1;
    flap = 10 * sin(t);
    if (avoidWalls) {
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), flockHeight, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), 0, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(flockWidth, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(0, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), 0)), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), flockDepth)), 5));
    }
    flock(boids);
    move();
    checkBounds();
  }

  Vector avoid(Vector target) {
    Vector steer = new Vector(); // creates vector for steering
    steer.set(Vector.subtract(position, target)); // steering vector points away from
    steer.multiply(1 / sq(Vector.distance(position, target)));
    return steer;
  }

  //-----------behaviors---------------

  void flock(ArrayList<Boid> boids) {
    //alignment
    alignment = new Vector();
    int alignmentCount = 0;
    //cohesion
    Vector posSum = new Vector();
    int cohesionCount = 0;
    //separation
    separation = new Vector();
    Vector repulse;
    for (int i = 0; i < boids.size(); i++) {
      Boid boid = boids.get(i);
      //alignment
      float distance = Vector.distance(position, boid.position);
      if (distance > 0 && distance <= neighborhoodRadius) {
        alignment.add(boid.velocity);
        alignmentCount++;
      }
      //cohesion
      float dist = dist(position.x(), position.y(), boid.position.x(), boid.position.y());
      if (dist > 0 && dist <= neighborhoodRadius) {
        posSum.add(boid.position);
        cohesionCount++;
      }
      //separation
      if (distance > 0 && distance <= neighborhoodRadius) {
        repulse = Vector.subtract(position, boid.position);
        repulse.normalize();
        repulse.divide(distance);
        separation.add(repulse);
      }
    }
    //alignment
    if (alignmentCount > 0) {
      alignment.divide((float) alignmentCount);
      alignment.limit(maxSteerForce);
    }
    //cohesion
    if (cohesionCount > 0)
      posSum.divide((float) cohesionCount);
    cohesion = Vector.subtract(posSum, position);
    cohesion.limit(maxSteerForce);

    acceleration.add(Vector.multiply(alignment, 1));
    acceleration.add(Vector.multiply(cohesion, 3));
    acceleration.add(Vector.multiply(separation, 1));
  }

  void move() {
    velocity.add(acceleration); // add acceleration to velocity
    velocity.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    position.add(velocity); // add velocity to position
    node.setPosition(position);
    node.setRotation(Quaternion.multiply(new Quaternion(new Vector(0, 1, 0), atan2(-velocity.z(), velocity.x())),
      new Quaternion(new Vector(0, 0, 1), asin(velocity.y() / velocity.magnitude()))));
    acceleration.multiply(0); // reset acceleration
  }

  void checkBounds() {
    if (position.x() > flockWidth)
      position.setX(0);
    if (position.x() < 0)
      position.setX(flockWidth);
    if (position.y() > flockHeight)
      position.setY(0);
    if (position.y() < 0)
      position.setY(flockHeight);
    if (position.z() > flockDepth)
      position.setZ(0);
    if (position.z() < 0)
      position.setZ(flockDepth);
  }

  void render() {
    pushStyle();
    // uncomment to draw boid axes
    //scene.drawAxes(10);

    int kind = TRIANGLES;
    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));
    // visual modes
    switch(mode) {
    case 1:
      noFill();
      break;
    case 2:
      noStroke();
      break;
    case 3:
      strokeWeight(3);
      kind = POINTS;
      break;
    }

    // highlight boids under the mouse
    if (node.track(mouseX, mouseY)) {
      noStroke();
      fill(grabsMouseColor);
    }

    // highlight avatar
    if (node == avatar) {
      kind = TRIANGLES;
      noStroke();
      fill(avatarColor);
    }

    initializeMeshValues();
    createMeshAndRender();
    setNullUnnecesaryReferences();
    if (renderMode == 1){
      display();
    }
    
    /*
    //draw boid
    beginShape(kind);
    vertex(3 * sc, 0, 0); //a1
    vertex(-3 * sc, 2 * sc, 0); //a2
    vertex(-3 * sc, -2 * sc, 0); // a3

    vertex(3 * sc, 0, 0);//a1
    vertex(-3 * sc, 2 * sc, 0); //a2
    vertex(-3 * sc, 0, 2 * sc); //a4

    vertex(3 * sc, 0, 0); //a1
    vertex(-3 * sc, 0, 2 * sc);// a4
    vertex(-3 * sc, -2 * sc, 0); // a3

    vertex(-3 * sc, 0, 2 * sc); // a4
    vertex(-3 * sc, 2 * sc, 0); // a2
    vertex(-3 * sc, -2 * sc, 0); // a3
    endShape();

    popStyle();
    */
  }

  public void createMeshAndRender(){
    switch(this.representation){
      
      case 0://Face vertex
      
        faceVertexMesh = new FaceVertex(faceList, vertexList);        
        if(this.renderMode == 1){
          this.shapeBoid = faceVertexMesh.renderMeshRetained();          
        }
        else{
          faceVertexMesh.renderMeshImmediate();
          faceVertexMesh = null;
        }

      break;
      
      case 1: //vertex-vertex
      
        VertexVertex vertexVertexMesh = new VertexVertex(vertexList);
        if(this.renderMode == 0){
          vertexVertexMesh.renderMesh("Immediate");
          vertexVertexMesh = null;
        }
        else{
          this.shapeBoid = vertexVertexMesh.renderMesh("Retained");
      }
      break;    
      
    }
    
  }

void display(){
  shape(shapeBoid);
}
  void setListsToNull(){
    faceList = null;
    vertexList = null;
  }
  void setFacesToNull(){
    f1 = null;
    f2 = null;
    f3 = null;
    f4 = null;
   }
   void setVertexToNull(){
     a1 = null;
     a2 = null;
     a3 = null;
     a4 = null;
   }
  void setNullUnnecesaryReferences(){
    setFacesToNull();
    setVertexToNull();
  }

  void initializeMeshValues(){

      a1 = new Vector(3 * sc, 0, 0);
      a2 = new Vector(-3 * sc, 2 * sc, 0);
      a3 = new Vector(-3 * sc, -2 * sc, 0);
      a4 = new Vector(-3 * sc, 0, 2 * sc);
      addVertexesToList();

      f1 = new Face(a1, a2, a3);
      f2 = new Face(a1, a2, a4);
      f3 = new Face(a1, a4, a3);
      f4 = new Face(a4, a2, a3);
      addFacesToList();
  }

  void addFacesToList(){
      faceList.add(f1);
      faceList.add(f2);
      faceList.add(f3);
      faceList.add(f4);
  }

   void addVertexesToList(){
      vertexList.add(a1);
      vertexList.add(a2);
      vertexList.add(a3);
      vertexList.add(a4);
   }
}