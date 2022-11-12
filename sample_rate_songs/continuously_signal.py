#Define the images parameters
import matplotlib
import numpy as np 
def signal_simulation(tempo_amostrando):
        fc = 440 #frequência do sinal
        fs = 8800000 #frequência de amostragem
        periodo_amostral = 1/fs
        n_samples = np.arange(0,fs*tempo_amostrando, 1)
        sinal_senoidal = np.sin(2*np.pi*fc/fs*n_samples)
        t = (1/fs)*n_samples
        
        return t,sinal_senoidal