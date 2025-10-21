function [inputs, targets] = convertingAllImagesToBinaryMatrix()
    % Caminhos para as pastas
    baseFolders = {
        fullfile(pwd, 'start'), ...
        fullfile(pwd, 'train'), ...
        fullfile(pwd, 'test')
    };
    
    % Lista das classes (subpastas)
    classes = {'circle', 'kite', 'parallelogram', 'square', 'trapezoid', 'triangle'};
    numClasses = numel(classes);
    
    % Tamanho desejado das imagens
    imageSize = [25, 25];
    
    % Inicialização dinâmica (começamos vazio)
    data = [];
    target = [];
    
    for classIdx = 1:numClasses
        className = classes{classIdx};
        
        for folderIdx = 1:length(baseFolders)
            folderPath = fullfile(baseFolders{folderIdx}, className);
            imageFiles = dir(fullfile(folderPath, '*.png')); % numero de imagens por pasta
            
            for j = 1:length(imageFiles)
                imgPath = fullfile(folderPath, imageFiles(j).name);
                img = imread(imgPath);
                
                if size(img, 3) == 3
                    img = rgb2gray(img);
                end
                
                img = imresize(img, imageSize);
                img = imbinarize(img);
                
                % Adiciona imagem processada como vetor coluna
                data = [data, img(:)];
                
                % One-hot target
                tempTarget = zeros(numClasses, 1);
                tempTarget(classIdx) = 1;
                target = [target, tempTarget];
            end
        end
    end
    
    inputs = data;
    targets = target;
    
    disp('Imagens das pastas start, train e test carregadas com sucesso.');
    
end    


