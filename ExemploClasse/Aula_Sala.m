%%%Plot das imagens utilizadas nos slides%%%
%% Configuracao do plot inicial
% get(groot,'factory') % Exibe todas as propriedades
set(groot, 'defaultLineLineWidth', 4);
set(groot,'defaultLineMarkerSize', 6);
set(groot,'defaultAxesFontSize',24);

%% Síntese de senos - Exemplo 1
fs = 44100;
f1 = 440;
f2 = 220;
n = 0:1:200;
y1 = sin(2*pi*f1/fs.*n);
y2 = sin(2*pi*f2/fs.*n);

figure(1)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
clf()

tiledlayout(2,1);
nexttile
plot(n,y1,'ob')
hold 
plot(n,y2,'or')
xlabel("Amostras [n]")
legend("0.02\pi = 440 Hz","0.01\pi = 220 Hz")
saveas(gcf,'Imagens\sinal_introducao.png')

nexttile
plot(n,y1+y2,'ok')
xlabel("Amostras [n]")


%% Análise Espectral - Exemplo 2
%Análise janela, número de amostras e número de pontos para o cálculo da
%DTFT
%Exemplo 1 - Número pequeno de amostras Aula - 5 Slide 18

    n = (0:1:200); %Apresenta somente um período do sinal L = 200
    sinal =  sin(2*pi*f1/fs.*n) + sin(2*pi*f2/fs.*n) ;
    figure(2)
    plot(sinal,'b')
    legend("Dimensão do sinal 200")
%Calculo da DTFT com 256 pontos
    N_fft = 256;

    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    X_axis_wc = (0:N_fft-1).* (2/N_fft);
    
    Mag_resp = abs( fft( sinal.* hanning(length(sinal) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    clf()
    t = tiledlayout(1,1);
    ax1 = axes(t);
    plot(ax1,X_axis_wc,Mag_resp','ob')
    hold 
    axis([0,1000*2/fs,0,1])
    %ylim([-0.1 1.1])
    ax1.XAxisLocation = 'bottom';
    xlabel("\omega")
    
    ax2 = axes(t);
    plot(ax2,X_axis_fs,Mag_resp','or')
    ax2.XAxisLocation = 'top';
    ax2.YAxisLocation = 'right';
    ax2.Color = 'none';
    xlabel("frequências [Hz]")
    title('DTFT')
    axis([0,1000,0,1])

% Aumento no número de pontos da DTFT, inserindo zeros no final do sinal,
% aumento para 4096 pontos.
    N_fft = 2^12;
    
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal.* hanning(length(sinal) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    
    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','or')
    xlabel("frequências [Hz]")
    axis([0,1000,0,1])
    %Obs : Não conseguimos identificar corretamente as frequências do meu
    %sinal f1 e f2, mesmo aumentando o número de pontos para o cálculo da
    %DTFT. PROBLEMA - o comprimento do sinal está pequeno e está ocorrendo 
    %o vazamento espectral, dessa forma, necessitamos gerar um sinal maior


%Aumento no comprimento do sinal L de 200 para 800 
    figure(3)
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

    clf()
    title('Sinal tempo discreto')
    sinal =  sin(2*pi*f1/fs.*(0:200)) + sin(2*pi*f2/fs.*(0:200)) ;
    plot(sinal','b')
    pause(2)
    for aux1 = 201:1:801
        n = (0:1:aux1);
        sinal(1,1:aux1+1)  =  sin(2*pi*f1/fs.*n) + sin(2*pi*f2/fs.*n) ;
        plot(sinal,'b')
        drawnow
    end

%Calculo da DTFT L = 800 N = 4096 amostras
    N_fft = 2^12;
    
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal.* hanning(length(sinal) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    
    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','or')
    xlabel("frequências [Hz]")
    axis([0,1000,0,1])
    %Espectro com 2 componentes em 220hz e 440hz
%% Filtros - Exemplo 3
%Calculo de um novo sinal com frequências 220, 330, 440, 550, 2000, 3500, 5000, 10000 e amplitudes
%normalizadas de [.45 1 .75 .25, 2, 1, 2, 2] e duração de 2.5 s 
    n = 0:1:fs*2.5; %fs*2.5 é um número inteiro, cuitado se o resultado não for 
    freq_sinal = [220, 330, 440, 550, 1980, 2970, 4620, 10780];
    mag_freq_sig = [.45 1 .75 .25, 4, 1, 2];
    sinal = zeros(1,length(n));
    for aux1 = 1:length(mag_freq_sig)
        sinal = sinal + sin(2*pi*freq_sinal(aux1)/fs.*n).*mag_freq_sig(aux1);
    end
    sinal = sinal /max(sinal);

    figure(1)
    clf()
    subplot(2,1,1)
    title("Sinal no tempo")
    stem(sinal,'ob')
    axis([0,401,-1,1])
    subplot(2,1,2)
    title("Sinal no tempo")
    plot(sinal)
    axis([0,401,-1,1])
    
    %DTFT do sinal 
    N_fft = 2^15;
    sinal_seg = sinal(1,1:7*401);
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    
    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','ob')
    xlabel("frequências [Hz]")
    axis([0,15000,0,1])
    sound(sinal, fs)

%Desenho de um filtro passa baixas - FIR. Comando 

%Desenho de um filtro passa altas - FIR




