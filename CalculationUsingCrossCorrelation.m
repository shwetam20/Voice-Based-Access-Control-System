%%
[x,fs] = audioread('TrainYes\F Yes (1).wav');%taking samples for 'Yes'
x=x-mean(x);
[y,fs] = audioread('TrainNo\F No (1).wav');%taking samples for 'No'
y=y-mean(y);
[voice,fs] = audioread('TestYes\F Yes (6).wav');%voice sample to be identified
voice=voice-mean(voice);
%%%%%%%%%%%%%% frequency domain and time domain.
nfft = min(1023,length(voice)); 
s=specgram(voice, nfft, fs, hanning(511),380);%STFT of 'voice'
s1=specgram(x, nfft, fs, hanning(511),380);%STFT of 'Yes'
s2=specgram(y, nfft, fs, hanning(511),380);%STFT of 'No'
%taking transpose of the STFT
absolute=transpose(abs(s)); 
absolute1=transpose(abs(s1));
absolute2=transpose(abs(s2));
a4=sum(absolute); 
a5=sum(absolute1);
a6=sum(absolute2);
% normalize the spectrum 
a4_norm=(a4-min(a4))/(max(a4)-min(a4));
a5_norm=(a5-min(a5))/(max(a5)-min(a5));
a6_norm=(a6-min(a6))/(max(a6)-min(a6));
%transpose row to column vector
F4=transpose(a4_norm);
F5=transpose(a5_norm);
F6=transpose(a6_norm);
N=length(F4);
rx1=xcorr(F5,F5);
rx2=xcorr(F6,F6);
d=F4;
rdx1=xcorr(F4,F5);%cross-correlation with 'Yes'
rdx2=xcorr(F4,F6);%cross-correlation with 'No'
rd=xcorr(d,d);
for p=1:2
rx_1=rx1(N:N+p-1);
rdx_1=rdx1(N:N+p-1);
Rx1=toeplitz(rx_1, rx_1);
det(Rx1);
I=inv(Rx1);
w=I*rdx_1;
e1(p)=rd(N)-transpose(w)*rdx_1;
end
for p=1:2
    rx_2=rx2(N:N+p-1);
rdx_2=rdx2(N:N+p-1);
Rx2=toeplitz(rx_2, rx_2);
det(Rx2);
I=inv(Rx2);
w=I*rdx_2;
e2(p)=rd(N)-transpose(w)*rdx_2;
end
m1=mean(e1);
m2=mean(e2);
