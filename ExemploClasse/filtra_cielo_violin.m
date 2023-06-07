%Banco de Filtros para música Carmen_Habenera
load("Musica_Completa.mat")
set(groot, 'defaultLineLineWidth', 4);
set(groot,'defaultLineMarkerSize', 6);
set(groot,'defaultAxesFontSize',24);

%% Análise Frequencia notas violoncelo
N_fft = 2^19;
spectral_hanning_response(nota1,fs,N_fft);
title("Nota 1")
saveas(gcf,"Espectro_Nota1.png")

spectral_hanning_response(nota2,fs,N_fft);
title("Nota 2")
saveas(gcf,"Espectro_Nota2.png")

spectral_hanning_response(nota3,fs,N_fft);
title("Nota 3")
saveas(gcf,"Espectro_Nota3.png")

spectral_hanning_response(nota4,fs,N_fft);
title("Nota 4")
saveas(gcf,"Espectro_Nota4.png")

spectral_hanning_response(nota5,fs,N_fft);
title("Nota 5")
saveas(gcf,"Espectro_Nota5.png")
%% Criando filtros digitais
freq_central_selecionadas = []
passing_window_size_hz = 10;

sinal_filtrado = zeros(length(cielo),4);
wc = [110,146,220,350];
M = 1000;
for aux1=1:length(wc)
    sinal_filtrado(:, aux1) = filter( fir1(M,2*[wc(aux1)-20 wc(aux1)+20]/fs), 1,cielo);
end


fs = 44100;
wc = [110,146,220,350,280];
sinal_filtrado = zeros(length(data),length(wc));
M = 2000;
for aux1=1:length(wc)
    sinal_filtrado(:, aux1) = filter( fir1(M,2*[wc(aux1)-20 wc(aux1)+20]/fs,'bandpass' ,blackman(M+1)), 1,data(:,1));
end
 sig = sum(sinal_filtrado,2);
 sig = sig/max(sig);
 sound(sig,fs)


 

fs = 44100;
wc = [130,220,350,440,780];
sinal_filtrado = data(:,1);
M = 2000;
for aux1=1:length(wc)
    sinal_filtrado = filter( fir1(M,2*[wc(aux1)-100 wc(aux1)+100]/fs,'stop' ,blackman(M+1)), 1,sinal_filtrado);
end
sig = sinal_filtrado;
 sig = sig/max(sig);
 sound(sig,fs)

