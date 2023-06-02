import os
import wfdb
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import savemat
if os.path.isdir("mitdb"):
    print('You already have the data.')
else:
    wfdb.dl_database('mitdb', 'mitdb')

#record = wfdb.rdsamp('mitdb/104')
#annotation = wfdb.rdann('mitdb/100', 'atr', sampto=3000)

record = wfdb.rdsamp('mitdb/114')
AllData = record[0][:,1]
fs = record[1]['fs']
SegData = AllData[186390:193550]
SegData = AllData[192950:193340]
ECG_data = AllData
ECG_seg_data = SegData
savemat("ECG_signal.mat",{"ECG_data":ECG_data,"ECG_seg_data":ECG_seg_data,"fs":fs})