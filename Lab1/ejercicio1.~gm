*************************************************************************
***      Minimizar el minimizar el tiempo total requerido por las     ***
***           máquinas para completar los cuatro trabajos.            ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201991676                  ***
*************************************************************************

Sets
  i   maquinas de la compañia / m1*m4 /
  j   trabajos de la compañia / t1*t4 /

Parameter  t(i,j)   tiempo;
t(i,j) = 999;
t('m1','t1') = 14;
t('m1','t2') = 5;
t('m1','t3') = 8;
t('m1','t4') = 7;
t('m2','t1') = 2;
t('m2','t2') = 12;
t('m2','t3') = 6;
t('m2','t4') = 5;
t('m3','t1') = 7;
t('m3','t2') = 8;
t('m3','t3') = 3;
t('m3','t4') = 9;
t('m4','t1') = 2;
t('m4','t2') = 4;
t('m4','t3') = 6;
t('m4','t4') = 10;

Variables
  a(i,j) Indica si el trabajo j le fue asignado a la máquina i
  z      Objective funtion;

Binary Variable a;

Equations
functionobj       Funcion objetivo
tiempoMaquina1    Tiempo de ejecución maquina 1
tiempoMaquina2    Tiempo de ejecución maquina 2
tiempoMaquina3    Tiempo de ejecución maquina 3
tiempoMaquina4    Tiempo de ejecución maquina 4
asignadoTarea1    Maquina a la que le fue asignada la tarea 1
asignadoTarea2    Maquina a la que le fue asignada la tarea 2
asignadoTarea3    Maquina a la que le fue asignada la tarea 3
asignadoTarea4    Maquina a la que le fue asignada la tarea 4;

functionobj                      ..      z =e= sum((i,j), t(i,j)*a(i,j));

tiempoMaquina1(i)$(ord(i) = 1)   ..      sum((j), a(i,j)) =e= 1;
tiempoMaquina2(i)$(ord(i) = 2)   ..      sum((j), a(i,j)) =e= 1;
tiempoMaquina3(i)$(ord(i) = 3)   ..      sum((j), a(i,j)) =e= 1;
tiempoMaquina4(i)$(ord(i) = 4)   ..      sum((j), a(i,j)) =e= 1;

asignadoTarea1(j)$(ord(j) = 1)   ..      sum((i), a(i,j)) =e= 1;
asignadoTarea2(j)$(ord(j) = 2)   ..      sum((i), a(i,j)) =e= 1;
asignadoTarea3(j)$(ord(j) = 3)   ..      sum((i), a(i,j)) =e= 1;
asignadoTarea4(j)$(ord(j) = 4)   ..      sum((i), a(i,j)) =e= 1;

Model Ejercicio1 /all/ ;
option mip=CPLEX
Solve Ejercicio1 using mip minimazing z;

Display t;
Display z.l;
Display a.l;
