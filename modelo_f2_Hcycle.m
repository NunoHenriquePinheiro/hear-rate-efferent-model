clc
clear all

% MODELO DO PER�ODO DO CICLO CARD�ACO, EM FUN��O DE F2

% Aqui, pretendemos simular a varia��o do per�odo do ciclo card�aco, em
% fun��o da frequ�ncia de estimula��o dos nervos vagos (f2), que segue a
% f�rmula introduzida. Us�mos todos os valores de f2 mencionados nos
% gr�ficos do artigo analisado (s�o o nosso vector de input).

% Pretendemos observar a varia��o do per�odo (output), chegando a um
% plateau de valores limitados por uma assimptota, entre P=2seg e P=2.5seg,
% que ser� uma fronteira cr�tica, para al�m da qual a despolariza��o
% espont�nea n�o poder� ocorrer.
%--------------------------------------------------------------------------

freq2= [0 0.5 1 1.5 3 4 5.5 6 7.5 8 10 12]; P=[];

for i=1:1:length(freq2)
    P(i)= 0.5 + (0.65*freq2(i))/(1+0.25*freq2(i));
end

plot(freq2,P,'b',freq2,P,'rs'), grid, text(4.1,1.7,'P = 0.5 + 0.65*f2/(1+0.25*f2)','Color','r'), axis([0 12 0 2.6])
xlabel('Frequ�ncias f2 testadas (Hz)','FontName','Arial','FontSize',12), ylabel('Per�odo do Ciclo Card�aco (s)','FontName','Arial','FontSize',12)
title(' Modeliza��o do per�odo do ciclo card�aco, medido depois do batimento card�aco estabilizar, para as dadas frequ�ncias f2 ','Color','b','FontName','Arial','FontSize',14 )
