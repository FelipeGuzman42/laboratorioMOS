# -*- coding: utf-8 -*-
"""
***      Multiobjective case Minimizing the number of hops            ***
***      in a directed graph using eConstraint                        ***
***      Authors: Felipe Guzmán Avendaño - 201813791                  ***
***               Juan Nicolás Bolaños   - 201911676                  ***
"""
from __future__ import division
from pyomo.environ import *
from pyomo.opt import SolverFactory
import matplotlib.pyplot as plt


# FUNCION ELIMINAR COMPONENTE
def delete_component(Model, comp_name):

    list_del = [vr for vr in vars(Model)
                if comp_name == vr
                or vr.startswith(comp_name + '_index')
                or vr.startswith(comp_name + '_domain')]

    list_del_str = ', '.join(list_del)
    print('Deleting model components ({}).'.format(list_del_str))

    for kk in list_del:
        Model.del_component(kk)

# MODEL ********************************************************************


# Configuraci�n Iteraciones----------------------------------------------------
numIteraciones = 2
iteraciones = range(numIteraciones)
w2_vec = []
for i in iteraciones:
    valorIter1 = i+2
    w2_vec.append(valorIter1)

w1 = 0
w2 = 0


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
nodos = 5

Model.N = RangeSet(1, nodos)

Model.h = {(1, 1): 999, (1, 2): 1, (1, 3): 1, (1, 4): 999, (1, 5): 999,
           (2, 1): 999, (2, 2): 999, (2, 3): 999, (2, 4): 999, (2, 5): 1,
           (3, 1): 999, (3, 2): 999, (3, 3): 999, (3, 4): 1, (3, 5): 999,
           (4, 1): 999, (4, 2): 999, (4, 3): 999, (4, 4): 999, (4, 5): 1,
           (5, 1): 999, (5, 2): 999, (5, 3): 999, (5, 4): 999, (5, 5): 999}

Model.c = {(1, 1): 999, (1, 2): 10, (1, 3): 5, (1, 4): 999, (1, 5): 999,
           (2, 1): 999, (2, 2): 999, (2, 3): 999, (2, 4): 999, (2, 5): 10,
           (3, 1): 999, (3, 2): 999, (3, 3): 999, (3, 4): 5, (3, 5): 999,
           (4, 1): 999, (4, 2): 999, (4, 3): 999, (4, 4): 999, (4, 5): 5,
           (5, 1): 999, (5, 2): 999, (5, 3): 999, (5, 4): 999, (5, 5): 999}

# VARIABLES****************************************************************************

Model.x = Var(Model.N, Model.N, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************

#Model.f1 = sum(Model.h[i, j]*Model.x[i, j] for i in Model.N for j in Model.N)

Model.f2 = sum(Model.c[i, j]*Model.x[i, j] for i in Model.N for j in Model.N)

#Model.obj = Objective(expr=Model.f2)


f1_vec = []
f2_vec = []
for k in w2_vec:

    # Funci�n objetivo general
    Model.O_z = Objective(expr=Model.f2, sense=minimize)

    # CONSTRAINTS**************************************************************************

    def econstraint(Model, i):
        return sum(Model.x[i, j] * Model.h[i, j] for i in Model.N for j in Model.N) <= k

    def source_rule(Model, i):
        if i == 1:
            return sum(Model.x[i, j] for j in Model.N) == 1
        else:
            return Constraint.Skip

    def destination_rule(Model, j):
        if j == 5:
            return sum(Model.x[i, j] for i in Model.N) == 1
        else:
            return Constraint.Skip

    def intermediate_rule(Model, i):
        if i != 1 and i != 5:
            return sum(Model.x[i, j] for j in Model.N) - sum(Model.x[j, i] for j in Model.N) == 0
        else:
            return Constraint.Skip

    Model.f1 = Constraint(Model.N, rule=econstraint)
    Model.source = Constraint(Model.N, rule=source_rule)
    Model.destination = Constraint(Model.N, rule=destination_rule)
    Model.intermediate = Constraint(Model.N, rule=intermediate_rule)

    SolverFactory('glpk').solve(Model)

    #valorF1 = value(Model.f1)
    valorF2 = value(Model.f2)
    # f1_vec.append(valorF1)
    f2_vec.append(valorF2)

    delete_component(Model, 'O_z')
    delete_component(Model, 'source')
    delete_component(Model, 'destination')
    delete_component(Model, 'intermediate')

plt.plot(w2_vec, f2_vec, 'o-.')
plt.title('Frente �ptimo de Pareto')
plt.xlabel('Hops')
plt.ylabel('Costo')

plt.grid(True)
plt.show()
