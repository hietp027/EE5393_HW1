"""
TEST file:
Y = log2(X)

Written entirely by me (Grant Hietpas), using syntax and 
simulation classes taken from reaction_system.py (AI generated)
"""

from reaction_system import Reaction, ReactionSystem
import math

x0 = 8  # MUST BE INTEGER POWER OF 2
state = {
    'x': x0,
    'a': 0,
    'c': 0,
    'x_prime':0,
    'y': 0
}

reactions = [
    Reaction(
        name='R1',
        reactants={},
        products={'a': 1},
        priority=3
    ),
    Reaction(
        name='R2',
        reactants={'a': 1,'x': 2},
        products={'c': 1,'x_prime': 1,'a': 1},
        priority=0
    ),
    Reaction(
        name='R3',
        reactants={'c': 2},
        products={'c': 1},
        priority=0
    ),
    Reaction(
        name='R4',
        reactants={'a': 1},
        products={},
        priority=1
    ),
        Reaction(
        name='R5',
        reactants={'x_prime': 1},
        products={'x': 1},
        priority=2
    ),
        Reaction(
        name='R6',
        reactants={'c': 1},
        products={'y': 1},
        priority=2
    )
]

system = ReactionSystem(reactions)
final_state = system.run(state)

print("Final state:")
for k, v in final_state.items():
    print(f"  {k}: {v}")

# expected result
y_expected = int(math.log2(x0))
print(f"\nExpected y = log2({x0}) = {y_expected}")