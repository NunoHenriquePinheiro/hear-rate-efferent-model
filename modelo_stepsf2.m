clc
clear all

% MODELO PARA A VARIAÇÃO DE HRv EM FUNÇÃO DE VÁRIOS STEPS DE F2

% Aqui, pretendemos simular os gráficos das figs.7 e 9 do artigo analisado,
% relacionando a variação do batimento cardíaco (HRv) ao longo do tempo,
% consoante vários steps de frequência diferente, nos nervos vagos (f2).
% Assim, temos, como parâmetro de entrada, o vector de frequências
% f2, e, como parâmetro de saída, o HRv ao longo do tempo, num só gráfico
% (para poder comparar os aspectos estudados no artigo).

% Implementámos o método de Euler, nas eqs. diferenciais existentes.
%--------------------------------------------------------------------------

f2=[7.5 4 1.5 6 10];                                                                    % f2 utilizadas no artigo, com as variáveis da fig.9 antes da fig.7 

% Os restantes parâmetros de entrada necessários são os mesmos das
% simulações individuais de cada f2:

C1=1; C2(1)=1; P0=30; P(1)=P0; N(1)=270; Nm=450; HRv(1)= 60/(P0); V2=0.01414; n=8;      % condições iniciais
k7=2.75; k8=0.69; k9=0.87; k10=0.01;                                                    % constantes necessarias

a=1; h=0.01;                                                                            % contador e passo, para os ciclos

% O tempo, no eixo das abcissas do gráfico, varia entre t=0seg e t=280seg.

% No intervalo t=[0,30]seg, f2=0:
for i=h:h:30
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]30,45]seg, f2=7.5:
for i=(30+h):h:45
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(1) );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(1) - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]45,60]seg, f2=0:
for i=(45+h):h:60
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]60,75]seg, f2=4:
for i=(60+h):h:75
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(2) );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(2) - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]75,85]seg, f2=0:
for i=(75+h):h:85
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]85,95]seg, f2=1.5:
for i=(85+h):h:95
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(3) );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(3) - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]95,150]seg, f2=0:
for i=(95+h):h:150
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]150,180]seg, f2=6:
for i=(150+h):h:180
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(4) );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(4) - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]180,220]seg, f2=0:
for i=(180+h):h:220
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]220,250]seg, f2=10:
for i=(220+h):h:250
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(5) );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(5) - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

% No intervalo t=]250,280]seg, f2=0:
for i=(250+h):h:280
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

t=0:h:280;
t1=0:h:30; t2=(30+h):h:45; t3=(45+h):h:60; t4=(60+h):h:75; t5=(75+h):h:85;
t6=(85+h):h:95; t7=(95+h):h:150; t8=(150+h):h:180; t9=(180+h):h:220; t10=(220+h):h:250; t11=(250+h):h:280;

freq2 = [zeros(size(t1)) f2(1)*ones(size(t2)) zeros(size(t3)) f2(2)*ones(size(t4)) zeros(size(t5)) f2(3)*ones(size(t6)) zeros(size(t7)) f2(4)*ones(size(t8)) zeros(size(t9)) f2(5)*ones(size(t10)) zeros(size(t11))];


figure(1)
plot(t,HRv), grid, axis([0 280 0 2.2])
xlabel('Tempo (s)'), ylabel('Batimento Cardíaco, HRv (batim./s)')
title(' Efeito de diferentes f2 no Batimento Cardíaco (HRv) ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq2), axis([0 280 0 f2(5)+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com os vários steps de f2 ','Color','b','FontName','Arial','FontSize',11 )


