close all; clc; clear all;
%input signal
[y, Fs]= audioread('C:\Users\nessm\Documents\MATLAB/OriginalAudio.wav');

dt = 1/Fs;
t = 0:dt:(length(y)*dt)-dt;
%sound(y, Fs);

subplot(2,5,1);
plot(t, y);
ylabel('original sound'); xlabel("time(sec)");

%determination of impulse response

%strong 
M = 1; 
hn1 = zeros(2*Fs+1,1); 
hn1(M+0) = 1;
hn1(M+0.2*Fs) = 0.8;
hn1(M+0.6*Fs) = 0.6;
hn1(M+0.8*Fs) = 0.4;
hn1(M+Fs) = 0.2;
hn1(M+1.5*Fs) = 0.1;

subplot(2,5,2);
stem(hn1);
ylabel('strong impulse'); xlabel("samples rate");

%medium 
hn2 = zeros(2*Fs+1,1); 
hn2(M+0) = 1;
hn2(M+0.2*Fs) = 0.75;
hn2(M+0.8*Fs) = 0.5;
hn2(M+1.5*Fs) = 0.2;

subplot(2,5,3);
stem(hn2);
ylabel('medium impulse'); xlabel("samples rate");

%weak 
hn3 = zeros(2*Fs+1,1); 
hn3(M+0) = 1;
hn3(M+1.5*Fs) = 0.5;

subplot(2,5,4);
stem(hn3);
ylabel('weak impulse'); xlabel("samples rate");

%generationg the echo using convolution 

%strong
echo1 = conv(y,hn1,'same');
%sound(echo1, Fs);

echoFilename1 = 'C:\Users\nessm\Documents\MATLAB/strong_echo.wav';
audiowrite(echoFilename1, echo1, Fs);

subplot(2,5,5);
plot( t, echo1);
ylabel('strong echo signal');xlabel("time(sec)");

%medium
echo2 = conv(y,hn2,'same');
%sound(echo2, Fs);

echoFilename2 = 'C:\Users\nessm\Documents\MATLAB/medium_echo.wav';
audiowrite(echoFilename2, echo2, Fs);

subplot(2,5,6);
plot( t, echo2);
ylabel('medium echo signal');xlabel("time(sec)");

%weak
echo3 = conv(y,hn3,'same');
%sound(echo3, Fs);

echoFilename3 = 'C:\Users\nessm\Documents\MATLAB/weak_echo.wav';
audiowrite(echoFilename3, echo3, Fs);

subplot(2,5,7);
plot( t, echo3);
ylabel('weak echo signal');xlabel("time(sec)");

%removing the echo

%strong
L1 = length(echo1);

echo1_fft = fft(echo1);

hn1_fft= fft(hn1,L1);

z1 = echo1_fft./hn1_fft;

recovered_signal1 = real(ifft(z1));
%sound(recovered_signal1,Fs);

recoveredsignalFilename1 = 'C:\Users\nessm\Documents\MATLAB/strong_echo_recovered_signal.wav';
audiowrite(recoveredsignalFilename1, recovered_signal1, Fs);

subplot(2,5,8);
plot(t, recovered_signal1);
ylabel('strong echo recovered signal');xlabel("time(sec)");

%medium
L2= length(echo2);

echo2_fft = fft(echo2);

hn2_fft= fft(hn2,L2);

z2 = echo2_fft./hn2_fft;

recovered_signal2 = real(ifft(z2));
%sound(recovered_signa2,Fs);

recoveredsignalFilename2 = 'C:\Users\nessm\Documents\MATLAB/medium_echo_recovered_signal.wav';
audiowrite(recoveredsignalFilename2, recovered_signal2, Fs);

subplot(2,5,9);
plot(t, recovered_signal2);
ylabel('medium echo recovered signal');xlabel("time(sec)");

%weak
L3 = length(echo3);

echo3_fft = fft(echo3);

hn3_fft= fft(hn3,L3);

z3 = echo3_fft./hn3_fft;

recovered_signal3 = real(ifft(z3));
%sound(recovered_signal3,Fs);

recoveredsignalFilename3 = 'C:\Users\nessm\Documents\MATLAB/weak_echo_recovered_signal.wav';
audiowrite(recoveredsignalFilename3, recovered_signal3, Fs);

subplot(2,5,10);
plot(t, recovered_signal3);
ylabel('weak echo recovered signal');xlabel("time(sec)");

clear all;