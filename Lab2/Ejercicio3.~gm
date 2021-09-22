*************************************************************************
***      Ejercicio 3, problema de covertura con tiempo máximo         ***
***                                                                   ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201991676                  ***
*************************************************************************
15 min
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
  x(i)        Indicates if the link i is selected or not.
  z           Objective function  ;

Binary Variable x;

Equations
objectiveFunction        objective function      ;
sourceNode(i)            source node
destinationNode(j)       destination node
intermediateNode         intermediate node;

objectiveFunction                                  ..  z =e= sum((i,j), c(i,j) * x(i,j));

sourceNode(i)$(ord(i) = 1)                         ..  sum((j), x(i,j)) =e= 1;

destinationNode(j)$(ord(j) = 5)                    ..  sum((i), x(i,j)) =e= 1;

intermediateNode(i)$(ord(i) <> 1 and ord(i) ne 5)  ..  sum((j), x(i,j)) - sum((j), x(j,i)) =e= 0;

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip maximazing z;

Display c;
Display x.l;
Display z.l;

