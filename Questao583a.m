% 190107227 Gabriel Pantoja da Silva
% Questão 5.8-3 item a
clear;clf;
ts=0.000104; % periodo de amostragem em 1/fs = 1/9600 s
t=[0:ts:0.2]; % duracao da simulacao em 0.2 s
mt=2*cos(2*pi*400*t)+cos(2*pi*800*t)-3*sin(2*pi*1200*t); % sinal com componentes de frequencia 
                                                         % em 400Hz, 800Hz e 1200Hz
tamanhoSinal=length(mt);
novots=0.00104; % novo periodo de amostragem 10/fs = 1/960 s.
Nfact=novots/ts;
% Envia o sinal para um quantizador uniforme de 16 niveis
passo=0.2; % usando um passo E = 0.2 para a modulacao 
s_DMout1=deltamod(mt,passo,ts,novots);
% Acima foi obtido o sinal modulado pelo uso da funcao deltamod
% Plota o sinal mensagem e o sinal modulado no dominio do tempo
figure(1);
subplot(311);sfig1=plot(t,mt,'k',t,s_DMout1(1:tamanhoSinal),'b');
set(sfig1,'Linewidth',2);
title('Sinal {\it m}({\it t}) e sinal modulado')
xlabel('tempo (segundos)'); axis([0 0.2 -6.2 6.2]);