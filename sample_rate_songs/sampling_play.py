import numpy as np
import sounddevice as sd

fs = 44100
seg = 40
n = np.linspace(0,44100*seg,1)
fc = 4400
data = np.sin(2*np.pi*fc/fs*n)
sd.play(data, fs)