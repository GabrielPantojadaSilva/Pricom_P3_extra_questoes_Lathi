clear;clf;
td=0.00025; % periodo de amostragem em 1/4000 s
t=[0:td:0.2]; % intervalo de simulacao em 0.2 segundos
xsig=2*cos(2*pi*400*t)+cos(2*pi*800*t) - 3*sin(2*pi*1200*t); % componenetes de frequencia sao 400Hz, 800Hz e 1200Hz
Lsig=length(xsig);
ts=0.0025; % novo periodo de amostragem em 1/400 s.
Nfactor=ts/td;
% envia o sinal para um quantizador uniforme de 16 niveis
[s_out,sq_out,sqh_out,Delta,SQNR]=sampandquant(xsig,16,td,ts);
% 3 sinais são devolvidos:
% 1. sinal amostrado s_out
% 2. sinal amostrado e quantizado sq_out
% 3. sinal amostrado, quantizado e zero-holder sqh_out
%
% calculo da transformada de Fourier
Lfft=2^ceil(log2(Lsig)+1);
Fmax=1/(2*td);
Faxis=linspace(-Fmax,Fmax,Lfft);
Xsig=fftshift(fft(xsig,Lfft));
S_out=fftshift(fft(s_out,Lfft));
% Amostrage e reconstrução do sinal com uso de
% a) Trem de impulsos através do LPF
% b) Reconstrucao por pulso
% Plotagem do grafico e das amostras no tempo e frequencia
figure(1);
subplot(311); sfig1a=plot(t,xsig,'k-');
hold on; sfig1b=plot(t,s_out(1:Lsig),'b'); hold off;
set(sfig1a,'Linewidth',2); set(sfig1b,'Linewidth',2.);
xlabel('tempo (segundos)');
title('Sinal {\it m}({\it t}) e amostras uniformes');
subplot(312); sfig1c=plot(Faxis,abs(Xsig));
xlabel('frequencia (Hz)');
axis([-3000 3000 0 6000])
set(sfig1c,'Linewidth',1); title('Espectro of {\it m}({\it t})');
subplot(313); sfig1d=plot(Faxis,abs(S_out));
xlabel('frequencia (Hz)');
axis([-3000 3000 0 6000/Nfactor])
set(sfig1c,'Linewidth',1); title('Espectro de {\it m}_T({\it t})');
% Calculo do sinal reconstruido a partir da amostragem ideal e do filtro PB
% Maxima largura de banda do filtro eh BW=floor((Lfft/Nfactor)/2);
BW=2000; %Largura de banda nao eh maior que 2000Hz.
H_lpf=zeros(1,Lfft);H_lpf(Lfft/2-BW:Lfft/2+BW-1)=1; %Filtro PB ideal
S_recv=Nfactor*S_out.*H_lpf; % Filtragem ideal
s_recv=real(ifft(fftshift(S_recv))); % reconstrucao no dominio da frequencia
s_recv=s_recv(1:Lsig); % reconstrucao no dominio do tempo
% plota o sinal reconstruido idealmente no tempo e na frequencia
figure(2)
subplot(211); sfig2a=plot(Faxis,abs(S_recv));
xlabel('frequencia (Hz)');
axis([-3000 3000 0 6000]);
title('Espectro da filtragem ideal (recosntrucao)');
subplot(212); sfig2b=plot(t,xsig,'k-.',t,s_recv(1:Lsig),'b');
legend('sinal mensagem','sinal reconstruido');
xlabel('tempo (segundos)');
title('sinal mensagem versus sinal idealmente reconstruido');
set(sfig2b,'Linewidth',2);
% reconstrucao nao ideal
ZOH=ones(1,Nfactor);
s_ni=kron(downsample(s_out,Nfactor),ZOH);
S_ni=fftshift(fft(s_ni,Lfft));
S_recv2=S_ni.*H_lpf; % filtragem ideal
s_recv2=real(ifft(fftshift(S_recv2))); % reconstrucao no dominio da frequencia
s_recv2=s_recv2(1:Lsig); % reconstrucao no dominio do tempo
% plota o sinal reconstruido idealmente no tempo e na frequencia
figure(3)
subplot(211); sfig3a=plot(t,xsig,'b',t,s_ni(1:Lsig),'b');
xlabel('tempo (segundos)');
title('sinal mensagem versus reconstrucao por trem de pulsos ');
subplot(212); sfig3b=plot(t,xsig,'b',t,s_recv2(1:Lsig),'b--');
legend('sinal mensagem','reconstrucao LPF');
xlabel('tempo (segundos)');
set(sfig3a,'Linewidth',2); set(sfig3b,'Linewidth',2);
title('sinal mensagem e reconstrucao por trem de pulsos via LPF');
