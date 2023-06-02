%Banco de Filtros para música Carmen_Habenera

fs = 44100;
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

