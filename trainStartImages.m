[inputsParaStart, targetsParaStart] = convertingStartImagesToBinaryMatrix();

% ====== CONFIGURAÇÃO ======

% Define aqui a topologia a testar
% Ex: [10] = uma camada com 10 neurónios (default)
% Ex: [20 10] = duas camadas, 20 neurónios na 1ª e 10 na 2ª
topologia = [10 10];  % <==== ALTERAR AQUI PARA TESTES (para esta alinea troca se apenas a topologia)

% ==========================
fprintf('Treinar rede com topologia: [%s]\n', num2str(topologia));


% Criar rede com topologia definida
net = feedforwardnet(topologia);

% Mostrar funções por defeito
fprintf('Função de treino (default): %s\n', net.trainFcn);
%colocar aqui as camadas escondidas adicionais se necessario
fprintf('Função de ativação (camada escondida): %s\n', net.layers{1}.transferFcn);

fprintf('Função de ativação (camada de saída):   %s\n', net.layers{end}.transferFcn);

% Usar 100% para treino
net.divideFcn = '';

% Número de épocas 
net.trainParam.epochs = 20;  

% Treinar
net = train(net, inputsParaStart, targetsParaStart);

% Avaliar desempenho
outputs = net(inputsParaStart);
[~, predClasses] = max(outputs);% Armazena os índices das classes previstas pela rede para cada exemplo de entrada.
[~, trueClasses] = max(targetsParaStart); % armazena os índices das classes reais para cada entrada.

accuracy = sum(predClasses == trueClasses) / length(trueClasses);
fprintf('Precisão global: %.2f%%\n', accuracy * 100);



