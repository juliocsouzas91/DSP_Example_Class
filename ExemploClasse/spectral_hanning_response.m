function [X_axis,Mag_resp] = spectral_hanning_response(signal, fs, N_size)
    % Spectral_hanning_response Summary of this function goes here
    %   Detailed explanation goes here
    [n_lin,n_col]  =  size(signal);
    
    signal = reshape(signal, max(n_lin,n_col), min(n_lin,n_col));
    
    sig_size = max(n_lin,n_col);
    
    if(N_size<=sig_size)
        N_size = sig_size*2;
    end
    
    X_axis = (0:N_size-1).* (fs/N_size);

    Mag_resp = abs(fft( signal.*hanning(length(signal) ), N_size) );

    Mag_resp = Mag_resp/max(Mag_resp);

    Mag_resp = Mag_resp(1:int32(N_size*5000/fs));
    X_axis = X_axis(1:int32(N_size*5000/fs));
    theta = (X_axis/max(X_axis)) * 2 * pi;
    max(theta)
    %polarplot(theta,Mag_resp,'ob')
    plot(X_axis,Mag_resp)
end
