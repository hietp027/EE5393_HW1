%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 5393 - Circuits, Computation, and Biology
% Homework 1 - Due 2/25/26
% Grant Hietpas
% 
% Problem 2
% Simple script to process and display data from provided stochastic
% simulation code (specfically the lambda reaction set). Data was obtained
% by repeatedly running aleae code and copying results over manually.
% 
% AI Credit:
%   - none (it's a really simple script)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

N = 100;  % number of trials per MOI experiment

% stochastic sim results
% [MOI initial, # steath mode outcomes (cI2>145), # hijack mode outcomes (Cro2>55)]
data = [1 20 80  
        2 20 80
        3 26 74
        4 18 82
        5 27 73
        6 32 68
        7 34 66
        8 42 58
        9 26 74
       10 37 63];

% convert outcomes to probabilities
data_probs = [data(:,1) , data(:,2:3) .* (1/N)];

% plot results
figure Color 'white'
hold on
plot(data_probs(:,1),data_probs(:,2),'DisplayName','stealth (cI2 > 145)','LineWidth',1.5)
plot(data_probs(:,1),data_probs(:,3),'DisplayName','hijack (Cro2 > 55)','LineWidth',1.5)
xlabel('initial MOI amount')
ylabel('outcome probability')
ylim([0,1])
legend
set(gca,'FontSize',14)