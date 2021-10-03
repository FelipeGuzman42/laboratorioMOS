***      Ejercicio 2, problema del equipo de bascketball              ***
***                                                                   ***
***      Authors: Felipe Guzm�n Avenda�o - 201813791                  ***
***               Juan Nicol�s Bola�os   - 201911676                  ***
*************************************************************************

Sets
 i  jugadores /j1*j7/
 alias(i, j)  habilidades y roles
 e  expectativas /e1*e6/;

Parameter

Table h(i,j)     jugadores y habilidades
         defensa centro ataque ctlBalon Disparo Rebotes Defensa
jugador1    0       0      1      3        3       1       3
jugador2    0       1      0      2        1       3       2
jugador3    1       0      1      2        3       2       2
jugador4    1       1      0      1        3       3       1
jugador5    1       0      1      3        3       3       3
jugador6    1       1      0      3        1       2       3
jugador7    1       0      1      3        2       2       1
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
expectativas             expectativas del equipo
totalJugadores           total de jugadores dentro del equipo
jugadoresExclusivos       restricción exclusdiva frente a j2 y j3;

objectiveFunction(j)$(ord(j) = 7)  ..   z =e= sum((i), h(i,j));
expectativas(e)                    ..   x(e) =l= sum((e), h(e,e))
totalJugadores                     ..   total =e= sum((i), s(i))
jugadoresExclusivos                ..   excluidos =e= sum((i), excluido(i))

Model Ejercicio2 /all/ ;
option mip=CPLEX
Solve Ejercicio2 using mip maximizing z;

Display h;
Display s.l;
Display z.l;

