function [inputs, targets] = convertingTestImagesToBinaryMatrix()

baseFolder = fullfile(pwd, "test");

% Lista das classes (subpastas)
classes = {'circle', 'kite', 'parallelogram', 'square', 'trapezoid', 'triangle'};
numClasses = numel(classes);
imgsPerClass = 10;
totalImgs = numClasses * imgsPerClass;

% Tamanho fixo para reduzir carga computacional
imageSize = [25, 25];

% Inicializar matrizes
data = zeros(prod(imageSize), totalImgs);  % Cada coluna é uma imagem
target = zeros(numClasses, totalImgs);     % One-hot encoding
labels = strings(1, totalImgs);            % Para guardar a classe de cada imagem

imgIdx = 1;

for classIdx = 1:numClasses
    className = classes{classIdx};
    folderPath = fullfile(baseFolder, className);
    
    imageFiles = dir(fullfile(folderPath, '*.png'));  % Ficheiros .png dessa classe
    
    for j = 1:imgsPerClass
        imgPath = fullfile(folderPath, imageFiles(j).name);
        img = imread(imgPath);

        img = imresize(img, imageSize);
        
        % Converter para cinzento se for RGB
        if size(img, 3) == 3
            img = rgb2gray(img);
        end

        img = imbinarize(img);

        % Guardar como vetor
        data(:, imgIdx) = img(:);
        target(classIdx, imgIdx) = 1;
        labels(imgIdx) = className;

        imgIdx = imgIdx + 1;
    end
end

disp('Imagens de treino carregadas e convertidas com sucesso.');

inputs = data;
targets = target;

end
