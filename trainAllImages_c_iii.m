clear; clc;
% Carregar os dados 
[inputsparaStart, targetsparaStart] = convertingStartImagesToBinaryMatrix();
[inputsparaTrain, targetsparaTrain] = convertingTrainImagesToBinaryMatrix();
[inputsparaTeste, targetsparaTeste] = convertingTestImagesToBinaryMatrix();

% Juntar todos os dados 
inputsAll = [inputsparaStart, inputsparaTrain, inputsparaTeste];
targetsAll = [targetsparaStart, targetsparaTrain, targetsparaTeste];

% carregar as melhores redes
load('alineaB_diferentRatios_Conf3.mat', 'net');
net1 = net;
load('alineaB_diferentTopo_Conf1.mat', 'net');
net2 = net;
load('alineaB_diferentFuncAtiv_Conf3.mat', 'net');
net3 = net;

% Lista com as redes e nomes
redes = {net1, net2, net3};
nomes = {'Rede 1', 'Rede 2', 'Rede 3'};

% Para cada uma das redes 
for i = 1:length(redes)
    fprintf('\n--- %s ---\n', nomes{i});
    netAtual = redes{i};

    % Configurar divisão dos dados (mesmo que seja todos juntos)
    netAtual.divideParam.trainRatio = 0.8;
    netAtual.divideParam.valRatio = 0.1;
    netAtual.divideParam.testRatio = 0.1;

    % Treinar com todos os dados 
    [netAtual, tr] = train(netAtual, inputsAll, targetsAll);

    % AVALIAÇÃO GLOBAL 
    outputsAll = netAtual(inputsAll);
    [~, predAll] = max(outputsAll);
    [~, trueAll] = max(targetsAll);
    accGlobal = sum(predAll == trueAll) / length(trueAll);
    fprintf('Precisão GLOBAL: %.2f%%\n', accGlobal * 100);

    % classificar 'start' 
    outputsStart = netAtual(inputsparaStart);
    [~, predStart] = max(outputsStart);
    [~, trueStart] = max(targetsparaStart);
    accStart = sum(predStart == trueStart) / length(trueStart);
    fprintf('Precisão START: %.2f%%\n', accStart * 100);

    % classificar 'train' 
    outputsTrain = netAtual(inputsparaTrain);
    [~, predTrain] = max(outputsTrain);
    [~, trueTrain] = max(targetsparaTrain);
    accTrain = sum(predTrain == trueTrain) / length(trueTrain);
    fprintf('Precisão TRAIN: %.2f%%\n', accTrain * 100);

    % classificar 'test' 
    outputsTest = netAtual(inputsparaTeste);
    [~, predTest] = max(outputsTest);
    [~, trueTest] = max(targetsparaTeste);
    accTest = sum(predTest == trueTest) / length(trueTest);
    fprintf('Precisão TEST: %.2f%%\n', accTest * 100);

    % Matriz de Confusão (GLOBAL)
    figure;
    plotconfusion(targetsAll, outputsAll);
    title(['Matriz de Confusão - ', nomes{i}, ' (GLOBAL)']);


    % Gravar rede com precisão de teste
    filename = sprintf('rede_top_%02d_%s.mat', round(accTest * 100), datestr(now,'HHMMSS'));
    net = netAtual;
    save(filename, 'net');    
    fprintf('Rede guardada como "%s" com %.2f%% de precisão de teste.\n', filename, accTest * 100);
end