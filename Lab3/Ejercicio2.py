# -*- coding: utf-8 -*-
"""
Ejercicio 2: Problema de carga laboral 

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
dias = 7

Model.N = RangeSet(1, dias)

Model.diasLaborales = {(1, 1): 1, (1, 2): 0, (1, 3): 0, (1, 4): 1, (1, 5): 1, (1, 6): 1, (1, 7): 1,
                       (2, 1): 1, (2, 2): 1,  (2, 3): 0, (2, 4): 0, (2, 5): 1, (2, 6): 1, (2, 7): 1,
                       (3, 1): 1, (3, 2): 1, (3, 3): 1,  (3, 4): 0, (3, 5): 0, (3, 6): 1, (3, 7): 1,
                       (4, 1): 1, (4, 2): 1, (4, 3): 1, (4, 4): 1,  (4, 5): 0, (4, 6): 0, (4, 7): 1,
                       (5, 1): 1, (5, 2): 1, (5, 3): 1, (5, 4): 1, (5, 5): 1,  (5, 6): 0, (5, 7): 0,
                       (6, 1): 0, (6, 2): 1, (6, 3): 1, (6, 4): 1, (6, 5): 1, (6, 6): 1, (6, 7): 0,
                       (7, 1): 0, (7, 2): 0, (7, 3): 1, (7, 4): 1, (7, 5): 1, (7, 6): 1, (7, 7): 1}

Model.t = Param(Model.N, mutable=True)

Model.t[1] = 17
Model.t[2] = 13
Model.t[3] = 15
Model.t[4] = 19
Model.t[5] = 14
Model.t[6] = 16
Model.t[7] = 11

# VARIABLES****************************************************************************
Model.x = Var(Model.N, domain=PositiveReals)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr=sum(Model.x[i] for i in Model.N), sense=minimize)

# CONSTRAINTS**************************************************************************


def dias_semana(Model, i):
    return sum(Model.diasLaborales[i, j]*Model.x[j] for j in Model.N) >= Model.t[i]


Model.dias_semana = Constraint(Model.N, rule=dias_semana)

# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()
