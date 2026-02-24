%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 5393 - Circuits, Computation, and Biology
% Homework 1 - Due 2/25/26
% Grant Hietpas
% 
% Problem 1
% Stochastic simulation code written for problem 1. Code was written from
% scratch to more easily extract process states throughout simulations.
% Note: this code only works for the set of reactions provided in problem
% 1, although I'm hoping the principles can be expanded for problem 3. All
% code was written by me (Grant Hietpas) unless listed in the "AI Credit"
% section below.
% 
% AI Credit:
%   - random reaction selection mechanism
%   - while loop implementation
%   - part a outcome storage and processing
%   - part b post processing
%   - debugging
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

%% Part A
disp('---------- PART A ----------')

N = 1000;  % number of trials
C = false(N,3);  % preallocate outcome storage

for i = 1:N

    % define starting state 
    x = [110,26,55];  % [x1_i, x2_i, x3_i]
    
    % conduct stochaistic sim, ending if outcomes C1,C2,C3 are met
    while ~( x(1) >= 150 || x(2) < 10 || x(3) > 100 )
        % execute single step of stochastic sim
        % while loop checks end conditions automatically
        x = p1_rxns_stoch_step(x);
    end
    
    % check which outcome(s) were reached
    C1 = (x(1) >= 150);
    C2 = (x(2) < 10);
    C3 = (x(3) > 100);

    % store end condition data
    C(i,:) = [C1, C2, C3];

end

% post processing: get P(C1), P(C2), P(C3)
P_C1 = mean(C(:,1));
P_C2 = mean(C(:,2));
P_C3 = mean(C(:,3));

% print results
disp('P(C1) = ' + string(round(P_C1,4)))
disp('P(C2) = ' + string(round(P_C2,4)))
disp('P(C3) = ' + string(round(P_C3,4)))

%% Part B
disp('---------- PART B ----------')

X = zeros(N,3);  % preallocate final state storage

for ii = 1:N

    x = [9,8,7];  % starting state
    counter = 7;  % reset counter
    
    % carry out stochastic sim
    while counter > 0
        x = p1_rxns_stoch_step(x);
        counter = counter - 1;
    end

    % store final state
    X(ii,:) = x;

end

% post processing: get mean and variance of each final concentration
mu = round(mean(X, 1),3);   % [mean_x1,mean_x2,mean_x3]
sigma = round(std(X, 0, 1),3);  % standard deviation [σ_x1,σ_x2,σ_x3]

% print results
fprintf('x1: mean amount = %.3f, standard deviation = %.3f \n',mu(1),sigma(1))
fprintf('x2: mean amount = %.3f, standard deviation = %.3f \n',mu(2),sigma(2))
fprintf('x3: mean amount = %.3f, standard deviation = %.3f \n',mu(3),sigma(3))

%% Function: single step in stochastic sim

function state_f = p1_rxns_stoch_step(state_i)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % performs a single step in the stochastic simulation of the system of
    % reactions described by problem 1 of the homework, which are:
    % 
    % R1: 2X1 +  X2 → 4X3  k1 = 1
    % R2:  X1 + 2X3 → 3X2  k2 = 2
    % R3:  X2 +  X3 → 2X1  k3 = 3
    % 
    % Input: state_i 
    % array with struture [x1,x2,x3] containing "concentrations" of
    % reactants X1, X2, X3, i.e. the state of the system
    % 
    % outputs: state_f
    % array (see above) containing state of system after the next reaction
    % has executed
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % extract individual concentrations
    x1 = state_i(1);
    x2 = state_i(2);
    x3 = state_i(3);
    
    % failed: error when N<K (instead should set to 0)
        % % define reaction rate consts
        % k1 = 1;  
        % k2 = 2;
        % k3 = 3;
        % % compute rxn probabilites according to Gillespie's framework
        % a1 = k1 * nchoosek(x1,2) * nchoosek(x2,1);  % R1
        % a2 = k2 * nchoosek(x1,1) * nchoosek(x3,2);  % R2
        % a3 = k3 * nchoosek(x2,1) * nchoosek(x3,1);  % R3
    
    % redo: compute rxn probabilities using given formulas
    a1 = 0.5 * x1 * (x1 -1) * x2;  % R1
    a2 = x1 * x3 * (x3-1);  % R2
    a3 = 3 * x2 * x3;  % R3
    a = [a1,a2,a3];
    P = a / sum(a);  % [P(R1),P(R2),P(R3)]

    % choose a reaction and alter state concentrations accordingly
    r = rand;  % Random draw [0,1]
    cp = cumsum(P);  % Cumulative probabilities    
    if r < cp(1)  
        % R1
        x1 = x1 - 2;
        x2 = x2 - 1;
        x3 = x3 + 4;
    elseif r < cp(2)
        % R2
        x1 = x1 - 1;
        x3 = x3 - 2;
        x2 = x2 + 3;
    else
        % R3
        x2 = x2 - 1;
        x3 = x3 - 1;
        x1 = x1 + 2;
    end
    
    % return updated state
    state_f = [x1,x2,x3];
end