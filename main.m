tic % Begin measuring time of execution
clear variables

%% Method is demonstrated on a quadrotor optimization problem kept in a seperate respository
% The variables of the problem for each component are shown below, where
% * Intchoices means the variable is continuous
% * UB is the upper bound
% * LB is the lower bound
% * Tol is the minimum distinguishable feature or tolerance for continuous
% variables
% * MaxZones is the number of zones the continuous variable is represented
% by in the algorithm.

% BATTERY
batteryIntChoices = [6, 7, 4];
% MOTOR
motorIntChoices = [9]; %24 in total, restricting to 9
% PROPELLER
propIntChoices = [7];%, 12, 10, 10, 10, 10];
propUB=         [0.2,   45, 1,      0.02,   1];
propLB=         [0.02,  0,  0,      0.005,  0];
propTol=        [0.002, 1,  0.01,   0.0005, 0.01];
propMaxZones=[  5,     5,  5,     5,      5];
% ROD
rodIntChoices=[4];
rodUB=[0.006,0.0380,0.0380];
rodLB=[0.0009,0.0065,0.0065];
rodTol=[0.0001,0.0005,0.0005];
rodMaxZones=[5,5,5];
% ESC
escIntChoices=[6];
% SKID
skidIntChoices=[4];
skidUB=[60,0.0380,0.006];
skidLB=[20,0.0065,0.0009];
skidTol=[1,0.0005,0.0001];
skidMaxZones=[5,5,5];
% Oper
operUB=[30,45];
operLB=[0.1,0.1];
operTol=[1,1];
operMaxZones=[5,5];

%% In the method these variables must be given based on their type, so they
% are grouped here
Intchoices=[batteryIntChoices motorIntChoices propIntChoices rodIntChoices escIntChoices skidIntChoices];
UB=[propUB,rodUB,skidUB,operUB];
LB=[propLB,rodLB, skidLB,operLB];
Tol=[propTol,rodTol, skidTol,operTol];
MaxZones=[propMaxZones,rodMaxZones, skidMaxZones,operMaxZones];

%% In order to work with the quadrotor problem, the problem must be placed
% in a folder in the same directory as the algorithm. Since the problem
% calls an external function, the file path must be changed to that
% location as well using cd, but keeping the current directory as a path.
addpath('C:\Projects\GitHub\UAV_MAS_design\QuadrotorModel')
cd('C:\Projects\GitHub\UAV_MAS_design\QuadrotorModel')
addpath('C:\Projects\GitHub\UAV_MAS_design')
%addpath('C:\Users\HulseDanielE\Documents\GitHub\Multiagent_Opt\QuadrotorModel')
%cd('C:\Users\HulseDanielE\Documents\GitHub\Multiagent_Opt\QuadrotorModel')
%addpath('C:\Users\HulseDanielE\Documents\GitHub\Multiagent_Opt')

% funchandle is the handle for the objective function. This objective
% function should take integer and continuous variable vectors as arguments
% and return a objective+penalty obj, objective obj1, and constraint
% violation conviol. 
% [obj,obj1,conviol]=objcfun(x_int, x_cont)
% It is reccomended that conviol takes the form of  conviol=sum(g_i^2) to 
% adequately combine constraints.(Note that obj is not used in the algorithm)
funchandle=@objcfun;

% multiagent_opt optimizes the function, returning the optimum f_opt at
% integer variable values x_opt_int and continuous variable values
% x_opt_cont. Note that optimization history can be saved by setting an
% option in multiagent_opt to save history.
[f_opt,x_opt_int,x_opt_cont]=multiagent_opt(funchandle, Intchoices,UB,LB,Tol,MaxZones)

toc % Return execution time

