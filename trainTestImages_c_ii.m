% === Carregar conjuntos de dados ===
[inputsStart, targetsStart] = convertingStartImagesToBinaryMatrix();
[inputsTrain, targetsTrain] = convertingTrainImagesToBinaryMatrix();
[inputsTest, targetsTest] = convertingTestImagesToBinaryMatrix();


% carregar as melhores redes
load('alineaB_diferentRatios_Conf3.mat', 'net');
net1 = net;
load('alineaB_diferentTopo_Conf1.mat', 'net');
net2 = net;
load('alineaB_diferentFuncAtiv_Conf3.mat', 'net');
net3 = net;

% Lista com as redes
redes = {net1, net2, net3};
nomes = {'Rede 1', 'Rede 2', 'Rede 3'};

% === Para cada rede ===
for i = 1:length(redes)
    fprintf('\n--- %s ---\n', nomes{i});
    netAtual = redes{i};

    % == Treinar com dados da pasta TEST ==
    netAtual.divideParam.trainRatio = 0.7;
    netAtual.divideParam.valRatio = 0.15;
    netAtual.divideParam.testRatio = 0.15;

    [netAtual, tr] = train(netAtual, inputsTest, targetsTest);

    % === Avaliar com START ===
    outputsStart = netAtual(inputsStart);
    [~, predStart] = max(outputsStart);
    [~, trueStart] = max(targetsStart);
    accStart = sum(predStart == trueStart) / length(trueStart);
    fprintf('Precisão (start): %.2f%%\n', accStart * 100);

    % === Avaliar com TRAIN ===
    outputsTrain = netAtual(inputsTrain);
    [~, predTrain] = max(outputsTrain);
    [~, trueTrain] = max(targetsTrain);
    accTrain = sum(predTrain == trueTrain) / length(trueTrain);
    fprintf('Precisão (train): %.2f%%\n', accTrain * 100);

    % === Avaliar com TEST ===
    outputsTest = netAtual(inputsTest);
    [~, predTest] = max(outputsTest);
    [~, trueTest] = max(targetsTest);
    accTest = sum(predTest == trueTest) / length(trueTest);
    fprintf('Precisão teste (test): %.2f%%\n', accTest * 100);

    % === Matriz de confusão no conjunto test ===
    figure;
    plotconfusion(targetsTest, outputsTest);
    title(['Matriz de Confusão - ', nomes{i}, ' (TEST)']);
end



