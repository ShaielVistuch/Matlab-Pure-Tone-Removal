close all
clc
clear
% Generation of noisy signal
% Enter your ID 
ID = ____________;
[inputSignal,fs,SNR_in] = inputSignalBuilder(ID);
soundsc(inputSignal,fs)
figure();plot(0:length(inputSignal)-1,inputSignal);
xlabel('n','fontsize',16);
ylabel('signal','fontsize',16);

audiowrite(['Input_' num2str(ID) '.wav'],inputSignal,fs)
[x, fs]= audioread('about_time.wav');
SNR_in = 10*log10(mean(x.^2)/mean((inputSignal-x).^2));

%% Noise frequency detection
%   In this part the input signal is examined. We assume a pure tone
%   disturbance of cos(w_0*n), and have to locate w_0=(2*pi/N)*k0
%   the cosine wave is periodic with N=512

%% Fourier Discrete Transform - Detect w_0 from the last frame of the signal
Nframe=512;
x_last_frame=inputSignal((end-Nframe+1):end);

% plot x_last_frame DTFT to detect w_0
% dont forget to define w axis to plot the DTFT in right scale
n=-256:255;
Nw=512;
x_temp=x_last_frame;

[X,omega]=my_DTFT(x_temp,n,Nw);
figure(); 
stem (omega, X);
grid on; title('DTFT transform of x'); ylabel('amplitude'); xlabel('frequency');
%% Band stop with III implementations
%%%%% Implemetation I : perfect filtering (FIR)
N = 1000;
n=-256:255;
B =  pi/50;
[M,I] = max(X); %determines where the upside down picks are
% M is the X-omega value at the upside down pick
% I is the index of M place in the vector X
w0 = omega(I);
var_1=sinc(B*n/pi)*B/pi;
var_2 =2*cos(w0*n);
h_1=var_1.*var_2;

[H1,omega_1]=my_DTFT(h_1,n,Nw);
figure(); 
stem (omega_1, H1);
grid on; title('DTFT transform of h_1'); ylabel('amplitude'); xlabel('frequency');

% Note- you can use conv() function to filter the signal. 
% use the option 'same' to get the same output length.
% for example if you have: input-x filter-h:
% y= conv(x,h,'same')

v_1=conv(x,h_1,'same');
y_1 = x-v_1 ;

audiowrite(['Output_I_' num2str(ID) '.wav'],y_1,fs)
SNR_out1 = 10*log10(mean(x.^2)/mean((y_1-x).^2));
%soundsc(real(y_1),fs);
%%%Freaquency response- H_1(e^jw)

%TODO
%%
%%%%% Implemetation II : ZOH design (FIR)
N = 100;
n = -N:N;
[M,I] = max(X); %determines where the upside down picks are
% M is the X-omega value at the upside down pick
% I is the index of M place in the vector X
w0 = omega(I);
%var_2 =  2*cos(n*w0);
%var_3=1/(2*N+1);
h_2 =2*cos(n*w0)/(2*N+1);

v_2=conv(x,h_2,'same');
y_2 = x-v_2;

[H2,omega_2]=my_DTFT(h_2,n,Nw);
figure(); 
stem (omega_2, H2);
grid on; title('DTFT transform of h_2'); ylabel('amplitude'); xlabel('frequency');


audiowrite(['Output_II_' num2str(ID) '.wav'],y_2,fs);
SNR_out2 = 10*log10(mean(x.^2)/mean((y_2-x).^2));
%soundsc(real(y_2),fs);
%%% Freaquency response- H_2(e^jw)

%TODO
%%
%%%%% Implemetation III : recursive design (IIR)
n=1:11000;
Nw=512;
alpha = 0.999;
z_1=0; % initial rest
z_2=0; 

for int=1:length(x)
    z_1 = alpha*exp(1i*w0)*z_1+(1-alpha)*x(int);
    z_2 = alpha*exp(-1i*w0)*z_2+(1-alpha)*x(int);
    y_3(int,1) =x(int)-z_1-z_2;
end

[Y,omega_temp]=my_DTFT(y_3(1:11000),n,Nw); %forrier transform for y_3
[X,omega_temp_1]=my_DTFT(x(1:11000),n,Nw); %forrier transform for x
H_3=Y./X; %impulse response
figure(); 
plot(omega_temp, H_3);
grid on; title('DTFT transform of h_3'); ylabel('amplitude'); xlabel('frequency');


audiowrite(['Output_III_' num2str(ID) '.wav'],real(y_3),fs)
SNR_out3 = 10*log10(mean(x.^2)/mean((y_3-x).^2))
%soundsc(real(y_3),fs)

%% Performace evaluation:

[Grade, SNR_out_ref]= GradeMyOutput(ID,y_1,1);
[Grade, SNR_out_ref]= GradeMyOutput(ID,y_2,2);
[Grade, SNR_out_ref]= GradeMyOutput(ID,real(y_3),3);
