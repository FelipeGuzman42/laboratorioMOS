*************************************************************************
***      Minimizar el costo de transporte de procesos en un           ***
***      sistema de multiprocesamiento                                ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201991676                  ***
*************************************************************************

Sets
  i   procesadores origen / o1*o3 /
  j   procesadores destino / d1*d4 /

Parameter
a(i) / o1 300, o2 500, o3 200 /
b(j) /d1 200, d2 300, d3 100, d4 400 /
c(i,j)   costo;
c(i,j)=999;
c('o1','d1')=8;
c('o1','d2')=6;
c('o1','d3')=10;
c('o1','d4')=9;
c('o2','d1')=9;
c('o2','d2')=12;
c('o2','d3')=13;
c('o2','d4')=7;
c('o3','d1')=14;
c('o3','d2')=9;
c('o3','d3')=16;
c('o3','d4')=5;


Variables
  p(i,j)      Procesos enviados de i a j
  z           Objective function;

Positive Variable p;

Equations
funcionObj               Funcion Objetivo

procesadorO1             procesador origen 1
procesadorD1             procesador destino 1;


funcionObj                       ..  z =e= sum((i,j), c(i,j) * p(i,j));

procesadorO1(i)                  .. sum(j, p(i,j)) =e= a(i);

procesadorD1(j)                  .. sum(i, p(i,j)) =e= b(j);


Model Ejercicio2 /all/ ;
option mip=CPLEX
Solve Ejercicio2 using mip minimazing z;

Display c;
Display z.l;
Display p.l;

