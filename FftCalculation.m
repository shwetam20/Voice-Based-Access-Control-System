clc;
[x,fs] = audioread('TrainNo\F No (1).wav');
[y,fs] = audioread('TrainYes\F Yes (1).wav');
[voice,fs] = audioread('TestYes\F Yes (6).wav');
%threshold = 12; % threshold value 
N = length(x);
M = length(y);
V = length(voice);
k11 = round(N*5000/fs);
k12 = round(N*8000/fs);
k21 = round(M*5000/fs);
k22 = round(M*8000/fs);
k1 = round(V*5000/fs);
k = round(V*8000/fs);
X = abs(fft(x));
Y = abs(fft(y));
Z = abs(fft(voice));
semilogy(X,'g');
hold on;
semilogy(Y,'b');
legend('No','Yes');
f1 = sum(X(1:k11))/sum(X(k11:k12));
f2 = sum(Y(1:k21))/sum(Y(k11:k22));
f = sum(Z(1:k11))/sum(Z(k11:k12));
%{
if f < threshold
    output = 'yes';
else
    output = 'no';
end
%}

