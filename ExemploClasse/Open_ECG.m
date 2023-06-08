clear all
clc
close all
[filename, pathname] = uigetfile('*.dat', ['G:\Meu Drive\Pos_Doc\Aulas\PDS\' ...
    'Trabalho Alunos\Grad\mit-bih-arrhythmia-database-1.0.0\101.dat']);% only image Bitmap
if isequal(filename, 0) || isequal(pathname, 0)   
    disp('File input canceled.');  
   ECG_Data = [];  
else
end
%%

close all
fid=fopen('106.dat','r');

time=10;
f=fread(fid,10*360*time,'ubit12');
Orig_Sig=f(1:2:length(f));



fs = 360;
figure()
Orig_Sig = Orig_Sig-mean(Orig_Sig);
plot(Orig_Sig)
axis([0,600,min(Orig_Sig),max(Orig_Sig)])
ECG_data = Orig_Sig';


spectral_hanning_response(Orig_Sig',fs,2^15,0)

%%
plot(ECG_data(1,650:910))
ECG_data_seg = ECG_data(1,650:910);
save('ECG_data_106.mat','ECG_data','ECG_data_seg','fs')