% Exemplo Filtros - Classe PDS 01/2023
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
fs = 44000;
n = 0:1:2*fs;

note = sin(2*pi*440/fs*n)+.001*sin(2*pi*30*440/fs*n)+0.25.*sin(2*pi*3*440/fs*n)+0.125.*sin(2*pi*8*440/fs*n)+0.125.*sin(2*pi*20*440/fs*n)+0.125/10.*sin(2*pi*12*440/fs*n);
note2 = sin(2*pi*1108.73/fs*n)+sin(2*pi*440/fs*n)+sin(2*pi*329.63/fs*n);

sound(note,fs)
pause(3)
sound(note2,fs)