% Exemplo Filtros - Classe PD.S 01/2023
% Autores - Julio de Souza e Ricardo Higuti
% Roteiro :
%             * Apresentação do sinal
%             * Análise Espectral
%             * Desenho Filtros FIR
%               *Apresenta um filtro passa baixas e passa altas utilizando
%               dois cossenos somados(Simples)
%               *Cria um filtro para o ECG para eliminar os artefatos,
%               aplica em toda a informação
%             * Desenho Filtro IIR
%               *Exemplo de filtro IIR no sinal ECG segmentado
clc;close all;clear all


%% Apresentando o Sinal %%
fs = 44100;
n = 0:1:2*fs;
signal_size = length(n);

note = sin(2*pi*440/fs*n)+.001*sin(2*pi*30*440/fs*n)+0.25.*sin(2*pi*3*440/fs*n)+0.125.*sin(2*pi*8*440/fs*n)+0.125.*sin(2*pi*20*440/fs*n)+0.125/10.*sin(2*pi*12*440/fs*n);
note1 = (sin(2*pi*659.25/fs*n)+sin(2*pi*523.25/fs*n)+sin(2*pi*78399/fs*n));
note2 = (sin(2*pi*659.25/fs*n)+sin(2*pi*523.25/fs*n + pi/5)+sin(2*pi*783.99/fs*n));
sound(note1,fs)
pause(3)

A4 = create_hamonic_signal(440, fs, signal_size);
C_Sharp = create_hamonic_signal(554.37, fs, signal_size);
E = create_hamonic_signal(659.25, fs, signal_size);

note2 = A4+C_Sharp+E+sin(2*pi*108/fs.*n)+.1*sin(2*pi*216/fs.*n)+.5*sin(2*pi*433.36/fs.*n)+.17*sin(2*pi*325/fs.*n);
atenuation = 0.99998.^n;
note2 = note2.*atenuation;
note2=note2/max(note2);
sound(note2,fs)

%
A4 = sin(2*pi*108/fs.*n)+.1*sin(2*pi*216/fs.*n)+.5*sin(2*pi*433.36/fs.*n)+.17*sin(2*pi*325/fs.*n);
A4 = A4/max(A4);
sound(A4,fs)

%% Open Guitar note 
load Nota_A.mat
data = data(:,1)';
data = data(1,25000:end);
sound(data,fs);
%% Criando um filtro passa baixas
Wn = 0.0181; 
a = 1 ;
b = fir1(50,Wn);
note2_f = filter(b,1,note2);
note2_f = note2_f/max(note2_f);
sound(note2_f,fs)

sound(data(23000:end,1),fs)
N = 2^22;
seg = abs(fft( data(:,1).*hanning(111216) ,N));
seg = seg/max(seg);
freqHz = (0:1:length(seg)-1)*fs/N;
plot(freqHz,seg)

%% High Pass Filter

Wn = 0.0181; 
a = 1 ;
b = fir1(500,Wn,'high');
dat2 = filter(b,1,data);
dat2 = dat2/max(dat2);

Wn = 0.0227; 
a = 1 ;
b = fir1(50,Wn);

dat2 = filter(b,1,dat2);
dat2 = dat2/max(dat2);
sound(dat2,fs)