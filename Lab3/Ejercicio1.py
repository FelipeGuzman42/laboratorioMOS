# -*- coding: utf-8 -*-
"""
Ejercicio 1: Problema de cobertura con tiempo máximo 

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
numPueblos=6

N = RangeSet(1, numPueblos)

costo={(1,1):0, (1,2):10, (1,3):20, (1,4):30, (1,5):30, (1,6):20,\
      (2,1):10, (2,2):0,  (2,3):25, (2,4):35, (2,5):20, (2,6):10,\
      (3,1):20, (3,2):25, (3,3):0,  (3,4):15, (3,5):30, (3,6):20,\
      (4,1):30, (4,2):35, (4,3):15, (4,4):0,  (4,5):15, (4,6):25,\
      (5,1):30, (5,2):20, (5,3):30, (5,4):15, (5,5):0,  (5,6):14,\
      (6,1):20, (6,2):10, (6,3):20, (6,4):25, (6,5):14, (6,6):0}

# VARIABLES****************************************************************************
Model.x = Var(N, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr = sum(Model.x[i] for i in N))

# CONSTRAINTS**************************************************************************
def cobertura_rule(Model,i):
    return sum(Model.x[j] for j in N if costo[i,j] <= 15) >= 1

Model.cobertura=Constraint(N, rule=cobertura_rule)
    
# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()
