# -*- coding: utf-8 -*-
"""
Ejercicio 3: Problema de red de nodos

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
import math
from pyomo.core.base import param
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
nodos = 7

Model.i = RangeSet(1, nodos)

Model.nodosIntermedios = {1, 2, 5, 7}

Model.nodoDestino = {6}

dimensiones = 2

Model.d = RangeSet(1, dimensiones)

Model.j, Model.k = Model.i, Model.i

Model.coordenadas = {(1, 1): 20, (1, 2): 6,
                     (2, 1): 22, (2, 2): 1,
                     (3, 1): 9, (3, 2): 2,
                     (4, 1): 3, (4, 2): 25,
                     (5, 1): 21, (5, 2): 10,
                     (6, 1): 29, (6, 2): 2,
                     (7, 1): 14, (7, 2): 12}

Model.distancia = Param(Model.i, Model.j, mutable=True)

Model.conexion = 20

for i in Model.i:
    for j in Model.j:
        distancia = math.sqrt(math.pow(Model.coordenadas[i, 1]-Model.coordenadas[j, 1], 2) + math.pow(
            Model.coordenadas[i, 2]-Model.coordenadas[j, 1], 2))
        if distancia <= Model.conexion:
            Model.distancia[i, j] = distancia

# VARIABLES****************************************************************************
Model.x = Var(Model.i, Model.j, Model.nodosIntermedios, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr=sum(Model.x[i] for i in Model.N), sense=minimize)
