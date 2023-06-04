%%%Plot das imagens utilizadas nos slides%%%
%% Configuracao do plot
% get(groot,'factory') % Exibe todas as propriedades
set(groot, 'defaultLineLineWidth', 4);
set(groot,'defaultLineMarkerSize', 6);
set(groot,'defaultAxesFontSize',24);
set(groot,'PointerLocation',[1080,1980])
%% Síntese de senos
fs = 44100;
f1 = 440;
f2 = 220;
n = 0:1:200;
y1 = sin(2*pi*f1/fs.*n);
y2 = sin(2*pi*f2/fs.*n);

figure(1)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

clf()
plot(n,y1,'ob')
hold 
plot(n,y2,'or')
xlabel("Amostras [n]")
legend("0.02\pi = 440 Hz","0.01\pi = 220 Hz")
saveas(gcf,'Imagens\sinal_introducao.png')

%% Análise Espectral
%Exemplo 1 - Número de pontos da dtft
n = (0:1:800);
signal =  sin(2*pi*f1/fs.*n) + sin(2*pi*f2/fs.*n) ;
N_fft = 2^12;
%[n_lin,n_col]  =  size(signal);
% signal = reshape(signal, max(n_lin,n_col), min(n_lin,n_col)); 

X_axis_fs = (0:N_fft-1).* (fs/N_fft);
X_axis_wc = (0:N_fft-1).* (2/N_fft);

Mag_resp = abs( fft( signal.* hanning(length(signal) )', N_fft) );
Mag_resp = Mag_resp/max(Mag_resp);

figure(2);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

clf()
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,X_axis_wc,Mag_resp','ob')
hold 
axis([0,1000*2/fs,0,1])
ax1.XAxisLocation = 'bottom';
xlabel("\omega")

ax2 = axes(t);
plot(ax2,X_axis_fs,Mag_resp','or')
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
xlabel("frequências [Hz]")
axis([0,1000,0,1])




%Exemplo 2 - 
N_fft = 2^12;

N_fft = 2^16;
n = 0:1:4000;

[n_lin,n_col]  =  size(signal);
signal = reshape(signal, max(n_lin,n_col), min(n_lin,n_col));

X_axis_fs = (0:N_fft-1).* (fs/N_fft);
X_axis_wc = (0:N_fft-1).* (2/N_fft);

Mag_resp = abs( fft( signal.* hanning(length(signal) ), N_fft) );
Mag_resp = Mag_resp/max(Mag_resp);

figure(2);
set(cgf, 'Position', get(0, 'Screensize'));
clf()
plot(X_axis_fs,Mag_resp,'ob')
xlabel("\omega")
axis([0,0.03,-.1,1.1])
axis([0,500,-.1,1.1])

saveas(gcf,'Imagens\FFT_sinal_introducao.png')


