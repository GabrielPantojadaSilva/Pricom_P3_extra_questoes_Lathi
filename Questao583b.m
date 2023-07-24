% (ExDM.m)
% Example of sampling, quantization, and zero-order hold
clear;clf;
td=0.000104; % periodo de amostragem inicial de 1/9600
t=[0:td:0.2]; % duracao da simulacoa em 0.2 s
mt=2*cos(2*pi*400*t)+cos(2*pi*800*t)-3*sin(2*pi*1200*t); % sinal com componentes de frequencia 
                                                         % em 400Hz, 800Hz e 1200Hz
Lsig=length(mt);
ts=0.00104; % novo periodo de amostragem de 1/960
Nfact=ts/td;
% Envia o sinal para um quantizador uniforme de 16 niveis
Delta1=0.2; % Foi selecionado um passo inicial de 0.2
s_DMout1=deltamod(mt,Delta1,td,ts);
% obtencao do sinal modulado
% Plota o sinal mt e o sinal modulado com passo de 0.2
figure(1);
subplot(311);sfig1=plot(t,mt,'k',t,s_DMout1(1:Lsig),'b');
set(sfig1,'Linewidth',2);
title('Sinal {\it m}({\it t}) e sinal modulado com passo de 0.2')
xlabel('tempo (segundos.)'); axis([0 0.2 -2.2 2.2]);
%
% Novo passo igual ao dobro do anterior
Delta2=2*Delta1; %
s_DMout2=deltamod(mt,Delta2,td,ts);
% obtencao do sinal modulado com novo passo
% Plota o sinal mt e o sinal modulado gerado
subplot(312);sfig2=plot(t,mt,'k',t,s_DMout2(1:Lsig),'b');
set(sfig2,'Linewidth',2);
title('Sinal {\it m}({\it t}) e sinal modulado com passo de 0.4')
xlabel('tempo (segundos)'); axis([0 0.2 -2.2 2.2]);
%
Delta3=2*Delta2; % Dobra o passo anterior
s_DMout3=deltamod(mt,Delta3,td,ts);
% Plota o sinal mt e o novo sinal modulado
subplot(313);sfig3=plot(t,mt,'k',t,s_DMout3(1:Lsig),'b');
set(sfig3,'Linewidth',2);
title( 'Sinal {\it m}({\it t}) e sinal modulado com passo de 0.8')
xlabel('tempo (segundos)'); axis([0 0.2 -2.2 2.2]);