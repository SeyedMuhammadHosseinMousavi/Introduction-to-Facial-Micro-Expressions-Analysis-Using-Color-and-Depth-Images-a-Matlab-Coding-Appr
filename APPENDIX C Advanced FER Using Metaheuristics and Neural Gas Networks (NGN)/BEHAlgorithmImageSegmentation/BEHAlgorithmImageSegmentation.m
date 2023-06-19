%% Bee-Eater Hunting (BEH) Strategy Algorithm for Image Segmentation and Quantization
% Developed by : Seyed Muhammad Hossein Mousavi - June 2023
% BEH Algorithm Paper:
% @inproceedings{mousavi2022introducing,
%   title={Introducing Bee-Eater Hunting Strategy Algorithm for IoT-Based Green House Monitoring and Analysis},
%   author={Mousavi, Seyed Muhammad Hossein},
%   booktitle={2022 Sixth International Conference on Smart Cities, Internet of Things and Applications (SCIoT)},
%   pages={1--6},
%   year={2022},
%   organization={IEEE}
% }
%%-------------------------------------------------------------------
clear;
clc;
close all;
warning('off');
img=imread('test2.jpg');
img=im2double(img);
gray=rgb2gray(img);
gray=imadjust(gray);
warning ('off');
% Separating color channels
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
% Reshaping each channel into a vector and combine all three channels
X=[R(:) G(:) B(:)];

%% Starting BEH 
k = 5; % Number of Colors (segments)
%---------------------------------------------------
CostFunction=@(m) ClusterCost(m, X);     % Cost Function
VarSize=[k size(X,2)];           % Decision Variables Matrix Size
nVar=prod(VarSize);              % Number of Decision Variables
VarMin= repmat(min(X),k,1);      % Lower Bound of Variables
VarMax= repmat(max(X),k,1);      % Upper Bound of Variables
MaxIt = 200;                           % Maximum Number of Iterations
nPop = 20;                             % Number of bee-eaters 
DamageRate = 0.2;                      % Damage Rate
nbeeeater = round(DamageRate*nPop);    % Number of Remained beeeaters
nNew = nPop-nbeeeater;                 % Number of New beeeaters
mu = linspace(1, 0, nPop);             % Mutation Rates
pMutation = 0.1;                       % Mutation Probability
MUtwo = 1-mu;                          % Fight Mutation
PeakPower = 0.8;                       % BeeEater Peack power Rate
AdjustPower = 0.03*(VarMax-VarMin);    % BeeEater Adjustment Power Rate
PYR= -0.2;                             % Pitch Yaw Roll Rate
%----------------------------------------
%% Basics
% Empty bee-eater
beeeater.Position = []; 
beeeater.Cost = [];
% BeeEaters Array
pop = repmat(beeeater, nPop, 1);
% First bee-eaters
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost pop(i).Out] = CostFunction(pop(i).Position);end;
% Sort 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);
% Best Solution
BestSol = pop(1);
% Best Costs Array
BestCost = zeros(MaxIt, 1);
%--------------------------------
%% BEH Body
for it = 1:MaxIt
newpop = pop;
for i = 1:nPop
for k = 1:nVar
if rand <= MUtwo(i)
TMP = mu;TMP(i) = 0;TMP = TMP/sum(TMP);
j = RouletteWheelS(TMP);
newpop(i).Position(k) = pop(i).Position(k)*PYR+PeakPower*(pop(j).Position(k)-pop(i).Position(k));
end;
% Mutation
if rand <= pMutation
newpop(i).Position(k) = newpop(i).Position(k)+PYR;
end;end;
% Apply Lower and Upper Bound Limits
newpop(i).Position = max(newpop(i).Position, VarMin);
newpop(i).Position = min(newpop(i).Position, VarMax);
[newpop(i).Cost newpop(i).Out] = CostFunction(newpop(i).Position+AdjustPower);end;% Asses power
[~, SortOrder] = sort([newpop.Cost]);newpop = newpop(SortOrder);% Sort
pop = [pop(1:nbeeeater);newpop(1:nNew)];% Select 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);% Sort 
BestSol = pop(1);% Update 
BestCost(it) = BestSol.Cost;% Store 
% Iteration 
disp(['In Iteration No ' num2str(it) ': BeeEater Optimizer Best Cost = ' num2str(BestCost(it))]);
BEHCenters=Res(X, BestSol);
end;
BEHlbl=BestSol.Out.ind;
%% Converting cluster centers and its indexes into image 
Z=BEHCenters(BEHlbl',:);
R2=reshape(Z(:,1),size(R));
G2=reshape(Z(:,2),size(G));
B2=reshape(Z(:,3),size(B));
% Attaching color channels (BEH Quantization Result)
quantized=zeros(size(img));
quantized(:,:,1)=R2;
quantized(:,:,2)=G2;
quantized(:,:,3)=B2;
% BEH Segmentation Result
gray2=reshape(BEHlbl(:,1),size(gray));
segmented = label2rgb(gray2); 
%% Plot Results 
figure;
subplot (2,2,1)
imshow(img);title('Original');
subplot (2,2,2)
imshow(quantized);title('Quantized Image');
subplot(2,2,3);
imshow(segmented,[]);title('Segmented Image');
subplot(2,2,4);
plot(BestCost,'k','LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
title(['BEH Best Cost is :  ',num2str(BestCost(it))])
ax = gca; 
ax.FontSize = 10; 
ax.FontWeight='bold';
set(gca,'Color','c')
grid on;


