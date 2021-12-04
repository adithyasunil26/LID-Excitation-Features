import pandas as pd
import numpy as np
from scipy.signal import savgol_filter
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
# !pip install librosa
import librosa
from tqdm.auto import tqdm

print('Loading data...')
gvv=pd.read_csv('generated_csvs/gvv.csv', header=None)
print('GVV loaded')
res=pd.read_csv('generated_csvs/res.csv', header=None)
print('LP residual loaded')
zff=pd.read_csv('generated_csvs/zff.csv', header=None)
print('ZFF loaded')
labels=pd.read_csv('generated_csvs/labels.csv', header=None)
print('labels loaded')

avg_int_gvv=np.zeros(len(gvv))

print('Processing GVV')

with tqdm(total=len(gvv)) as pbar:
  for index, row in gvv.iterrows():
    yhat = savgol_filter(row, 51, 3)
    # plt.plot(yhat)
    peaks, _ = find_peaks(yhat, height=0)
    # plt.plot(peaks, yhat[peaks], "x")
    diff=[]
    # print(peaks)
    for i in range(1,len(peaks)):
      # print(peaks[i], peaks[i-1], peaks[i]-peaks[i-1])
      diff.append(peaks[i]-peaks[i-1])
    avg_int_gvv[index]=sum(diff)/len(diff)
    pbar.update(1)

print('Processing ZFF')

avg_int_ep_inst=np.zeros(len(zff))
avg_int_ep_str=np.zeros(len(zff))

with tqdm(total=len(zff)) as pbar:
  for index, row in zff.iterrows():
    # plt.plot(row)
    negpeak = np.where(np.diff(np.sign(row))==2)[0]
    pospeak = negpeak+1
    # plt.plot(pospeak, row[pospeak], "x")
    # plt.plot(negpeak, row[negpeak], "x")
    ep_inst = (negpeak+pospeak)/2
    # plt.plot(ep_inst, np.zeros(len(ep_inst)), "x")
    diff = np.diff(ep_inst)
    avg_int_ep_inst[index]=sum(diff)/len(diff)
    # print(avg_int_ep_inst)

    slope=np.zeros(len(negpeak))
    for i in range(len(negpeak)):
      slope[i]=(row[pospeak[i]]-row[negpeak[i]])/(pospeak[i]-negpeak[i])
    avg_int_ep_str[index]=sum(slope)/len(slope)
    # print(avg_int_ep_str)
    pbar.update(1)

print('Processing RMFCC')
avg_rmfcc_mag=np.zeros(len(res))

with tqdm(total=len(res)) as pbar:
  for index, row in res.iterrows():
    rmfcc=librosa.feature.mfcc(np.array(row))
    # print(rmfcc)

    k=[]
    for i in rmfcc:
      k.append(sum(i)/len(i))

    rmfcc = k

    avg_rmfcc_mag[index]=sum(rmfcc)/len(rmfcc)
    pbar.update(1)

print('Processing labels')
lang=[]
with tqdm(total=len(labels)) as pbar:
  for index, row in labels.iterrows():
    lang.append(row[0].split("_")[2])
    pbar.update(1) 
lang=np.array(lang)

print('Saving data')
data=[avg_int_gvv, avg_int_ep_str, avg_int_ep_inst, avg_rmfcc_mag, lang]
print(data)
print("Creating df")
df=pd.DataFrame(data=np.transpose(data), columns=['gvv','ep_str','ep_inst','rmfcc','lang'])
print(df)
df.to_csv("generated_csvs/df.csv")
print('CSV generated at generated_csvs/df.csv')
