clc
clear all

% MODELO PARA O EFEITO DOS NERVOS VAGOS NO BATIMENTO CARDÍACO (HRv)

% Implementámos o método de Euler, nas eqs. diferenciais existentes.

% Desejamos observar o efeito de um único step input de frequência (aqui,
% testamos vários inputs de f2, mas separadamente - introduzidos pelo
% utilizador) nos nervos vagos (f2), sobre o HRv (que é o nosso
% principal output).

% Além da variação de HRv, também queremos relacionar a variação do número
% de vesículas de acetilcolina (N) e da concentração C2 com o step input de
% f2 introduzido.

% Introduzimos o step de f2 entre intervalos de tempo com f2 = 0 Hz, de
% modo a destacar bem o seu efeito (de acordo com o pretendido no
% artigo analisado).
%--------------------------------------------------------------------------

% Os inputs introduzidos são os que se seguem: (o modelo, dentro dos seus
% limites, funciona para valores aleatórios introduzidos, mas nós testámos,
% para várias frequências, sempre os mesmo parâmetros de entrada, conforme
% vamos referindo)

f2=input('Frequência de estimulação dos nervos vagos, para o coração, f2= ');                               % utilizamos f2= 1.5, 4, 6, 7.5 e 10 Hz
Na=input('Número médio inicial de vesículas em cada terminação nervosa (N(0)), com acetilcolina= ');        % utilizamos N(0)=270
n=input('Número de fibras (n) correspondente ao estímulo= ');                                               % utilizamos n=8
C1=input('Concentração (constante) de acetilcolina nas vesículas, C1= ');                                   % utilizamos C1=1
C2a=input('Concentração inicial de acetilcolina, fora das vesículas, no nodo SA, C2(0)= ');                 % utilizamos C2(0)=1
V2=input('Volume aparente de diluição de C2 e A2= ');                                                       % utilizamos 0.01414 micrometros3
P0=input('Período inicial de ciclo cardíaco, P(0)= ');                                                      % utilizamos P(0)= 30 s
tmax=input('Duraçao da simulaçao, tmax= ');                                                                 % utilizamos tmax=180s
h=input('Valor do passo, h= ');                                                                             % utilizamos h=0.01s

C2(1)=C2a; P(1)=P0; N(1)=Na; Nm=450; HRv(1)= 60/(P0);                                                       % condições iniciais
k7=2.75; k8=0.69; k9=0.87; k10=0.01;                                                                        % constantes necessarias

a=1;                                                                                                        % contador


for i=h:h:(tmax/5)                                                                                          % 1º quinto do tempo, sem impulso de f2
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

for i=((tmax/5)+h):h:(2*(tmax/5))                                                                           % 2º quinto do tempo, com impulso de f2
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

for i=(2*(tmax/5)+h):h:tmax                                                                                 % 3º, 4º e 5º quintos do tempo, sem impulso de f2
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end


t=0:h:tmax; t1=0:h:(tmax/5); t2=((tmax/5)+h):h:(2*(tmax/5)); t3=(2*(tmax/5)+h):h:tmax;

freq2 = [zeros(size(t1)) f2*ones(size(t2)) zeros(size(t3))];


figure(1)
plot(t,HRv), axis([0 tmax 0 max(HRv)+0.5])
xlabel('Tempo (s)'), ylabel('Batimento Cardíaco, HRv (batim./s)')
title(' Efeito de f2 no Batimento Cardíaco (HRv), no 2º quinto do gráfico ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq2), axis([0 tmax 0 f2+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com o step de f2 ','Color','b','FontName','Arial','FontSize',11 )

figure(3), subplot(311)
plot(t,N)
xlabel('Tempo (s)'), ylabel('N vesículas')
title(' Número de vesículas ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(312)
plot(t,C2)
xlabel('Tempo (s)'), ylabel('Concentração C2')
title(' C2 ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(313)
plot(t,freq2), axis([0 tmax 0 f2+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com o step de f2 ','Color','b','FontName','Arial','FontSize',12 )

