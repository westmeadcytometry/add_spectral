%do all in folder
folder=dir('*.fcs');

for n = 1:length(folder);
    baseFileName = folder(n).name;
  fullFileName = strcat(folder(n).folder, '\', baseFileName);
  add_spectral(fullFileName);
end
