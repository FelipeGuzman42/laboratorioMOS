*************************************************************************
***      Ejercicio 3, problema de cobertura con tiempo m?nimo         ***
***                                                                   ***
***      Authors: Felipe Guzm?n Avenda?o - 201813791                  ***
***               Juan Nicol?s Bola?os   - 201911676                  ***
*************************************************************************

Sets
  i   pueblos / p1*p6 /
alias(j,i);

Table  c(i,j)   costo
         p1    p2    p3    p4    p5    p6
p1       0     10    20    30    30    20
p2       10    0     25    35    20    10
p3       20    25    0     15    30    20
p4       30    35    15    0     15    25
p5       30    20    30    15    0     14
p6       20    10    20    25    14    0

Variables
  x(i)        Indica si el pueblo Pi es seleccionado o no.
  z           Objective function  ;

Binary Variable x;

Equations
objectiveFunction        objective function
cubrir(i)                cubrir elementos;

objectiveFunction        ..  z =e= sum(i, x(i));
cubrir(i)                ..  sum(j$(c(i,j) <= 15), x(j)) =g= 1;

Model Ejercicio3 /all/ ;
option mip=CPLEX
Solve Ejercicio3 using mip minimazing z;

Display c;
Display x.l;
Display z.l;

