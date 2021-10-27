# -*- coding: utf-8 -*-
"""
Ejercicio 3: Problema de red de nodos

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
import math
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
nodos = 6

N = RangeSet(0, nodos)

Model.coordenadas = {(1, 1): 20, (1, 2): 6,
                     (2, 1): 22, (2, 2): 1,
                     (3, 1): 9, (3, 2): 2,
                     (4, 1): 3, (4, 2): 25,
                     (5, 1): 21, (5, 2): 10,
                     (6, 1): 29, (6, 2): 2,
                     (7, 1): 14, (7, 2): 12}

distancia = [[0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0]]

Model.conexion = 20

for i in N:
    for j in N:
        distanciaPre = math.sqrt((Model.coordenadas[i+1, 1]-Model.coordenadas[j+1, 1])**2 + (
            Model.coordenadas[i+1, 2]-Model.coordenadas[j+1, 2])**2)
        if distanciaPre <= Model.conexion and distanciaPre != 0:
            distancia[i][j] = distanciaPre
        else:
            distancia[i][j] = 999

print(distancia)

# VARIABLES****************************************************************************
Model.x = Var(N, N, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(
    expr=sum(Model.x[i, j]*distancia[i][j] for i in N for j in N))

# CONSTRAINTS**************************************************************************


def source_rule(Model, i):
    if i == 3:
        return sum(Model.x[i, j] for j in N) == 1
    else:
        return Constraint.Skip


def destination_rule(Model, j):
    if j == 5:
        return sum(Model.x[i, j] for i in N) == 1
    else:
        return Constraint.Skip


def intermediate_rule(Model, i):
    if i != 3 and i != 5:
        return sum(Model.x[i, j] for j in N) - sum(Model.x[j, i] for j in N) == 0
    else:
        return Constraint.Skip


Model.source = Constraint(N, rule=source_rule)
Model.destination = Constraint(N, rule=destination_rule)
Model.intermediate = Constraint(N, rule=intermediate_rule)

# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()
Model.x
