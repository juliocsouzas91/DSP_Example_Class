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
seg_data = data(3*fs:5*fs,1);
sound(seg_data,fs)