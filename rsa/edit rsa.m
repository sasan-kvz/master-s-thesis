%y2 =(y1+y)/2;
new = correlation_results .* 0.1;
figure
plot(correlation_results)
figure
plot(y)
figure
plot(new)

output_directory = 'E:\proje\data\0Hemmati\rsa 2d\phase it\new phase it';
% Save the correlation results
RSA = fullfile(output_directory, 'new_phase_it_32-36.mat');
save(RSA, 'new');
