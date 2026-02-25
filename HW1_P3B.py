"""
EE 5393 - Circuits, Computation, and Biology
Homework 1 - Due 2/25/26
Grant Hietpas

Problem 3, Part B
This script tests my solution for a system of chemical reactions that executes
Y = 2^log2(X). It uses the simulation code in reaction_system.py to 
demonstrate this system. Please enter initial value x0 such that log2(x) is an 
integer, as the system can only represent output as integer number of molecules.

AI credit:
- all classes and syntax from reaction_system.py was written by ChatGPT
"""

from reaction_system import Reaction, ReactionSystem
import math

x0 = 32  # must be integer power of 2
y0 = 1  # required for exponentiation
state = {
    'x': x0,
    'y': y0,
    'al': 0,
    'c': 0,
    'x_prime': 0,
    'xl':0,
    'ae':0,
    'yl_prime':0,
}

reactions = [
    # logarithm xl = log2(x)
    Reaction(
        name='Rl1',
        reactants={'x': 2},
        products={'x': 2,'al': 1},
        priority=3
    ),
    Reaction(
        name='Rl2',
        reactants={'al': 1,'x': 2},
        products={'c': 1,'x_prime': 1,'al': 1},
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
        reactants={'x_prime': 1},
        products={'x': 1},
        priority=2
    ),
        Reaction(
        name='Rl6',
        reactants={'c': 1},
        products={'xl': 1},
        priority=2
    ),
    
    # exponentiation y = 2 ^ xl
    Reaction(
        name='Re1',
        reactants={'xl': 1},
        products={'ae': 1},
        priority=4
    ),
    Reaction(
        name='Re2',
        reactants={'ae': 1, 'y': 1},
        products={'ae': 1, 'y_prime': 2},
        priority=0
    ),
    Reaction(
        name='Re3',
        reactants={'ae': 1},
        products={},
        priority=1
    ),
    Reaction(
        name='Re4',
        reactants={'y_prime': 1},
        products={'y': 1},
        priority=2
    )
]

system = ReactionSystem(reactions)
final_state = system.run(state)

print("Final state:")
for k, v in final_state.items():
    print(f"  {k}: {v}")

y_expected = int(2 ** math.log2(x0))
print(f"\nExpected y = 2 ^ log2({x0}) = {y_expected}")
