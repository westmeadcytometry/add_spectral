%to use this rename the unstained with unstained.fcs before using

%do all in folder
folder=dir('*.fcs');

for n = 1:length(folder);
    if strcmp(folder(n).name,'unstained.fcs');
        folder(n)=[];
    end
end


for n = 1:length(folder);
    baseFileName = folder(n).name;
  fullFileName = strcat(folder(n).folder, '\', baseFileName);
  add_spectral_referenced(baseFileName,'unstained.fcs');
end
