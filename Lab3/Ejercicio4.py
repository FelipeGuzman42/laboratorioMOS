# -*- coding: utf-8 -*-
"""
Ejercicio 4: Problema específico de asignar canciones en un cassette.

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
canciones=8

N = RangeSet(1, canciones)

duracion={1:4, 2:5, 3:3, 4:2, 5:4, 6:3, 7:5, 8:4}

# VARIABLES****************************************************************************
Model.x = Var(N, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr = sum(Model.x[i] for i in N))

# CONSTRAINTS**************************************************************************
Model.tiempoInicial = Constraint(expr = sum(Model.x[i] * duracion[i] for i in N) >= 14)
Model.tiempoFinal = Constraint(expr = sum(Model.x[i] * duracion[i] for i in N) <= 16)
Model.cancionesBlues = Constraint(expr = Model.x[1] + Model.x[3] + Model.x[5] + Model.x[8] == 2)
Model.cancionesARock = Constraint(expr = Model.x[2] + Model.x[4] + Model.x[6] + Model.x[8] >= 3)
Model.cancion1No5LadoA = Constraint(expr = Model.x[1] + Model.x[5] >= 1)
Model.canciones24Atiene1B = Constraint(expr = Model.x[2] + Model.x[4] + Model.x[1] <= 2)
    
# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()
