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
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); %Maximiza a jenala figure
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
% Simulação de um sinal com várias componentes senoídais. 
    n = 0:1:fs*2.5; %fs*2.5 é um número inteiro, cuitado se o resultado não for 
    freq_sinal =       [20,40, 110,  220, 330, 440, 550, 660, 1993.7, 2112, 5639,10104.5];
    mag_freq_sig = [6 , 2,   1.24, 1.68 ,     4,     1.08,    1.36,     .3,    4,       3,      5,       7];

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
    title("Sinal no tempo - pontos interligados")
    plot(sinal,'b')
    axis([0,401,-1,1])
    
    %DTFT do sinal 
    N_fft = 2^15;
    sinal_seg = sinal(1,1:6*401);
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    normalization_factor = max(Mag_resp);
    Mag_resp = Mag_resp/max(Mag_resp);
    
    figure(2);
    
    clf()
    title('DTFT')
    plot(X_axis_fs,Mag_resp','ob')
    xlabel("frequências [Hz]")
    axis([0,15000,0,1])
    sound(sinal, fs)

%% Desenho de um filtro PASSA BAIXAS - FIR.  
%Especificações:
    % fsampling = 44100
    % fc = 1100 -> 2*1.1k/44k %Frequência de corte 
    % fs = 1300 %Faixa de rejeição
    % fp = 900 %Faixa de passagem
    f_cut = 1e3;
    f_stop = 1.3e3;
    f_pass = 0.7e3;

    wc = 2*f_cut*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = [0.9 3.1 3.3 5.5];
    M = 2*pi.*freq_win/(ws-wp);
    M = ceil(M);
    filtro_type = 2;

    n = 0:1:M(filtro_type);
    M = M(filtro_type);
    hd = wc/pi .* sinc((wc/pi).*(n-M/2));
    h = hd;

    if(filtro_type==2)
        h = hd.*hanning(M+1)';
    elseif(filtro_type==3)
        h = hd.*hamming(M+1)';
    elseif(filtro_type==4)
        h = hd.*blackman(M+1)';
    end
% Resposta do Filtro
    clf()   
    [filter_response_lp, freq_win_lp] = filter_visualization(h,1,fs);

%Análise Fourier do sinal Filtrado
    N_fft = 2^15;
    sig_filt = filter(h,1,sinal);

    sinal_seg = sig_filt(1,1:7*401);
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp_lp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_lp = Mag_resp_lp/normalization_factor;

    figure(3);
    
    clf()
    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_lp, 'or', freq_win_lp, abs(filter_response),'r')
    xlabel("frequências [Hz]")
    axis([0,15000,0,1.1])
    sound(sig_filt/max(sig_filt), fs)


%% Desenho de um filtro PASSA ALTAS - FIR
    f_central = 80;
    f_stop = 100 ;
    f_pass = 50 ;

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
    hd = sinc((n-M/2)) - wc/pi .* sinc( (wc/pi).*(n-M/2) );

    if(filtro_type==2)
        h = hd.*hanning(M+1)';
    elseif(filtro_type==3)
        h = hd.*hamming(M+1)';
    elseif(filtro_type==4)
        h = hd.*blackman(M+1)';
    end

% Análise Fourier do filtro
    
    [filter_response_hp, freq_win_hp] = filter_visualization(h,1,fs);

    
    sig_filt_hp = filter(h,1,sig_filt);
    sinal_seg = sig_filt_hp(1,1:7*401);
    
    N_fft = 2^15;
    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    
    Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_hp = Mag_resp_hp/normalization_factor;

    figure(3);
    
    clf()
    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_hp, abs(filter_response_hp), 'g')
    xlabel("frequências [Hz]")
    axis([0,15000 ,0,1.1])
    sound(sig_filt_hp/max(sig_filt_hp), fs)
    sound(sig_filt/max(sig_filt), fs)
 %% Desenho filtro IIR - Passa Baixas
  %load ECG sinal, aplica um filtro FIR passa banda e um filtro IIR
  %Butterworth.
  
%Espectificações do filtro FIR PB
   load ('ECG_signal.mat')
   ECG_data = ECG_data(1,50000:100000);
   fs = 360;
 %FIR Passa baixas
    f_cut = 45;
    f_stop = 50;
    f_pass = 40;

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

