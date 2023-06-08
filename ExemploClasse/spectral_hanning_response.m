function [X_axis,Mag_resp] = spectral_hanning_response(signal, fs, N_size,sound_example)
    % Spectral_hanning_response 
    % signal
    % fs - sampling frequency
    % N_size - Number of elements in the fft
    
    [n_lin,n_col]  =  size(signal);
    
    signal = reshape(signal, max(n_lin,n_col), min(n_lin,n_col));
    
    sig_size = max(n_lin,n_col);
    
    if(N_size<=sig_size)
        N_size = sig_size*2;
    end
    
    X_axis = (0:N_size-1).* (fs/N_size);

    Mag_resp = abs(fft( signal.*hanning(length(signal) ), N_size) );

    Mag_resp = Mag_resp/max(Mag_resp);

    if (sound_example)
        Mag_resp = Mag_resp(1:int32(N_size*5000/fs));
        X_axis = X_axis(1:int32(N_size*5000/fs));
        figure()
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        plot(X_axis,Mag_resp,'b')
        axis([0,5000,0,1.1])
    else
        Mag_resp = Mag_resp(1:int32(N_size/2));
        X_axis = X_axis(1:int32(N_size/2));
        figure()
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        plot(X_axis,Mag_resp,'b')
    end
end

