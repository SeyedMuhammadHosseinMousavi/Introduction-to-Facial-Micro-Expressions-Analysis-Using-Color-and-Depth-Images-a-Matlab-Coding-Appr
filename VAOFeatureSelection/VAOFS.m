%% Victoria Amazonica Optimization (VAO) Feature Selection
% Developed by : Seyed Muhammad Hossein Mousavi - June 2023
% Related Paper:
% @article{mousavi2023victoria,
%   title={Victoria Amazonica Optimization (VAO): An Algorithm Inspired by the Giant Water Lily Plant},
%   author={Mousavi, Seyed Muhammad Hossein},
%   journal={arXiv preprint arXiv:2303.08070},
%   year={2023}
% }
%%----------------------------------------------------------------------------

clc;
clear;
close all;
warning('off');

%% Problem Definition
data=LoadData();
nf=7;   % Desired Number of Selected Features
CostFunction=@(u) FeatureSelectionCost(u,nf,data);        % Cost Function
nVar=data.nx;
VarSize = [1 nVar];   % Decision Variables Matrix Size
VarMin = -10;         % Decision Variables Lower Bound
VarMax = 10;         % Decision Variables Upper Bound

%% VAO Algorithm Parameters
MaxIt = 100;                  % Maximum Number of Iterations
nPop = 3;                    % Number of Plants (Leaf anf Flower (xi, ..., xn))
omega = 5;   % Drawback coefficient of ω 
psi = 4;     % Drawback coefficient of ψ 
lambda = 2;    % Intra Competition Rate of λ
mu = 0.2;                          % Mutation Coefficient of μ
mu_damp = 0.98;                    % Mutation Coefficient Damping Ratio
delta = 0.05*(VarMax-VarMin);      % Uniform Mutation Range
%-----------------------------------------
if isscalar(VarMin) && isscalar(VarMax)
dmax = (VarMax-VarMin)*sqrt(nVar);
else
dmax = norm(VarMax-VarMin);
end
%% Basics
% Empty Plants Structure
% Position = Plant place on the pond surface
% Cost = Plant Expansion Value in Diameter or ⌀
plants.Position = [];
plants.Cost = [];
plants.Sol = [];
% Initialize Population Array
pop = repmat(plants, nPop, 1);
% Initialize Best Solution Ever Found
BestSol.Cost = inf;
% Create Initial Plants
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost pop(i).Sol] = CostFunction(pop(i).Position);
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end;end
% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

%% VAO Algorithm Main Body
for it = 1:MaxIt
newpop = repmat(plants, nPop, 1);
for i = 1:nPop
newpop(i).Cost = inf;
for j = 1:nPop
if pop(j).Cost < pop(i).Cost
rij = norm(pop(i).Position-pop(j).Position)/dmax;
beta = psi*exp(-omega*rij^lambda);
e = delta*unifrnd(-1, +1, VarSize);
%-----------------
newsol.Position = pop(i).Position ...
+ beta*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
+ mu*e;
%-----------------
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
%-----------------
[newsol.Cost newsol.Sol] = CostFunction(newsol.Position);
%-----------------
if newsol.Cost <= newpop(i).Cost
newpop(i) = newsol;
if newpop(i).Cost <= BestSol.Cost
BestSol = newpop(i);
AllSol(i)=newpop(i);
end;end;end;end;end
% Merge
pop = [pop
newpop];  
% Sort
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);
% Truncate
pop = pop(1:nPop);
% Store Best Cost Ever Found
BestCost(it) = BestSol.Cost;
alpha=BestSol.Cost;
% Show Iteration Information
disp(['In Iteration No ' num2str(it) ': VAO Best Cost Is = ' num2str(BestCost(it))]);
% Damp Mutation Coefficient
mu = mu*mu_damp;
end

%% VAO Feature Matrix
% Extracting Data
RealData=data.x';
% Extracting Labels
RealLbl=data.t';
FinalFeaturesInd=BestSol.Sol.S;
% Sort Features
FFI=sort(FinalFeaturesInd);
% Select Final Features
VAO_Features=RealData(:,FFI);
% Adding Labels
VAO_Features_Lbl=VAO_Features;
VAO_Features_Lbl(:,end+1)=RealLbl;
VAOFinal=VAO_Features_Lbl;

%% Plot
figure;
plot(BestCost,'k','LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
ax = gca; 
ax.FontSize = 10; 
ax.FontWeight='bold';
grid on;
title(['VAO Best Cost is :  ',num2str(BestCost(it))])

