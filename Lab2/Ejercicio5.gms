*************************************************************************
***      Ejercicio 5, problema de trabajadores requeridos para        ***
***                      los dàas de la semana                        ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201911676                  ***
*************************************************************************

Sets
  i     dï¿½as / d1*d7 /
alias(j,i);

Table  c(i,j)   costo
         d1    d2    d3    d4    d5    d6    d7
d1       1     0     0     1     1     1     1
d2       1     1     0     0     1     1     1
d3       1     1     1     0     0     1     1
d4       1     1     1     1     0     0     1
d5       1     1     1     1     1     0     0
d6       0     1     1     1     1     1     0
d7       0     0     1     1     1     1     1


Parameter
t(i)  trabajadores al dï¿½a /d1 17, d2 13, d3 15, d4 19, d5 14, d6 16, d7 11/;

Variables
  x(i)        Indica la cantidad de trabajadores que inician a trabajar el dia i
  z           Objective function;

Positive variable x;

Equations
objectiveFunction        objective function
diasSemana               diasSemana;

objectiveFunction        ..  z =e= sum(i, x(i));
diasSemana(i)            ..  sum(j, c(i,j) * x(j)) =g= t(i);

Model Ejercicio5 /all/ ;
option mip=CPLEX
Solve Ejercicio5 using mip minimazing z;

Display t;
Display x.l;
Display z.l;

