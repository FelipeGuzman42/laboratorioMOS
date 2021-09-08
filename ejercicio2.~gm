*************************************************************************
***      Minimizing the number of hops in a directed graph            ***
***                                                                   ***
***      Author: Germán Montoya                                       ***
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
  x(i,j)      Indicates if the link i-j is selected or not.
  z           Objective function
  p1          Cantidad de procesador 1
  p2          Cantidad de procesador 2
  p3          Cantidad de procesador 3;
Positive Variable p1;
Positive Variable p2;
Positive Variable p3;

Binary Variable x;

Equations
funcionObj               Funcion Objetivo

procesador_1             procesador 1
procesador_2             procesador 2
procesador_3             procesador 3
procesador_4             procesador 4;

funcionObj               ..      z =e= sum((i,j), c(i,j) * x(i,j));

procesador_1             ..      300*p1 + 500*p2 + 200*p3 =e= 200;
procesador_2             ..      300*p1 + 500*p2 + 200*p3 =e= 300;
procesador_3             ..      300*p1 + 500*p2 + 200*p3 =e= 100;
procesador_4             ..      300*p1 + 500*p2 + 200*p3 =e= 400;


Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip maximazing z;

Display c;
Display x.l;
Display z.l;

