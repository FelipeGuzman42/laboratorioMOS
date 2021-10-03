*************************************************************************
***      Ejercicio 1, problema de multiprocesamiento con              ***
***                   distintos tipos de proceso                      ***
***                                                                   ***
***      Authors: Felipe Guzm�n Avenda�o - 201813791              ***
***               Juan Nicol�s Bola�os   - 201911676              ***
*************************************************************************

Sets
  i   procesadores origen / o1*o3 /
  j   procesadores destino / d1*d2 /

Table  c(i,j)   costo
         d1    d2
o1       300   500
o2       200   300
o3       600   300

Parameter
ok(i) cantidad de origen kernel / o1 60, o2 80, o3 50 /
ou(i) cantidad de origen usuario / o1 80, o2 50, o3 50 /
dk(j) cantidad de destino kernel /d1 100, d2 90 /
du(j) cantidad de destino usuario /d1 60, d2 120 /;


Variables
  u(i,j)      Procesos usuario enviados de i a j
  k(i,j)      Procesos kernel enviados de i a j
  z           Objective function;

Positive Variable u;
Positive Variable k;

Equations
funcionObj               Funcion Objetivo

restriccionOrigenU        procesador origen usuario
restriccionOrigenK        procesador origen kernel
restriccionDestinoU       procesador destino usuario
restriccionDestinoK       procesador destino kernel;


funcionObj                       ..  z =e= sum((i,j), c(i,j) * (k(i,j) + k(i,j)));

restriccionOrigenU(i)            ..  sum(j, u(i,j)) =e= ou(i);
restriccionOrigenK(i)            ..  sum(j, k(i,j)) =e= ok(i);
restriccionDestinoU(j)           ..  sum(i, u(i,j)) =e= du(j);
restriccionDestinoK(j)           ..  sum(i, k(i,j)) =e= dk(j);


Model Ejercicio1 /all/ ;
option mip=CPLEX
Solve Ejercicio1 using mip minimazing z;

Display c;
Display z.l;
Display u.l;
Display k.l;
