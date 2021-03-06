***      Ejercicio 2, problema del equipo de basketball               ***
***                                                                   ***
***      Authors: Felipe Guzm?n Avenda?o - 201813791                  ***
***               Juan Nicol?s Bola?os   - 201911676                  ***
*************************************************************************

Sets
 i  jugadores /j1*j7/
 e  expectativas /e1*e6/
 alias(i, j);

Table h(i,j)     jugadores y habilidades
      j1      j2     j3     j4       j5      j6      j7
j1    0       0      1      3        3       1       3
j2    0       1      0      2        1       3       2
j3    1       0      1      2        3       2       2
j4    1       1      0      1        3       3       1
j5    1       0      1      3        3       3       3
j6    1       1      0      3        1       2       3
j7    1       0      1      3        2       2       1
;

Parameter
x(e) expectativas del equipo
total total jugadores equipo
excluido(i) clausula excluyente de un jugador
excluidos cantidad de jugadores exclusivos en el equipo;

x('e1') = 4;
x('e2') = 1;
x('e3') = 2;
x('e4') = 2;
x('e5') = 2;
x('e6') = 2;

total = 5;

excluido(i) = 0;
excluido('j2') = 1;
excluido('j3') = 1;

excluidos = 1;


Variables
  s(i) indica si un jugador i fue seleccionado para el equipo
  z    objective function;

Binary Variable s;

Equations
objectiveFunction        objective function
defensas                 defensas del equipo
centros                  centros del equipo
atacantes                atacantes del equipo
ctlBalon                 promedio control balon del equipo
disparo                  promedio disparo del equipo
rebote                   promedio rebote del equipo
totalJugadores           total de jugadores dentro del equipo
jugadoresExclusivos       restriccion exclusdiva frente a j2 y j3;

objectiveFunction(j)$(ord(j) = 7)  ..   z =e= sum((i), h(i,j)*s(i));
defensas(j)$(ord(j) = 1)           ..   x('e1') =l= sum((i), h(i,j)*s(i));
centros(j)$(ord(j) = 2)            ..   x('e2') =l= sum((i), h(i,j)*s(i));
atacantes(j)$(ord(j) = 3)          ..   x('e3') =l= sum((i), h(i,j)*s(i));
ctlBalon(j)$(ord(j) = 4)           ..   x('e4') =l= sum((i), h(i,j)*s(i))/total;
disparo(j)$(ord(j) = 5)            ..   x('e5') =l= sum((i), h(i,j)*s(i))/total;
rebote(j)$(ord(j) = 6)             ..   x('e6') =l= sum((i), h(i,j)*s(i))/total;
totalJugadores                     ..   total =e= sum((i), s(i));
jugadoresExclusivos                ..   excluidos =e= sum((i), excluido(i)*s(i));

Model Ejercicio2 /all/ ;
option mip=CPLEX
Solve Ejercicio2 using mip maximizing z;

Display h;
Display s.l;
Display z.l;

