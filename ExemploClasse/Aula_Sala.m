%%%Plot das imagens utilizadas nos slides%%%
%% Configuracao do plot inicial
% get(groot,'factory') % Exibe todas as propriedades
clc;close all;clear all
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
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); %Maximiza a jenala figure
    clf()
    
    subplot(2,1,1)
    plot(n,y1,'ob',n,y2,'or')
    title('sinais senos separados')
    xlabel('Amostras [n]')
    legend('0.02\pi = 440 Hz','0.01\pi = 220 Hz')
    subplot(2,1,2)
    plot(n,y1+y2,'ok')
    xlabel('Amostras [n]')
    title('soma dos sinais senos')

%% Análise Espectral - Exemplo 2
%Análise janela, número de amostras e número de pontos para o cálculo da
%DTFT
%Exemplo 1 - Número pequeno de amostras Aula - 5 Slide 18

    n = (0:1:200); %Apresenta somente um período do sinal L = 200
    sinal =  sin(2*pi*f1/fs.*n) + sin(2*pi*f2/fs.*n) ;
    figure(2)
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); %Maximiza a jenala figure
    clf()   
    plot(sinal,'b')
    xlabel("Amostras [n]")
    axis([0,200,-2,2])
    legend('Dimensão do sinal 200')
%% Calculo da DTFT com 256 pontos
    N_fft = 256; %Número de pontos das fft
    
    X_axis_fs = (0:N_fft-1).* (fs/N_fft); %Cria eixo X em frequência
    
    sinal_janelado = sinal.* hanning(length(sinal))';
    Mag_resp = abs( fft( sinal_janelado, N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()
    plot(X_axis_fs,Mag_resp','or')
    xlabel('frequências [Hz]')
    title('DTFT')

%% Aumento no número de pontos da DTFT, inserindo zeros no final do sinal,
% aumento para 4096 pontos.
    N_fft = 2^12;
    
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal.* hanning(length(sinal) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','or')
    xlabel('frequências [Hz]')
    axis([0,1000,0,1])
    %Obs : Não conseguimos identificar corretamente as frequências do 
    %sinal f1 e f2, mesmo aumentando o número de pontos para o cálculo da
    %DTFT. PROBLEMA - o comprimento do sinal está pequeno e está ocorrendo 
    %o vazamento espectral, dessa forma, necessitamos gerar um sinal maior


%% Aumento no comprimento do sinal L de 200 para 800 
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

%% Calculo da DTFT L = 800 N = 4096 amostras
    N_fft = 2^12;
    
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal.* hanning(length(sinal) )', N_fft) );
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','or')
    xlabel('frequências [Hz]')
    axis([0,1000,0,1])
    %Espectro com 2 componentes em 220hz e 440hz
%% Filtros - Exemplo 3
% Simulação de um sinal com várias componentes senoidais. 
    fs = 44100;
    n = 0:1:fs*2.5; % fs*2.5 é um número inteiro, cuidado se o resultado não for 
    freq_sinal =   [1, 2, 40,  110 ,  220 , 330, 440, 550, 660, 1993.7, 2112, 5639,10104.5];
    mag_freq_sig = [100, 15 , 2,   1.24, 1.68 , 4,  1.08, 1.36,.3,   4,       3,      5,       7];

    sinal = zeros(1,length(n));
    for aux1 = 1:length(mag_freq_sig)
        sinal = sinal + sin(2*pi*freq_sinal(aux1)/fs.*n).*mag_freq_sig(aux1);
    end
    sinal = sinal /max(sinal);

    figure(1)
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()

    subplot(2,1,1)
    title('Sinal no tempo')
    stem(sinal,'ob')
    %axis([0,401,-1,1])
    subplot(2,1,2)
    title('Sinal no tempo - pontos interligados')
    plot(sinal,'b')
    %axis([0,401,-1,1])
    
    %% DTFT do sinal 
    N_fft = 2^15;
    sinal_seg = sinal(1,1:6*401);
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    normalization_factor = max(Mag_resp);
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()

    title('DTFT')
    plot(X_axis_fs,Mag_resp','ob')
    xlabel('frequências [Hz]')
    axis([0,15000,0,1])
    %% Toca o sinal
    sound(sinal, fs)

%% Desenho de um filtro PASSA BAIXAS - FIR.  
%Especificações:
    % fsampling = 44100
    % fc = 1000 -> 2*1.1k/44k %Frequência de corte 
    % fs = 1300 %Faixa de rejeição
    % fp = 700 %Faixa de passagem
    f_cut = 1e3;
    f_stop = 1.3e3;
    f_pass = 0.7e3;

    wc = 2*f_cut*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = [0.9 3.1 3.3 5.5]; %Cálculo da ordem do filtro slide 18- FIR
    M = 2*pi.*freq_win/(ws-wp);
    M = ceil(M);
    %% Escolha e projeto do filtro
    filtro_type = 2;

    n = 0:1:M(filtro_type);
    M = M(filtro_type);
    hd = wc/pi .* sinc((wc/pi).*(n-M/2)); %Resposta ideal do filtro passa baixas
    h = hd;

    if(filtro_type==2)
        h = hd.*hanning(M+1)';
    elseif(filtro_type==3)
        h = hd.*hamming(M+1)';
    elseif(filtro_type==4)
        h = hd.*blackman(M+1)';
    end
    h_lp = h;
%% Resposta do Filtro
    clf()   
    [filter_response_lp, freq_win_lp] = filter_visualization(h_lp,1,fs); %comando freqz e group delay 

%% Análise Fourier do sinal Filtrado
    N_fft = 2^15;
    sig_filt_lp = filter(h,1,sinal);

    sinal_seg = sig_filt_lp(1,1:7*401);
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp_lp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_lp = Mag_resp_lp/max(Mag_resp_lp);

    figure(3);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()

    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_lp, 'or', freq_win_lp, abs(filter_response_lp),'g')
    xlabel('frequências [Hz]')
    legend("Antes do filtro","Depois do Filtro","Resposta Magnitude do filtro")
    axis([0,15000,0,1.1])
    
    %%
    sound(sig_filt_lp/max(sig_filt_lp), fs)


%% Desenho de um filtro PASSA ALTAS - FIR
    f_central = 90;
    f_stop = 110 ;
    f_pass = 60 ;

    wc = 2*f_central*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = [0.9 3.1 3.3 5.5];
    M = 2*pi.*freq_win/(ws-wp);
    M = ceil(M);
    filtro_type = 2;

    
    M = M(filtro_type);
    if(mod(M,2)==1)
        M = M +1;
    end
    n = 0:1:M;
    hd = sinc((n-M/2)) - wc/pi .* sinc( (wc/pi).*(n-M/2) ); %resposta ideal do filtro passa altas - Consultar o livro

    if(filtro_type==2)
        h = hd.*hanning(M+1)';
    elseif(filtro_type==3)
        h = hd.*hamming(M+1)';
    elseif(filtro_type==4)
        h = hd.*blackman(M+1)';
    end

%% Análise Resposta do filtro
    
    [filter_response_hp, freq_win_hp] = filter_visualization(h,1,fs);
%% Análise do sinal Filtrado
    
    sig_filt_hp = filter(h,1,sig_filt_lp);
    sinal_seg = sig_filt_hp(1,1:7*401);
    
    N_fft = 2^15;
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_hp = Mag_resp_hp/max(Mag_resp_hp);

    figure(3);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()

    title('DTFT')
    plot(X_axis_fs, Mag_resp_lp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_hp, abs(filter_response_hp), 'g')
    legend("Mag após o filtro passa baixas","Mag após o filtro passa altas","Resposta do filtro passa altas")
    xlabel('frequências [Hz]')
    axis([0,15000 ,0,1.1])
%% Play sinal filtrado 
    sound(sig_filt_hp/max(sig_filt_hp), fs)
%% Play sinal filtrado somente passa baixa para comparar
    sound(sig_filt_lp/max(sig_filt_lp), fs)
 %% Desenho filtro IIR - Passa Baixas
  % Exempplo um sinal ECG do physionet
  % Licença - https://physionet.org/content/mitdb/view-license/1.0.0/
  % load ECG sinal, aplica um filtro FIR passa banda e um filtro IIR
  %Butterworth.

%Espectificações do filtro FIR PB
    load ('ECG_data_105.mat')
    fs = 360;
    ECG_data = ECG_data/max(ECG_data);
    figure()
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    plot(ECG_data,'b')    
    title("Sinal ECG")



    spectral_hanning_response(ECG_data(1,1:2500),fs,2^15,0,0);
    title("Espectro do sinal")
 %% FIR Passa baixas 
     %A Review of electrocardiogram filtering
     % 0.67 Hz that corresponds to a heart rate of 40 beats per
     %minute (bpm), and a 1-mV·s testing impulse for displacement 
     % and slope evaluation. Also, it requires less than 0.5-dB
     % ripple over the range of 1 to 30 Hz

    f_cut = 38;
    f_stop = 40;
    f_pass = 36;

    wc = 2*f_cut*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = 3.1; %Hanning
    M = 2*pi.*freq_win/(ws-wp);
    M = ceil(M);
    M_lp = M;
    n = 0:1:M;
    hd = wc/pi .* sinc((wc/pi).*(n-M/2));
    h_lp = hd.*hanning(M+1)';

%% Resposta do Filtro passa baixas

    [filter_response_lp, freq_win_lp] = filter_visualization(h_lp,1,fs);
    title('Resposta Filtro Passa Baixas')

    ECG_data_lp = filter(h_lp,1,ECG_data);
 %% FIR Passa altas
    f_cut = 0.5;
    f_stop = .9;
    f_pass = .1;

    wc = 2*f_cut*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = 3.1; %Hanning
    M = 2*pi.*freq_win /(ws-wp);
    M = ceil(M)+1;
    M_hp = M;
    n = 0:1:M;
    hd = sinc((n-M/2)) - wc/pi .* sinc( (wc/pi).*(n-M/2) );
    h_hp = hd.*hanning(M+1)';
    
%% Visualiza Filtro Passa altas
    [filter_response_hp, freq_win_hp] = filter_visualization(h_hp ,1,fs);
    title('Resposta Filtro Passa Altas')
    ECG_data_hp = filter(h_hp,1,ECG_data_lp);
plotar = 0;
if (plotar)
    figure()
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    plot(ECG_data,'b')
    hold
    plot(ECG_data_hp(1,int32((M_hp+M_lp))/2:end),'r')
    plot(ECG_data_hp,'r')
    spectral_hanning_response(ECG_data_hp,fs,2^15,0,0);
end
%% Fim do FIR 
%% Filtro IIR - Passa baixas 
   
    f_stop = 46; %Hz
    f_pass = 36;
  % Filtro IIR
    Rp = .05; %dB
    Rs = 44;    

    ws = 2*f_stop/fs;
    wp = 2*f_pass/fs;
   
    % butterworth
    [N_b_lp, Wn_b_lp] = buttord(wp, ws, Rp, Rs);
    [b_b_lp, a_b_lp] = butter(N_b_lp, Wn_b_lp,'low');
%% Análise em frequência do filtro
    
    [filter_response_b_lp, freq_win_b_lp] = filter_visualization(b_b_lp, a_b_lp, fs); 

    ECG_data_b_lp = filter(b_b_lp, a_b_lp, ECG_data);

%% Fourier Analise do sinal após o filtro passa baixas
 plotar = 0;
 if plotar
    N_fft = 2^15;

    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    sinal_seg = ECG_data_b_lp(1,1:7*401);
    Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_hp = Mag_resp_hp/max(Mag_resp_hp);

    figure(3);

    clf()
    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_b_lp, abs(filter_response_b_lp), 'g')
    xlabel('frequências [Hz]')
    axis([0,15000 ,0,1.1])
 end
    %% Desenho filtro IIR - Passa Altas
    f_stop = 0.1;
    f_pass = 0.9;
    
    ws = 2*f_stop/fs;
    wp = 2*f_pass/fs;
      % Filtro IIR
    Rp_hp = 0.05;
    Rs_hp = 45;
    
    % butterworth
    [N_b_hp, Wn_b_hp] = buttord(wp, ws, Rp_hp, Rs_hp);
    [b_b_hp,a_b_hp] = butter(N_b_hp, Wn_b_hp,'high');
%% Análise em frequência do filtro
    
    [filter_response_b_hp, freq_win_b_hp] = filter_visualization(b_b_hp,a_b_hp,fs); 

    ECG_data_b_hp = filter(b_b_hp, a_b_hp, ECG_data_b_lp);
    
    plotar = 0;
    if plotar
        N_fft = 2^15;
        X_axis_fs = (0:N_fft-1).* (fs/N_fft);
        sinal_seg = ECG_data_b_hp(1,1:7*401);
        Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
        Mag_resp_hp = Mag_resp_hp/max(Mag_resp_hp);
    
        figure(3);
        
        clf()
        title('DTFT')
        plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_b_lp, abs(filter_response_b_lp), 'g')
        xlabel('frequências [Hz]')
        axis([0,15000 ,0,1.1])
    end
%% Compara ECG filtrados após filtro FIR e após filtro IIR
    figure()
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    clf()
    plot(ECG_data,'b')
    hold
    plot(ECG_data_b_hp(1,int32(N_b_hp+N_b_lp)/2:end),'r')
    plot(ECG_data_hp(1,int32((M_hp+M_lp))/2:end),'k')
    legend("ECG original","ECG Filtrado pelo Butterworth", "ECG filtrado pelo FIR Hanning")