%% Robot Navigation Project
% Data is obtained from UCI Machine Learning Repository.
%% Load and display the data
% Load unprocessed data (label is the action that should be taken, 
% sensor 1 is located front and sensor 2 is located left.)
load robotData.mat 

% Display sequence data using created function
displaySequence(sensor1,label)

displaySequence(sensor2,label)

%% Organize the sequence data
% To use Long Short-Term Memory (LSTM), data should be in a matrix.
% So while rows are sensor readings, columns must be time steps.
% Concatenate sensor readings
S = [sensor1 sensor2];

% Transpose S matrix to make columns time steps.
S = S';

% Transpose labels to make them a row vector
L = label';

%% Deep Learning Part
% Seperate the data for training and testing
n      = 1000;
STrain = S(:,1:end-n);
LTrain = L(1:end-n);
STest  = S(:,end-n+1:end);
LTest  = L(end-n+1:end);

% Create architecture of the neural network
layers = [ ...
    sequenceInputLayer(2)
    bilstmLayer(100,'OutputMode','sequence')
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer];

% Determine training options
options = trainingOptions('adam', ...
    'Plots','training-progress', ...
    'InitialLearnRate',0.03, ...
    'MaxEpochs',300);

% Train the LSTM network
net = trainNetwork(STrain,LTrain,layers,options);

%% Evaluation
% Calculate the accuracy
LPred = classify(net,STest);
acc   = nnz(LPred == LTest)/numel(LTest);

% Create and visualize confusion matrix 
[cmap,clabel] = confusionmat(LTest,LPred);
heatmap(clabel,clabel,cmap)
colormap jet

%% end