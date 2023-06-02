function harmonic_signal = create_hamonic_signal(fundamental_frequency, fs, signal_size)
    n = 0:1:signal_size-1;
    harmonic_signal = 2*sin(2*pi*fundamental_frequency/fs.*n);
    aux1 = 2;
    while(2*fundamental_frequency/fs*aux1<1)
        harmonic_signal = harmonic_signal+sin(2*pi*aux1*fundamental_frequency/fs.*n);
        aux1 = aux1 + 1;
    end
    harmonic_signal = harmonic_signal/max(harmonic_signal);
end
