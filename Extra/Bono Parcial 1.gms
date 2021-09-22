*************************************************************************
***      Implementación modelo genérico del problema de la dieta      ***
***                                                                   ***
***                                                                   ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201991676                  ***
*************************************************************************

Sets
  i   Alimentos de la dieta / a1*a4 /
  j   Nutrientes / n1*n5 /

Parameter
n(i,j) contenido nutricional
c(i) costo alimento
x(j) valores recomendados dieta
;

n(i,j)= 999;
n('a1','n1') = 287;
n('a1','n2') = 26;
n('a1','n3') = 0;
n('a1','n4') = 19.3;
n('a1','n5') = 0;
n('a2','n1') = 204;
n('a2','n2') = 4.2;
n('a2','n3') = 0.01;
n('a2','n4') = 0.5;
n('a2','n5') = 44.1;
n('a3','n1') = 146;
n('a3','n2') = 8;
n('a3','n3') = 13;
n('a3','n4') = 8;
n('a3','n5') = 11;
n('a4','n1') = 245;
n('a4','n2') = 6;
n('a4','n3') = 25;
n('a4','n4') = 0.8;
n('a4','n5') = 55;

c(i) = 999;
c('a1') = 3000;
c('a2') = 1000;
c('a3') = 600;
c('a4') = 700;

x('n1') = 1500;
x('n2') = 63;
x('n3') = 25;
x('n4') = 50;
x('n5') = 200;


Variables
   a(i) indica la cantidad de porciones para un alimento i
   z    objective function
;

Positive Variable a;

Equations
objectivefunction        objective function
calorias                 calorias
proteinas                proteinas
azucares                 azucares
grasas                   grasas
carbohidratos            carbohidratos
;

objectiveFunction                ..  z =e= sum((i), c(i)*a(i));

calorias(j)$(ord(j) = 1)         ..  sum((i), n(i,j)*a(i)) =g=x(j);

proteinas(j)$(ord(j) = 2)        ..  sum((i), n(i,j)*a(i)) =g=x(j);

azucares(j)$(ord(j) = 3)         ..  sum((i), n(i,j)*a(i)) =l=x(j);

grasas(j)$(ord(j) = 4)           ..  sum((i), n(i,j)*a(i)) =l=x(j);

carbohidratos(j)$(ord(j) = 5)    ..  sum((i), n(i,j)*a(i)) =l=x(j);


Model model1 /all/ ;
option lp=CPLEX
Solve model1 using lp minimizing z;


Display z.l;
Display n;
Display c;
Display a.l;
