clc
clear all

% MODELO DO PERÍODO DO CICLO CARDÍACO, EM FUNÇÃO DE F2

% Aqui, pretendemos simular a variação do período do ciclo cardíaco, em
% função da frequência de estimulação dos nervos vagos (f2), que segue a
% fórmula introduzida. Usámos todos os valores de f2 mencionados nos
% gráficos do artigo analisado (são o nosso vector de input).

% Pretendemos observar a variação do período (output), chegando a um
% plateau de valores limitados por uma assimptota, entre P=2seg e P=2.5seg,
% que será uma fronteira crítica, para além da qual a despolarização
% espontânea não poderá ocorrer.
%--------------------------------------------------------------------------

freq2= [0 0.5 1 1.5 3 4 5.5 6 7.5 8 10 12]; P=[];

for i=1:1:length(freq2)
    P(i)= 0.5 + (0.65*freq2(i))/(1+0.25*freq2(i));
end

plot(freq2,P,'b',freq2,P,'rs'), grid, text(4.1,1.7,'P = 0.5 + 0.65*f2/(1+0.25*f2)','Color','r'), axis([0 12 0 2.6])
xlabel('Frequências f2 testadas (Hz)','FontName','Arial','FontSize',12), ylabel('Período do Ciclo Cardíaco (s)','FontName','Arial','FontSize',12)
title(' Modelização do período do ciclo cardíaco, medido depois do batimento cardíaco estabilizar, para as dadas frequências f2 ','Color','b','FontName','Arial','FontSize',14 )
