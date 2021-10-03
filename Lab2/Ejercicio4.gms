*************************************************************************
***         Ejercicio 4, problema de los nodos inal�mbricos           ***
***                                                                   ***
***      Authors: Felipe Guzm�n Avenda�o - 201813791              ***
***               Juan Nicol�s Bola�os   - 201911676              ***
*************************************************************************

Sets
  i   nodos inal�mbricos  /n1*n7/
  d   dimensiones del plano /d1*d2/
  alias(i,j);

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
distancia(i,j) distancia entre 2 nodos
conexion       distancia minima para haber conexion
existeConexion(i,j) determina si existe conexion entre 2 nodos;

conexion = 20;
loop((i),
     loop((j),
          distancia(i,j)= sqrt(sqr(c(i,'d1')-c(j,'d1'))+sqr(c(i,'d2')-c(j,'d2')));
          if(distancia(i,j) <= conexion, existeConexion(i,j) = 1);
          if(distancia(i,j) > conexion,  existeConexion(i,j) = 0);
     );
);

Variables
    s(i) indica si un nodo i fue seleccionado para la ruta
    z    objective function;

Binary Variable s;

Equations
objectiveFunction        objective function;

objectiveFunction           .. z =e= sum((i,j), distancia(i,j)*s(i))