fs = 16000;              % Sampling Frequency 
t = hamming(6000); % Hamming window to smooth the speech signal 
w = [t ; zeros(10000,1)]; 
f = (1:16000); 
mel(f) = 2595 * log(1 + f / 700); % Linear to Mel frequency scale conversion  
tri = triang(100); 
win1 = [tri ; zeros(15900,1)]; % Defining overlapping triangular windows for  
win2 = [zeros(50,1) ; tri ; zeros(15850,1)]; % frequency domain analysis 
win3 = [zeros(100,1) ; tri ; zeros(15800,1)]; 
win4 = [zeros(150,1) ; tri ; zeros(15750,1)]; 
win5 = [zeros(200,1) ; tri ; zeros(15700,1)]; 
win6 = [zeros(250,1) ; tri ; zeros(15650,1)]; 
win7 = [zeros(300,1) ; tri ; zeros(15600,1)]; 
win8 = [zeros(350,1) ; tri ; zeros(15550,1)]; 
win9 = [zeros(400,1) ; tri ; zeros(15500,1)]; 
win10 = [zeros(450,1) ; tri ; zeros(15450,1)]; 
win11 = [zeros(500,1) ; tri ; zeros(15400,1)]; 
win12 = [zeros(550,1) ; tri ; zeros(15350,1)]; 
win13 = [zeros(600,1) ; tri ; zeros(15300,1)]; 
win14 = [zeros(650,1) ; tri ; zeros(15250,1)]; 
win15 = [zeros(700,1) ; tri ; zeros(15200,1)]; 
win16 = [zeros(750,1) ; tri ; zeros(15150,1)]; 
win17 = [zeros(800,1) ; tri ; zeros(15100,1)]; 
win18 = [zeros(850,1) ; tri ; zeros(15050,1)]; 
win19 = [zeros(900,1) ; tri ; zeros(15000,1)]; 
win20 = [zeros(950,1) ; tri ; zeros(14950,1)]; 
y = audioread('TestNo\M No (8).wav');%%%%change the testing path and value
i = 1; 
while abs(y(i)) < 0.05             % Silence Detection 
     i = i + 1; 
end 
y(1 : i) = []; 
y(10000 : 16000) = 0; 
y1 = y.* w; 
my = fft(y1);                         % Transform to frequency domain 
ny = abs(my(floor(mel(f)))); % Mel warping 
ny = ny./ max(ny); 
ny1 = ny.* win1;
ny2 = ny.* win2; 
ny3 = ny.* win3; 
ny4 = ny.* win4; 
ny5 = ny.* win5; 
ny6 = ny.* win6; 
ny7 = ny.* win7; 
ny8 = ny.* win8; 
ny9 = ny.* win9; 
ny10 = ny.* win10; 
ny11 = ny.* win11;  
ny12 = ny.* win12; 
ny13 = ny.* win13; 
ny14 = ny.* win14; 
ny15 = ny.* win15; 
ny16 = ny.* win16; 
ny17 = ny.* win17; 
ny18 = ny.* win18; 
ny19 = ny.* win19; 
ny20 = ny.* win20; 
sy1 = sum(ny1.^ 2); 
sy2 = sum(ny2.^ 2); 
sy3 = sum(ny3.^ 2); 
sy4 = sum(ny4.^ 2); 
sy5 = sum(ny5.^ 2); 
sy6 = sum(ny6.^ 2); 
sy7 = sum(ny7.^ 2); 
sy8 = sum(ny8.^ 2); 
sy9 = sum(ny9.^ 2); 
sy10 = sum(ny10.^ 2); % Determine the energy of the signal within each window 
sy11 = sum(ny11.^ 2); % by summing square of the magnitude of the spectrum 
sy12 = sum(ny12.^ 2); 
sy13 = sum(ny13.^ 2); 
sy14 = sum(ny14.^ 2); 
sy15 = sum(ny15.^ 2); 
sy16 = sum(ny16.^ 2); 
sy17 = sum(ny17.^ 2); 
sy18 = sum(ny18.^ 2); 
sy19 = sum(ny19.^ 2); 
sy20 = sum(ny20.^ 2); 
sy = [sy1, sy2, sy3, sy4, sy5, sy6, sy7, sy8, sy9, sy10, sy11, sy12, sy13, sy14, sy15, sy16, sy17, sy18, sy19, sy20];  
          
sy = log(sy);  
dy = dct(sy);              % Determine DCT of Log of the spectrum energies 
fid = fopen('sample.dat', 'r'); 
dx = fread(fid, 20, 'real*8'); % Store this feature vector as a .dat file 
fclose(fid);
dx = dx.';
MSE=(sum((dx - dy).^ 2)) / 20;
%{
 if MSE<5
   disp('NO');
 end
%}