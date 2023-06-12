clc;close all;clear all
set(groot, 'defaultLineLineWidth', 4);
set(groot,'defaultLineMarkerSize', 6);
set(groot,'defaultAxesFontSize',24);
%NÃO É NECESSÁRIO RODAR TODO O CÓDIGO, UTILIZE CTRL+SHIFT PARA RODAR SOMENTE
%UM SEGMENTO DO CÓDIGO SEPARADO PELO SIMBOLO DE PORCENTAGEM DUPLO (%%). 

%% Exercício 3 Análise Espectral
load('seg_music_aluno_sobrenome.mat')

%% Exercício 4 Projeto filtro FIR passa baixas
load('NotaLa-Ex4.mat')
sound(sinal,fs) 
%projeto do filtro passa baixas...
coeficientes_filtro = %Implemente o projeto

a = 1; %Note que é 1 pois trabalhamos com filtro FIR.
sinal_la_filtrado = filter(coeficientes_filtro, a, sinal);

% verifica o resultado
sound(sinal_la_filtrado,fs)
save('filt_la_aluno_sobrenome.mat','sinal_la_filtrado','coeficientes_filtro')

%% Exercício 5 Projeto de filtro para a música/áudio.
load('seg_music_aluno_sobrenome.mat')

%Implemente o filtro
sound(sinal_audio_filtrado,fs)
save('filt_music_aluno_sobrenome.mat','sinal_audio_filtrado','fs')
