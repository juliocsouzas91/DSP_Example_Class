function [Note] = create_guitar_note(selected_note, fs, num_harm_left, num_harm_rigth, time_seg, caixa_hamonica)
%Recriate an guittar note with a central frequency and its hamoncs
%central_freq - Tonic frequency
%fs - Sampling Frequency
%num_harm_left - number of harmonics in the left of the spectrum
%num_harm_rigth - number of harmonics in the right of the spectrum
%time_seg - duration time of the note   (Normal=2s)
fund_frequencies = [32.70;	34.65;	36.71; 38.89;	41.20;	43.65;	46.25;	49.00;	51.91;	55.00;	58.27;	61.74];
central_freq = 2*fund_frequencies(selected_note);

n = 0:fs*time_seg-1;

Note = .8*sin(2*pi*n*caixa_hamonica*central_freq/fs);

%Create Left
for aux1 = 1:num_harm_left
 Note = Note + (1/aux1^2).*sin(2*(caixa_hamonica-aux1)*pi*n*central_freq/fs);
end
%Create Rigth
for aux1 = 1:1:num_harm_rigth
 Note = Note + (1/(aux1+3)).*sin(2*(caixa_hamonica+aux1)*pi*n*central_freq/fs);
end
Note = Note/max(Note);
end

