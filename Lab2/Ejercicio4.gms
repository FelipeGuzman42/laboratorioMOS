*************************************************************************
***         Ejercicio 4, problema de los nodos inalámbricos           ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201911676                  ***
*************************************************************************

Sets
  i      nodos /n1*n7/
  int(i) nodos intermedios /n1,n2,n5,n7/
  e(i)   nodos destino /n6/
  d      dimensiones del plano /d1*d2/
  alias(i,j,k);

Table c(i,d)   coordenadas de los nodos
         d1      d2
n1       20      6
n2       22      1
n3       9       2
n4       3       25
n5       21      10
n6       29      2
n7       14      12
;

Parameter
distancia(i,j)      distancia entre 2 nodos
conexion            distancia minima para haber conexion
existeConexion(i,j) determina si existe conexion entre 2 nodos
arco(i,j)           arco entre 2 nodos si hay conexion
intermediate(int)   se almacenan las posiciones de los nodos intermedios
destinations(e)     almacena posicion del nodo destino;

intermediate(int) = int.uel;

destinations(e) = e.uel;

arco(i,j) = 999;

conexion = 20;

loop((i),
     loop((j),
          distancia(i,j)= sqrt(sqr(c(i,'d1')-c(j,'d1'))+sqr(c(i,'d2')-c(j,'d2')));
          if(distancia(i,j) <= conexion, existeConexion(i,j) = 1);
          if(distancia(i,j) > conexion,  existeConexion(i,j) = 0);
          if(existeConexion(i,j) = 1, arco(i,j) = distancia(i,j));
     );
);

display arco;

Variables
    x(i,j,e) indica el arco fue escogido para la ruta
    z    objective function;

Binary Variable x;

Equations
objectiveFunction        objective function
sourceNode(i)            source node
destinationNodes         destination nodes
intermediateNode(int, e) intermediate node
noRepeatedLink(i,j,e)    no repeated links;

objectiveFunction            .. z =e= sum((i,j,e), arco(i,j)*x(i,j,e));
sourceNode(i)$(ord(i) = 4)   .. 1 =e= sum((j,e), x(i,j,e));
destinationNodes             .. 1 =e= sum((i,j,e)$(destinations(e)=ord(j)), x(i,j,e));
intermediateNode(int, e)     .. 0 =e= sum((j), x(int,j,e)) - sum((j), x(j,int,e));
noRepeatedLink(i,j,e)        .. 1 =g= x(i,j,e) + x(j,i,e);

Model Ejercicio4 / all /;

solve Ejercicio4 using mip minimizing z;

Display x.l;
Display z.l;
