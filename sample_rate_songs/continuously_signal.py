#Define the images parameters
import matplotlib
import numpy as np 
def signal_simulation(fc, fs, tempo_amostrando, phase=0):
        n_samples = np.arange(0,fs*tempo_amostrando, 1)
        sinal_senoidal = np.zeros(n_samples.size)

        for aux1 in fc:
                sinal_senoidal += np.sin(2*np.pi*(aux1/fs)*n_samples + phase)
        t = (1/fs)*n_samples       
        sinal_senoidal = np.round(sinal_senoidal,20) 
        return t,sinal_senoidal