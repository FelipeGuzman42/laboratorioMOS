*************************************************************************
***      Minimizar el costo de transporte de procesos en un           ***
***      sistema de multiprocesamiento                                ***
***                                                                   ***
***      Author: Felipe Guzm�n Avenda�o - 201813791                   ***
*************************************************************************

Sets
  i   procesadores origen / o1*o3 /
  j   procesadores destino / d1*d4 /

Parameter  c(i,j)   costo;
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
procesadorO2             procesador origen 2
procesadorO3             procesador origen 3
procesadorD1             procesador destino 1
procesadorD2             procesador destino 2
procesadorD3             procesador destino 3
procesadorD4             procesador destino 4;


funcionObj                       ..  z =e= sum((i,j), c(i,j) * p(i,j));

procesadorO1(i)$(ord(i) = 1)     ..  sum((j), p(i,j)) =l= 300;
procesadorO2(i)$(ord(i) = 2)     ..  sum((j), p(i,j)) =l= 500;
procesadorO3(i)$(ord(i) = 3)     ..  sum((j), p(i,j)) =l= 200;

procesadorD1(j)$(ord(j) = 1)     ..  sum((i), p(i,j)) =e= 200;
procesadorD2(j)$(ord(j) = 2)     ..  sum((i), p(i,j)) =e= 300;
procesadorD3(j)$(ord(j) = 3)     ..  sum((i), p(i,j)) =e= 100;
procesadorD4(j)$(ord(j) = 4)     ..  sum((i), p(i,j)) =e= 400;


Model Ejercicio2 /all/ ;
option mip=CPLEX
Solve Ejercicio2 using mip minimazing z;

Display c;
Display z.l;
Display p.l;

