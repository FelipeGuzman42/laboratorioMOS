# -*- coding: utf-8 -*-
"""
Proyecto  '30 minutos o es gratis'

@authors: Felipe Guzmán Avendaño - 201813791
          Juan Nicolás Bolaños - 201911676 
"""
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
nodos = 9
pedidos = 3
P = 2

N = RangeSet(1, nodos)

# Coordenadas de los nodos
Model.coordenadas = {(1, 1): 0, (1, 2): 0,
                     (2, 1): 5, (2, 2): 0,
                     (3, 1): 10, (3, 2): 0,
                     (4, 1): 0, (4, 2): 5,
                     (5, 1): 5, (5, 2): 5,
                     (6, 1): 10, (6, 2): 5,
                     (7, 1): 0, (7, 2): 10,
                     (8, 1): 5, (8, 2): 10,
                     (9, 1): 10, (9, 2): 10}

# Nodo que tiene el pedido
nodoPedido = {6, 7, 9}

# Nodo de la pizzeria
nodoPizzeria = 1

# Número de motos
motos = RangeSet(1, P)

# Representa los arcos presentes en el grafo y su distancia
Model.distancia = Param(N, N, mutable=True)

for i in N:
    for j in N:
        Model.distancia[i, j] = 999

Model.distancia[1, 2] = 5
Model.distancia[2, 3] = 5
Model.distancia[2, 7] = 5
Model.distancia[1, 4] = 5
Model.distancia[1, 5] = 10
Model.distancia[3, 6] = 5
Model.distancia[5, 6] = 5
Model.distancia[4, 8] = 10
Model.distancia[5, 8] = 5
Model.distancia[7, 8] = 5
Model.distancia[8, 9] = 5

# Cantidad de pizzas que lleva la moto
Model.r = 2

# Cantidad de minutos que se puede demorar el pedido
Model.t = 30

# VARIABLES****************************************************************************
# Representa si el camino i,j es escogido por la moto m a algun destino
Model.x = Var(N, N, motos, nodoPedido, domain=Binary)

# Representa la cantidad de pizzas que carga una moto i cuando sale de la pizzería
Model.k = Var(motos, domain=PositiveIntegers)

# OBJECTIVE FUNCTION*******************************************************************
# Se quiere minimizar el número de motos escogidas para realizar los pedidos
Model.obj = Objective(expr=sum(Model.x[i, j, m, p]*Model.distancia[i, j]
                               for i in N for j in N for m in motos for p in nodoPedido))

# CONSTRAINTS**************************************************************************

# La carga de cualquier moto no debe exceder r


def payload_rule(Model, i):
    return Model.k[i] <= Model.r

# Los pedidos deben ser entregados en un tiempo menor a t


def time_rule(Model):
    return sum(Model.x[i, j, m, p]*Model.distancia[i, j]
               for i in N for j in N for m in motos for p in nodoPedido) <= Model.t

# El número de pedidos no debe sobrepasar la capacidad del restaurante de entregarlos (r*P)


def capacity_rule(Model):
    return Model.r*P >= pedidos

# Solamente debe haber una pizzería en el grafo


def source_rule(Model, i, m):
    if i == nodoPizzeria:
        return sum(Model.x[i, j, m, p] for j in N for p in nodoPedido) == 1
    else:
        return Constraint.Skip

# Para cada pedido del restaurante debe haber un nodo en el grafo que represente el lugar de entrega


def destination_rule(Model, m):
    if j in nodoPedido:
        return sum(Model.x[i, j, m, p] for i in N for p in nodoPedido) == 1
    else:
        return Constraint.Skip

#  No debe haber nodos repetidos en las ramas para cada camino escogido por las motos


def intermediate_rule(Model, i):
    if i != nodoPizzeria and i not in nodoPedido:
        return sum(Model.x[i, j, m, p] for j in N for m in motos for p in nodoPedido) - sum(Model.x[j, i, m, p] for j in N for m in motos for p in nodoPedido) == 0
    else:
        return Constraint.Skip


Model.payload = Constraint(motos, rule=payload_rule)
Model.time = Constraint(rule=time_rule)
#Model.capacity = Constraint(rule=capacity_rule)
#Model.source = Constraint(N, motos, rule=source_rule)
#Model.destination = Constraint(N, rule=destination_rule)
#Model.intermediate = Constraint(N, rule=intermediate_rule)

# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()
