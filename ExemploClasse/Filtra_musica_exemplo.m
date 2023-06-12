% CopyRight
% Just Smile by LiQWYD https://soundcloud.com/liqwyd
% Creative Commons — Attribution 3.0 Unported — CC BY 3.0
% Free Download / Stream: https://bit.ly/-just-smile
% Music promoted by Audio Library https://youtu.be/lMGw8bTCBww
%Endereço digital da mídia : https://www.youtube.com/watch?v=lMGw8bTCBww

addpath("G:\Meu Drive\Pos_Doc\Aulas\PDS\Trabalho Alunos\Grad")
open('Just_smile.wav')

%% Play sound
sound(data(:,1),fs)

%Data segmentation
seg_data = data(0*fs+1:60*fs,1);
sound(seg_data(4.9e5:4.98e5),fs) %Batida 1
sound(seg_data(5.12e5:5.22e5),fs) %Batida 2
sound(seg_data(1.25e6:1.33e6),fs)
sound(seg_data,fs)

seg_seg_data = seg_data(6.2e5:6.30e5);
seg_seg_data = seg_data(96043:106635);
seg_seg_data1 = seg_data(5.12e5:5.22e5);
seg_seg_data2 = seg_data(1.25e6:1.33e6);
seg_seg_data3 = seg_data(4.9e5:4.98e5);
seg_seg_data = seg_data(15e4: 15.7e4);
seg_seg_data = [seg_seg_data1 ;seg_seg_data2 ;seg_seg_data3];

sound(seg_seg_data,fs)
plot(seg_seg_data)
spectral_hanning_response(seg_seg_data,fs,2^18,1,1)

%% Filtra Música
%remove as batidas de baixa frequências 
freq_HP = 1200; 
M_hp = 70000;
b_music = fir1(M_hp, ...
    2*[freq_HP]/fs ...
    ,'HIGH',blackman(M_hp+1));
sinal_filtrado_hp = filter( b_music, 1, seg_data);
sinal_filtrado_hp = sinal_filtrado_hp/max(sinal_filtrado_hp);
sound(sinal_filtrado_hp,fs)
filter_visualization(b_music,1,fs);

%Compara sinal original e filtrado
plot(seg_data,'b')
hold
plot(sinal_filtrado(M/2:end),'r')

%Escolhe novas frequências para eliminar
plot(4.93e5,0,'go')
seg_seg_data = sinal_filtrado(8.46e5:8.50e5);
sound(seg_seg_data,fs)
spectral_hanning_response(seg_seg_data,fs,2^20,1,0)

%Observa as frequências no espectro e seleciona quais deseja utilizar

%Filtro rejeita faixa
data_sound_seg = sinal_filtrado_hp;
freq_central_selecionadas = [126.56,141.98,180.80,217.18,225.97,262.14,389.99,525.71,659.91,1750.92];

M = 100000;
b_music = zeros([length(freq_central_selecionadas),M+1]);
freq_win = [0.9 3.1 3.3 5.5];
deltaA = freq_win/M.*fs;
passing_window_size_hz = 5 + ceil(2*deltaA(3));

for aux1=1:length(freq_central_selecionadas)
    b_music(aux1,:) = fir1(M, 2*[freq_central_selecionadas(aux1)-passing_window_size_hz freq_central_selecionadas(aux1)+passing_window_size_hz]/fs, "stop",hamming(M+1));
    data_sound_seg = filter( b_music(aux1,:), 1, data_sound_seg);
end
final_sound = sum(data_sound_seg,2);
final_sound = final_sound/max(final_sound);

sound(final_sound,fs)
plot(final_sound,'r')

%Analisa freq sinal filtrado
sound(final_sound(6.42e5:6.52e5),fs)
seg1 = final_sound(6.45e5:6.51e5)';
seg2 = final_sound(1.31e6:1.32e6)';
seg_final_data = [seg1 seg2];
spectral_hanning_response(final_sound(6.42e5:6.52e5),fs,2^18,1,1)


freq_central_selecionadas = [46.02]; 
freq_central_selecionadas = [70.02]; 

passing_window_size_hz = 40;
M = 70000;
b_music = fir1(M, ...
    2*[freq_central_selecionadas(1)-passing_window_size_hz freq_central_selecionadas(1)+passing_window_size_hz]/fs ...
    ,"STOP",blackman(M+1));
sinal_filtrado = filter( b_music, 1, seg_data);
sound(sinal_filtrado,fs)
filter_visualization(b_music,1,fs)


%Fim Filtro

freq_central_selecionadas = [46.02]; 
passing_window_size_hz = 20;
M = 70000;
b_music = fir1(M, ...
    2*[freq_central_selecionadas(1)-passing_window_size_hz freq_central_selecionadas(1)+passing_window_size_hz]/fs ...
    ,"STOP",blackman(M+1));
sinal_filtrado = filter( b_music, 1, seg_data);
sound(sinal_filtrado,fs)
filter_visualization(b_music,1,fs)


seg_seg_data = seg_data(107500:115000);
spectral_hanning_response(seg_seg_data,fs,2^18,1,1)



sinal_filtrado_seg = sinal_filtrado(2.285e5:2.372e5);
sound(sinal_filtrado_seg,fs);
spectral_hanning_response(sinal_filtrado_seg,fs,2^18,1,1);


seg_seg_data = sinal_filtrado(107500:115000);
spectral_hanning_response(seg_seg_data,fs,2^18,1,1)

sound(seg_data,fs)

sound(sinal_filtrado,fs)


