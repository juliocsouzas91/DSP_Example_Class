%Banco de Filtros para música Carmen_Habenera
load("cielo_musica_inteira.mat")
set(groot, 'defaultLineLineWidth', 4);
set(groot,'defaultLineMarkerSize', 6);
set(groot,'defaultAxesFontSize',24);

%% Análise Frequencia notas violoncelo
N_fft = 2^19;
load("ciello_notas_seperadas.mat")

spectral_hanning_response(nota1,fs,N_fft,1,1);
title("Nota 1")
saveas(gcf,"Espectro_Nota1.png")

spectral_hanning_response(nota2,fs,N_fft,1,1);
title("Nota 2")
saveas(gcf,"Espectro_Nota2.png")

spectral_hanning_response(nota3,fs,N_fft,1,1);
title("Nota 3")
saveas(gcf,"Espectro_Nota3.png")

spectral_hanning_response(nota4,fs,N_fft,1,1);
title("Nota 4")
saveas(gcf,"Espectro_Nota4.png")

spectral_hanning_response(nota5,fs,N_fft,1,1);
title("Nota 5")
saveas(gcf,"Espectro_Nota5.png")
%% Criando filtros digitais
%Observa as frequências no espectro e seleciona quais deseja utilizar
freq_central_selecionadas = [110, 146.42, 223, 297, 359, 352, 371, 559, 665];

passing_window_size_hz = 3;

data_sound_seg = data_sound(10*fs:20*fs,1);
sinal_filtrado = zeros([length(data_sound_seg),length(freq_central_selecionadas)]);
M = 50000;
b_music = zeros([length(freq_central_selecionadas),M+1]);
freq_win = [0.9 3.1 3.3 5.5];
deltaA = freq_win/M.*fs;
for aux1=1:length(freq_central_selecionadas)
    b_music(aux1,:) = fir1(M, 2*[freq_central_selecionadas(aux1)-passing_window_size_hz freq_central_selecionadas(aux1)+passing_window_size_hz]/fs, "bandpass",hanning(M+1));
    sinal_filtrado(:, aux1) = filter( b_music(aux1,:), 1, data_sound_seg);
end
final_sound = sum(sinal_filtrado,2)/length(freq_central_selecionadas);
final_sound = final_sound/max(final_sound);
sound(final_sound,fs)

%% Filtra Música - Número maior de filtros
%Observa as frequências no espectro e seleciona quais deseja utilizar
freq_sel1 = [145.77, 220.54,288.51,367.32,433.35,514.86,590.06,663.32];
freq_sel2 = [110.52, 223.99, 329.72, 444.87, 556.16, 666.94];
freq_sel3 = [130.29, 177.14, 353.61,532.72,709.08,778.56];
freq_sel4 = [112];
freq_sel5 = [297.34,371.95,519.09,594.09];
high_freq = [800.14,884.12,731.12, 773.84, 888.66 , 995.57];
%,1032.92,1177.43 ,1418.67,1449.03, 1105.26, 1337.67, 1220.92, 1445.58,];

freq_sel1 = [145.77, 220.54,288.51,367.32,433.35];
freq_sel2 = [110.52, 223.99, 329.72, 444.87];
freq_sel3 = [130.29, 177.14, 353.61];
freq_sel4 = [112];
freq_sel5 = [297.34,371.95];

high_freq = [800.14,884.12,731.12, 773.84, 888.66 , 995.57];
freq_central_selecionadas = [freq_sel1,freq_sel2,freq_sel3,freq_sel4,freq_sel5];

passing_window_size_hz = 1;

data_sound_seg = data_sound(15*fs:25*fs,1);
sinal_filtrado = zeros([length(data_sound_seg),length(freq_central_selecionadas)]);
M = 50000;
b_music = zeros([length(freq_central_selecionadas),M+1]);
freq_win = [0.9 3.1 3.3 5.5];
deltaA = freq_win/M.*fs;
for aux1=1:length(freq_central_selecionadas)
    b_music(aux1,:) = fir1(M, 2*[freq_central_selecionadas(aux1)-passing_window_size_hz freq_central_selecionadas(aux1)+passing_window_size_hz]/fs, "bandpass",blackman(M+1));
    sinal_filtrado(:, aux1) = filter( b_music(aux1,:), 1, data_sound_seg);
end
final_sound = sum(sinal_filtrado,2);
final_sound = final_sound/max(final_sound);
sound(final_sound,fs)


