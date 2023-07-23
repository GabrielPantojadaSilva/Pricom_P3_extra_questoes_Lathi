function sinal_modulado= deltamod(sinal_entrada,Delta,ta,novoTa)
% passo - passo da modulação       
% sinal_entrada - sinal de entrada
% ta - periodo de amostragem inicial do sinal de entrada
% novoTa - novo periodo de amostragem
% Saídas:
% sinal_modulado - sinal de saida ja modulado
if (rem(novoTa/ta,1)==0)
nfac=round(novoTa/ta);
p_zoh=ones(1,nfac);
s_down=downsample(sinal_entrada,nfac);
Num_it=length(s_down);
sinal_modulado(1)=-Delta/2;
for k=2:Num_it
xvar=sinal_modulado(k-1);
sinal_modulado(k)=xvar+Delta*sign(s_down(k-1)-xvar);
end
sinal_modulado=kron(sinal_modulado,p_zoh);
else
warning('Erro! novoTa/ta nao eh inteiro!');
sinal_modulado=[];
end
end