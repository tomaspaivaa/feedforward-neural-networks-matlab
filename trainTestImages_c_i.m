[inputsparaTeste, targetsparaTeste] = convertingTestImagesToBinaryMatrix();

% carregar as melhores redes
load('alineaB_diferentRatios_Conf3.mat', 'net');
net1 = net;
load('alineaB_diferentTopo_Conf1.mat', 'net');
net2 = net;
load('alineaB_diferentFuncAtiv_Conf3.mat', 'net');
net3 = net;


% Avaliar a Rede 1 
outputs1 = net1(inputsparaTeste);
[~, pred1] = max(outputs1);
[~, trueLabels] = max(targetsparaTeste);
acc1 = sum(pred1 == trueLabels) / length(trueLabels);
fprintf('Rede 1 - Precisão TESTE: %.2f%%\n', acc1 * 100);

% Matriz de confusão da Rede 1
figure; 
plotconfusion(targetsparaTeste, outputs1);
title('Matriz de Confusão - Rede 1');


% Avaliar a Rede 2 
outputs2 = net2(inputsparaTeste);
[~, pred2] = max(outputs2);
acc2 = sum(pred2 == trueLabels) / length(trueLabels);
fprintf('Rede 2 - Precisão TESTE: %.2f%%\n', acc2 * 100);

% Matriz de confusão da Rede 2
figure; 
plotconfusion(targetsparaTeste, outputs2);
title('Matriz de Confusão - Rede 2');


% Avaliar a Rede 3
outputs3 = net3(inputsparaTeste);
[~, pred3] = max(outputs3);
acc3 = sum(pred3 == trueLabels) / length(trueLabels);
fprintf('Rede 3 - Precisão TESTE: %.2f%%\n', acc3 * 100);

% Matriz de confusão da Rede 3
figure; 
plotconfusion(targetsparaTeste, outputs3);
title('Matriz de Confusão - Rede 3');









