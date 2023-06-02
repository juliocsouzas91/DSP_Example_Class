function spectral_visualization(signal, N_size, fs,plota_db)
    %SPECTRAL_VISUALIZATION Summary of this function goes here
    %   Detailed explanation goes here
    sig_size = length(signal);
    if(N_size<=sig_size)
        N_size = sig_size;
    end
    freq_x = (0:N_size-1).* (fs/N_size);

    tiledlayout(2,2)
    ax1 = nexttile;
         fft_sig = abs(fft(signal,N_size));
         fft_sig = fft_sig/max(fft_sig);
         if(plota_db)
            fft_sig = 20.*log10(fft_sig);
         end
         plot(freq_x,fft_sig)
         title("Janela Retangular")
    ax2 = nexttile;
         fft_sig = abs(fft(signal.*hanning(sig_size)',N_size));
         fft_sig = fft_sig/max(fft_sig);
         if(plota_db)
            fft_sig = 20.*log10(fft_sig);
         end         
         plot(freq_x,fft_sig)
         title("Janela Hanning")
    ax3 = nexttile;
         fft_sig =  abs(fft(signal.*hamming(sig_size)',N_size));
         fft_sig = fft_sig/max(fft_sig);
         if(plota_db)
            fft_sig = 20.*log10(fft_sig);
         end         
         plot(freq_x,fft_sig)
         title("Janela Haming")
    ax4 = nexttile;
         fft_sig = abs(fft(signal.*blackman(sig_size)',N_size));
         fft_sig = fft_sig/max(fft_sig);
         if(plota_db)
            fft_sig = 20.*log10(fft_sig);
         end         
         plot(freq_x,fft_sig)
         title("Janela Blackman")
linkaxes([ax1 ax2 ax3 ax4],'xy')
end

