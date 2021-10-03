*************************************************************************
***         Ejercicio 4, problema de los nodos inalámbricos           ***
***                                                                   ***
***      Authors: Felipe Guzmï¿½n Avendaï¿½o - 201813791              ***
***               Juan Nicolï¿½s Bolaï¿½os   - 201911676              ***
*************************************************************************

Sets
  i   nodos inalámbricos  /n1*n7/
  d   dimensiones del plano /d1*d2/
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
distancia(i,j) distancia entre 2 nodos
conexion       distancia minima para haber conexion
existeConexion(i,j) determina si existe conexion entre 2 nodos
arco(i,j)      arco entre 2 nodos si hay conexion;

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
    x(i,j,k) indica los arcos escogidos para la ruta
    z    objective function;

Binary Variable s;

Equations
objectiveFunction        objective function
nb(i,j)                  balance de nodos;

objectiveFunction           .. z =e= sum((i,j,k), arco(j,k)*x(i,j,k));
nb(i,j)$(not sameas(i,j)) .. sum(k$arco(k,j), x(i,k,j)) =g= sum(k$arco(j,k), x(i,j,k)) + 1;

Model Ejercicio4 / all /;

solve Ejercicio4 using lp minimizing z;

Parameter sroute(i,j);

sroute(i,j) = -nb.m(i,j);

display sroute;