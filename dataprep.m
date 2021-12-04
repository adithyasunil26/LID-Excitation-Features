
if exist('generated_csvs/res.csv', 'file')==2
  delete('generated_csvs/res.csv');
end

if exist('generated_csvs/gvv.csv', 'file')==2
  delete('generated_csvs/gvv.csv');
end

if exist('generated_csvs/zff.csv', 'file')==2
  delete('generated_csvs/zff.csv');
end

if exist('generated_csvs/labels.csv', 'file')==2
  delete('generated_csvs/labels.csv');
end

clear;
close all;

list = dir('rando1000');
list = list(4:length(list));


l={};
for i=1:length(list)
    l=[l, list(i).name];
end

writematrix(char(l), 'generated_csvs/labels.csv')


for i=1:length(l)
    disp(i);
    disp(char(l(i)));

    [sig, Fs] = audioread(strcat('rando1000/',char(l(i))));
    
    sig=sig(0.5*Fs:2.5*Fs);
    
    res_sig = lp_res(sig, Fs);
    writematrix(transpose(res_sig), 'generated_csvs/res.csv', 'WriteMode','append');
    gvv_sig = gvv(sig, res_sig);
    writematrix(transpose(gvv_sig), 'generated_csvs/gvv.csv', 'WriteMode','append');
    zff_sig = zff(sig, Fs);
    writematrix(transpose(zff_sig), 'generated_csvs/zff.csv', 'WriteMode','append');

end