% Resposta do Filtro
    [filter_response_lp, freq_win_lp] = filter_visualization(h_lp,1,fs);
    title("Resposta Filtro Passa Baixas")

    ECG_data_lp = filter(h_lp,1,ECG_data);
 %FIR Passa altas
    f_cut = 1;
    f_stop = 2;
    f_pass = 0;

    wc = 2*f_cut*pi/fs;
    ws = 2*f_stop*pi/fs;
    wp = 2*f_pass*pi/fs;

    freq_win = 3.1; %Hanning
    M = 2*pi.*freq_win /(ws-wp);
    M = ceil(M);
    M_hp = M;
    n = 0:1:M;
    hd = sinc((n-M/2)) - wc/pi .* sinc( (wc/pi).*(n-M/2) );
    h_hp = hd.*hanning(M+1)';
    [filter_response_hp, freq_win_hp] = filter_visualization(h_hp ,1,fs);
    title("Resposta Filtro Passa Altas")
    ECG_data_hp = filter(h_hp,1,ECG_data_lp);

    figure()
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    plot(ECG_data,'b')
    hold
    plot(ECG_data_hp(1,int32((M_hp+M_lp))/2:end),'r')

    %% Fim do FIR 

    Rp = 0.42;
    Rs = 45;

    deltap = 10^(Rp/20) - 1
    deltas = 10^(-Rs/20)
    
    f_stop = 1.4e3;
    f_pass = 0.5e3;
    
    ws = 2*f_stop/fs;
    wp = 2*f_pass/fs;
      % Filtro IIR
    Rp1 = -20*log10((1-deltap)/(1+deltap));
    Rs1 = -20*log10(deltas/(1+deltap));
    
    % butterworth
    [N_b, Wn_b] = buttord(wp, ws, Rp1, Rs1);
    [b_b,a_b] = butter(N_b, Wn_b);
    % Análise Fourier do filtro
    
    [filter_response_b_lp, freq_win_b_lp] = filter_visualization(b_b,a_b,fs); 

    x_IIR_lp = filter(b_b, a_b, sinal);
    N_fft = 2^15;

    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    sinal_seg = x_IIR(1,1:7*401);
    Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_hp = Mag_resp_hp/max(Mag_resp_hp);

    figure(3);
    
    clf()
    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_b_lp, abs(filter_response_b_lp), 'g')
    xlabel("frequências [Hz]")
    axis([0,15000 ,0,1.1])
    sound(x_IIR_lp,fs)

    %% Desenho filtro IIR - Passa Altas


    Rp = 0.42;
    Rs = 45;

    deltap = 10^(Rp/20) - 1
    deltas = 10^(-Rs/20)
    
    f_stop = 20;
    f_pass = 80;
    
    ws = 2*f_stop/fs;
    wp = 2*f_pass/fs;
      % Filtro IIR
    Rp1 = -20*log10((1-deltap)/(1+deltap));
    Rs1 = -20*log10(deltas/(1+deltap));
    
    % butterworth
    [N_b, Wn_b] = buttord(wp, ws, Rp1, Rs1);
    [b_b,a_b] = butter(N_b, Wn_b,'high');
    % Análise Fourier do filtro
    
    [filter_response_b_lp, freq_win_b_lp] = filter_visualization(b_b,a_b,fs); 

    x_IIR_hp = filter(b_b, a_b, x_IIR_lp);
    N_fft = 2^15;

    X_axis_fs = (0:N_fft-1).* (fs/N_fft);
    sinal_seg = x_IIR_hp(1,1:7*401);
    Mag_resp_hp = abs( fft( sinal_seg.* hanning(length(sinal_seg) )', N_fft) );
    Mag_resp_hp = Mag_resp_hp/max(Mag_resp_hp);

    figure(3);
    
    clf()
    title('DTFT')
    plot(X_axis_fs, Mag_resp,'ob', X_axis_fs, Mag_resp_hp, 'or', freq_win_b_lp, abs(filter_response_b_lp), 'g')
    xlabel("frequências [Hz]")
    axis([0,15000 ,0,1.1])
    sound(x_IIR_hp,fs)


