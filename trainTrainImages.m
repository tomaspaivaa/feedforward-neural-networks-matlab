[inputsParaTrain, targetsParaTrain] = convertingTrainImagesToBinaryMatrix();

% Configuração da Rede 
topologia = 20;                 % Exemplo: 2 camadas escondidas
funcAtivacao = 'tansig';               % Exemplo: função de ativação
funcTreino = 'trainlm';                % Exemplo: função de treino
ratios = [70 15 15];                   % [treino, validação, teste] 

fprintf('\nTopologia: [%s]\n', num2str(topologia));
fprintf('Função de treino: %s\n', funcTreino);
fprintf('Função de ativação: %s\n', funcAtivacao);
fprintf('Ratios: treino %d%% | validação %d%% | teste %d%%\n', ratios);


% Criar rede com topologia definida
net = feedforwardnet(topologia, funcTreino);

% Definir funções de ativação para todas as camadas escondidas
for i = 1:length(net.layers) - 1
    net.layers{i}.transferFcn = funcAtivacao;
end

% Número de épocas 
net.trainParam.epochs = 20;  

% Rácio de divisão treino/validação/teste
net.divideParam.trainRatio = ratios(1)/100;
net.divideParam.valRatio   = ratios(2)/100;
net.divideParam.testRatio  = ratios(3)/100;

% Treinar
[net, tr] = train(net, inputsParaTrain, targetsParaTrain);

% Avaliar desempenho
outputs = net(inputsParaTrain);
[~, predClasses] = max(outputs);% Armazena os índices das classes previstas pela rede para cada exemplo de entrada.
[~, trueClasses] = max(targetsParaTrain); % armazena os índices das classes reais para cada entrada.
accuracyGlobal = sum(predClasses == trueClasses) / length(trueClasses);

% Precisão no conjunto de teste
testInd = tr.testInd;
testOutputs = net(inputsParaTrain(:, testInd));
[~, testPred] = max(testOutputs);
[~, testTrue] = max(targetsParaTrain(:, testInd));
accuracyTeste = sum(testPred == testTrue) / length(testTrue);

fprintf('Precisão GLOBAL: %.2f%%\n', accuracyGlobal * 100);
fprintf('Precisão TESTE:  %.2f%%\n', accuracyTeste * 100);

% === Matriz de confusão ===
figure;
plotconfusion(targetsParaTrain, outputs);
title(sprintf('Confusion Matrix - Topologia [%s]', num2str(topologia)));

% Gravar as 3 melhores redes   
filename = sprintf('rede_top_%02d_%s.mat', round(accuracyTeste*100), datestr(now,'HHMMSS'));
save(filename, 'net');
fprintf('Rede guardada como "%s" com %.2f%% de precisão de teste.\n', filename, accuracyTeste * 100);





