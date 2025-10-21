
function [inputs, targets] = convertingStartImagesToBinaryMatrix()

baseFolder = fullfile(pwd, "start");

% Lista das classes (subpastas)
classes = {'circle', 'kite', 'parallelogram', 'square', 'trapezoid', 'triangle'};
numClasses = numel(classes);
imgsPerClass = 5;
totalImgs = numClasses * imgsPerClass;

% Tamanho uniforme para as imagens (para nao sobrecarregar a maquina, diminuimos o tamanho)
imageSize = [25, 25];


% Inicializar matrizes
data = zeros(prod(imageSize), totalImgs);  % Cada coluna é uma imagem
target = zeros(numClasses, totalImgs);     % One-hot encoding das classes (6->linhas * 30->colunas)
labels = strings(1, totalImgs);            % Para guardar em string a class de cada imagem

imgIdx = 1;  % índice da imagem

for classIdx = 1:numClasses % percorrer cada classe (numero de pastas)
    className = classes{classIdx};
    folderPath = fullfile(baseFolder, className); 
    
    imageFiles = dir(fullfile(folderPath, '*.png'));  %vai buscar todos os ficheiros .png dentro da subpasta atuale guardar em imagesFiles

    for j = 1:imgsPerClass
        imgPath = fullfile(folderPath, imageFiles(j).name);
        img = imread(imgPath);
        
        % Redimensionar e binarizar
        img = imresize(img, imageSize);
        
        if size(img, 3) == 3
          img = rgb2gray(img); % garantir que é grayscale
        end

        img = imbinarize(img);
        

        % Guardar a imagem como vetor
        data(:, imgIdx) = img(:); % guarda a imagem como vetor coluna

        % One-hot target
        target(classIdx, imgIdx) = 1; %preenchendo uma coluna de cada vez com um 1 na linha da classe correta
        labels(imgIdx) = className;   % Guarda o nome da classe para referência

        imgIdx = imgIdx + 1;
    end
end

disp('Imagens carregadas e convertidas com sucesso.');

 inputs = data;
 targets = target;

end

% Guardar variáveis para usar noutro script
% save('dados_start.mat', 'data', 'target', 'labels', 'classes');
