clear;clf;
td=0.000104; % periodo de amostragem inicial de 1/9600
t=[0:td:0.2]; % duracao da simulacoa em 0.2 s
mt=2*cos(2*pi*400*t)+cos(2*pi*800*t)-3*sin(2*pi*1200*t); % sinal com componentes de frequencia 
                                                         % em 400Hz, 800Hz e 1200Hz
Lsig=length(mt);
ts=0.00104; % novo periodo de amostragem de 1/960
Nfact=ts/td;
% Envia o sinal para um quantizador uniforme de 16 niveis
Delta1=8.2; % Foi selecionado um passo de 8.2
s_DMout1=deltamod(mt,Delta1,td,ts);
% obtencao do sinal modulado
% Plota o sinal mt e o sinal modulado com passo de 8.2
figure(1);
subplot(311);sfig1=plot(t,mt,'k',t,s_DMout1(1:Lsig),'b');
set(sfig1,'Linewidth',2);
title('Sinal {\it m}({\it t}) e sinal modulado com passo de 8.2')
xlabel('tempo (segundos.)'); axis([0 0.2 -12.2 12.2]);