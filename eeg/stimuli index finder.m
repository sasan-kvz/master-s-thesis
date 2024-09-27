load('C:\proje\data\1sasan\RSA\Heydari/HEY_EEG.mat')
A = cell(96,1);
for i=1:9 
    A{i} = find(strcmp({a.event.type},sprintf('S  %d',i)))
end
for i=10:96 
    A{i} = find(strcmp({a.event.type},sprintf('S %d',i)))
end