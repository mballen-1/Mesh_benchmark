# Taller de mallas poligonales

## Propósito

Estudiar la relación entre las [aplicaciones de mallas poligonales](https://github.com/VisualComputing/representation), su modo de [representación](https://en.wikipedia.org/wiki/Polygon_mesh) (i.e., estructuras de datos empleadas para representar la malla en RAM) y su modo de [renderizado](https://processing.org/tutorials/pshape/) (i.e., modo de transferencia de la geometría a la GPU).

## Tareas

Hacer un benchmark (midiendo los *fps* promedio) de varias representaciones de mallas poligonales para los _boids_ del ejemplo del [FlockOfBoids](https://github.com/VisualComputing/framesjs/tree/processing/examples/Advanced/FlockOfBoids) (requiere la librería [frames](https://github.com/VisualComputing/framesjs/releases), versión ≥ 0.1.0), tanto en modo inmediato como retenido de rendering.

1. Represente la malla del [boid](https://github.com/VisualComputing/framesjs/blob/processing/examples/Advanced/FlockOfBoids/Boid.pde) al menos de ~tres~ dos formas distintas.
2. Renderice el _flock_ en modo inmediato y retenido, implementando la función ```render()``` del [boid](https://github.com/VisualComputing/framesjs/blob/processing/examples/Advanced/FlockOfBoids/Boid.pde).
3. Haga un benchmark que muestre una comparativa de los resultados obtenidos.

### Opcionales

1. Realice la comparativa para diferentes configuraciones de hardware.
2. Realice la comparativa de *fps* sobre una trayectoria de animación para el ojo empleando un [interpolator](https://github.com/VisualComputing/framesjs/tree/processing/examples/Basics/B8_Interpolation2) (en vez de tomar su promedio).
3. Anime la malla, como se hace en el ejemplo de [InteractiveFish](https://github.com/VisualComputing/framesjs/tree/processing/examples/ik/InteractiveFish).
4. Haga [view-frustum-culling](https://github.com/VisualComputing/framesjs/tree/processing/examples/Demos/ViewFrustumCulling) de los _boids_ cuando el ojo se encuentre en tercera persona.

### Profundizaciones

1. Introducir el rol depredador.
2. Cómo se afecta el comportamiento al tener en cuenta el [campo visual](https://es.wikipedia.org/wiki/Campo_visual) (individual)?
3. Implementar el algoritmo del ```flock()``` en [OpenCL](https://en.wikipedia.org/wiki/OpenCL). Ver [acá](https://www.youtube.com/watch?v=4NU37rPOAsk) un ejemplo de *Processing* en el que se que emplea [JOCL](http://www.jocl.org/).

### References

1. [Reynolds, C. W. Flocks, Herds and Schools: A Distributed Behavioral Model. 87](http://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/).
2. Check also this [nice presentation](https://pdfs.semanticscholar.org/73b1/5c60672971c44ef6304a39af19dc963cd0af.pdf) about the paper:
3. There are many online sources, google for more...

## Integrantes

Máximo 3.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Miguel Angel Ballen | mballeng91|
|Tania Hurtado Pinto| TaniaHurtado|
|Ivan Darío Rojas| idrojasf|

## Entrega

* Modo de entrega: Haga [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla e informe la url del repo en la hoja *urls* de la plantilla compartida (una sola vez por grupo). Plazo: 15/4/18 a las 24h.
* Exposición oral en el taller de la siguiente semana (6 minutos: 4 para presentar y 2 para preguntas). Estructura sugerida:
  1. Representaciones estudiadas.
  2. Demo.
  3. Resultados (benchmark).
  4. Conclusiones.

## Resultados obtenidos

### Introducción
    
   En el proceso de renderizado de un elemento gráfico se cuenta con dos opciones 
    dadas por Java y Processing librería de contenido gráfico para tal fin.
    Estas dos opciones son el modo retenido y el modo inmediato.
    
   El modo retenido de rendering permite almacenar el contenido de un
    elemento perteneciente a alguna escena en Processing en la memoria
    del dispositivo antes de ser mostrado en la pantalla. Esto puede ser
    útil en determinados casos en los que el dispositivo cuenta con
    cierta limitación de procesamiento y se apoya en el uso de la memoria RAM.
    
   Por otra parte el modo inmediato permite renderizar un elemento 
    gráfico sin referenciar o almacenar su contenido en la memoria RAM
    del dispositivo que ejecuta el procedimiento de renderizado.

###  Mallas poligonales - objetivos
    
   En el procedimiento realizado a nivel de hardware para el presente taller,
    se busca evaluar el comportamiento a nivel de hardware cuando se 
    renderiza una malla poligonal en modo inmediato y en modo retenido
    con diferentes configuraciones.
    
   Una malla poligonal es una abstracción de la información relacionada
    con un sólido que pueda representarse por una cantidad determinada
    de caras o planos con forma de algún polígono regular.
### Procedimiento
    
   En el presente caso de estudio se renderizó un conjunto de 
    mallas poligonales. En particular un numero variable de tetrahedros que 
    conforman una manada que posee un comportamiento de un agente con vida artificial
    dado de forma inicial.
    
   Se procedió a la declaración de dos estructuras de datos para las representaciones
    de las mallas poligonales. En particular se seleccionaron las 
    representaciones Face-vertex   y Vertex-Vertex.
    
   En la representación Face-Vertex se tienen dos listas. Una que contiene
    la información de cada una de las caras que conforman la malla poligonal
    y otra con los vertices que conforman las caras mencionadas anteriormente.
    A partir de allí es suficiente con recorrer los elementos contenidos
    dentro de la lista de caras para renderizarlas una a una y así 
    formar en el sketch el sólido esperado.
    
   En cuanto a la representación Vertex-Vertex, se cuenta con una única
    lista que debe recorrerse en un orden determinado para extraer la 
    información perteneciente a los vertices que conforman la malla e ir
    renderizando las caras mediante el uso de las funciones beginShape(),
    vertex(a1,a2,a3) y endShape().
        
    public void renderFaceImmediate(){
        beginShape(TRIANGLE_STRIP);
            vertex(v1.x(),v1.y(),v1.z());
            vertex(v2.x(),v2.y(),v2.z());
            vertex(v3.x(),v3.y(),v3.z());
        endShape();
     }    
    
   Estos métodos forman parte del conjunto de instrucciones de Processing,
    que pueden emplearse para formar cualquier tipo de figura geométrica
    en 2 y 3 dimensiones.
    
   Para el modo retenido a nivel de implementación, es necesario instanciar
    un objeto de la clase PShape también de processing para que en la memoria
    se almacene la información de la forma a la cual se quiere representar
    y renderizar en el sketch.
     ```java
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
     ``` 
        
    

### Resultados y análisis

### Conclusiones




