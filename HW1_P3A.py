"""
EE 5393 - Circuits, Computation, and Biology
Homework 1 - Due 2/25/26
Grant Hietpas

Problem 3, Part A
This script tests my solution for a system of chemical reactions that executes
Z = X * log2(Y). It uses the simulation code in reaction_system.py to 
demonstrate this system. Please enter initial value y0 such that log2(y) is an 
integer, as the system can only represent output as integer number of molecules.

AI credit:
- all classes and syntax from reaction_system.py was written by ChatGPT
- rxn system was designed by me, with one minor alteration from AI (see
  submission file for details)
"""

from reaction_system import Reaction, ReactionSystem
import math

x0 = 17
y0 = 128  # must be integer power of 2
state = {
    'x': x0,
    'y': y0,
    'al': 0,
    'c': 0,
    'y_prime': 0,
    'yl':0,
    'am':0,
    'yl_prime':0,
    'z':0
}

reactions = [
    # logarithm yl = log2(y)
    Reaction(
        name='Rl1',
        reactants={'y': 2},
        products={'y': 2,'al': 1},
        priority=3
    ),
    Reaction(
        name='Rl2',
        reactants={'al': 1,'y': 2},
        products={'c': 1,'y_prime': 1,'al': 1},
        priority=0
    ),
    Reaction(
        name='Rl3',
        reactants={'c': 2},
        products={'c': 1},
        priority=0
    ),
    Reaction(
        name='Rl4',
        reactants={'al': 1},
        products={},
        priority=1
    ),
        Reaction(
        name='Rl5',
        reactants={'y_prime': 1},
        products={'y': 1},
        priority=2
    ),
        Reaction(
        name='Rl6',
        reactants={'c': 1},
        products={'yl': 1},
        priority=2
    ),
    
    # multiplication z = x * yl
    Reaction(
        name='Rm1',
        reactants={'x': 1},
        products={'am': 1},
        priority=4
    ),
    Reaction(
        name='Rm2',
        reactants={'am': 1, 'yl': 1},
        products={'am': 1, 'yl_prime': 1,'z':1},
        priority=0
    ),
    Reaction(
        name='Rm3',
        reactants={'am': 1},
        products={},
        priority=1
    ),
    Reaction(
        name='Rm4',
        reactants={'yl_prime': 1},
        products={'yl': 1},
        priority=2
    ),
]

system = ReactionSystem(reactions)
final_state = system.run(state)

print("Final state:")
for k, v in final_state.items():
    print(f"  {k}: {v}")

z_expected = int(x0 * math.log2(y0))
print(f"\nExpected z = {x0} * log2({y0}) = {z_expected}")