%% Weevil Damage Optimization Algorithm (WDOA) Image Contrast Enhancement 
% Developed by : Seyed Muhammad Hossein Mousavi - June 2023
% WDOA paper:
% @article{mousavi2022weevil,
%   title={Weevil damage optimization algorithm and its applications},
%   author={Mousavi, S and Mirinezhad, S},
%   journal={Journal of Future Sustainability},
%   volume={2},
%   number={4},
%   pages={133--144},
%   year={2022}
% }
%%-------------------------------------------------------------------------

% Begin
clear;
clc;
close all;
warning('off');
% Loading
img=imread('test.jpg');
img=im2double(img);
gray=rgb2gray(img);
% Reshaping image to vector
X=gray(:);

%% Starting WDOA 
k = 6; 
CostFunction=@(m) ClusterCost(m, X);     % Cost Function
VarSize=[k size(X,2)];           % Decision Variables Matrix Size
nVar=prod(VarSize);              % Number of Decision Variables
VarMin= repmat(min(X),k,1);      % Lower Bound of Variables
VarMax= repmat(max(X),k,1);      % Upper Bound of Variables

%% WDOA Parameters
MaxIt = 100;                        % Maximum Number of Iterations
nPop = 10;                          % Number of weevils 

DamageRate = 0.3;                   % Damage Rate
nweevil = round(DamageRate*nPop);   % Number of Remained weevils
nNew = nPop-nweevil;                % Number of New weevils
mu = linspace(1, 0, nPop);          % Mutation Rates
pMutation = 0.1;                    % Mutation Probability
MUtwo = 1-mu;                       % Second Mutation
SnoutPower = 0.8;                   % Weevil Snout power Rate
FlyPower = 0.003;                   % Weevil Fly Power Rate
%----------------------------------------

%% Basics
% Empty weevil
weevil.Position = []; 
weevil.Cost = [];
% Weevils Array
pop = repmat(weevil, nPop, 1);
% First weevils
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
pop(i).Cost = CostFunction(pop(i).Position);
end;
% Sort 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);
% Best Solution
BestSol = pop(1);
% Best Costs Array
BestCost = zeros(MaxIt, 1);
%--------------------------------

%% WDOA Body
for it = 1:MaxIt
newpop = pop;
for i = 1:nPop
for k = 1:nVar
if rand <= MUtwo(i)
TMP = mu;TMP(i) = 0;TMP = TMP/sum(TMP);
j = RouletteWheelS(TMP);
newpop(i).Position(k) = pop(i).Position(k)+SnoutPower*(pop(j).Position(k)-pop(i).Position(k)+FlyPower);
end;
% Mutation
if rand <= pMutation
newpop(i).Position(k) = newpop(i).Position(k);
end;end;
% Apply Lower and Upper Bound Limits
newpop(i).Position = max(newpop(i).Position, VarMin);
newpop(i).Position = min(newpop(i).Position, VarMax);
newpop(i).Cost = CostFunction(newpop(i).Position);end;% Asses power
[~, SortOrder] = sort([newpop.Cost]);newpop = newpop(SortOrder);% Sort
pop = [pop(1:nweevil);newpop(1:nNew)];% Select 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);% Sort 
BestSol = pop(1);% Update 
BestCost(it) = BestSol.Cost;% Store 
% Iteration 
disp(['In Iteration No ' num2str(it) ': WDOA Best Cost = ' num2str(BestCost(it))]);
end;
% Plot
figure;
Thresh=sort(BestSol.Position);
Adj = imadjust(img,[Thresh(1) Thresh(2) Thresh(3); Thresh(4) Thresh(5) Thresh(6)]);
subplot(2,2,1);
imshow(img); title('Original');
subplot(2,2,2)
imshow(Adj,[]);title('WDOA Enhanced');
subplot(2,2,[3 4])
plot(BestCost,'k', 'LineWidth', 2);
title(['WDOA Best Cost is :  ',num2str(BestCost(it))])
xlabel('Iteration');
ylabel('Cost Value');
ax = gca; 
ax.FontSize = 10; 
ax.FontWeight='bold';
set(gca,'Color','c')
grid on;
