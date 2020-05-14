clc
clear all

% MODELO PARA O EFEITO DOS NERVOS VAGOS NO BATIMENTO CARD�ACO (HRv)

% Implement�mos o m�todo de Euler, nas eqs. diferenciais existentes.

% Desejamos observar o efeito de um �nico step input de frequ�ncia (aqui,
% testamos v�rios inputs de f2, mas separadamente - introduzidos pelo
% utilizador) nos nervos vagos (f2), sobre o HRv (que � o nosso
% principal output).

% Al�m da varia��o de HRv, tamb�m queremos relacionar a varia��o do n�mero
% de ves�culas de acetilcolina (N) e da concentra��o C2 com o step input de
% f2 introduzido.

% Introduzimos o step de f2 entre intervalos de tempo com f2 = 0 Hz, de
% modo a destacar bem o seu efeito (de acordo com o pretendido no
% artigo analisado).
%--------------------------------------------------------------------------

% Os inputs introduzidos s�o os que se seguem: (o modelo, dentro dos seus
% limites, funciona para valores aleat�rios introduzidos, mas n�s test�mos,
% para v�rias frequ�ncias, sempre os mesmo par�metros de entrada, conforme
% vamos referindo)

f2=input('Frequ�ncia de estimula��o dos nervos vagos, para o cora��o, f2= ');                               % utilizamos f2= 1.5, 4, 6, 7.5 e 10 Hz
Na=input('N�mero m�dio inicial de ves�culas em cada termina��o nervosa (N(0)), com acetilcolina= ');        % utilizamos N(0)=270
n=input('N�mero de fibras (n) correspondente ao est�mulo= ');                                               % utilizamos n=8
C1=input('Concentra��o (constante) de acetilcolina nas ves�culas, C1= ');                                   % utilizamos C1=1
C2a=input('Concentra��o inicial de acetilcolina, fora das ves�culas, no nodo SA, C2(0)= ');                 % utilizamos C2(0)=1
V2=input('Volume aparente de dilui��o de C2 e A2= ');                                                       % utilizamos 0.01414 micrometros3
P0=input('Per�odo inicial de ciclo card�aco, P(0)= ');                                                      % utilizamos P(0)= 30 s
tmax=input('Dura�ao da simula�ao, tmax= ');                                                                 % utilizamos tmax=180s
h=input('Valor do passo, h= ');                                                                             % utilizamos h=0.01s

C2(1)=C2a; P(1)=P0; N(1)=Na; Nm=450; HRv(1)= 60/(P0);                                                       % condi��es iniciais
k7=2.75; k8=0.69; k9=0.87; k10=0.01;                                                                        % constantes necessarias

a=1;                                                                                                        % contador


for i=h:h:(tmax/5)                                                                                          % 1� quinto do tempo, sem impulso de f2
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

for i=((tmax/5)+h):h:(2*(tmax/5))                                                                           % 2� quinto do tempo, com impulso de f2
    N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2 );
    C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2 - k9*C2(a))/V2 );
    P(a+1)= P0 + k10*C2(a+1);
    HRv(a+1)= 60/(P(a+1));
    
    a= a+1;
end

for i=(2*(tmax/5)+h):h:tmax                                                                                 % 3�, 4� e 5� quintos do tempo, sem impulso de f2
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
xlabel('Tempo (s)'), ylabel('Batimento Card�aco, HRv (batim./s)')
title(' Efeito de f2 no Batimento Card�aco (HRv), no 2� quinto do gr�fico ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq2), axis([0 tmax 0 f2+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequ�ncia (Hz)')
title(' Frequ�ncia ao longo do tempo, com o step de f2 ','Color','b','FontName','Arial','FontSize',11 )

figure(3), subplot(311)
plot(t,N)
xlabel('Tempo (s)'), ylabel('N ves�culas')
title(' N�mero de ves�culas ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(312)
plot(t,C2)
xlabel('Tempo (s)'), ylabel('Concentra��o C2')
title(' C2 ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(313)
plot(t,freq2), axis([0 tmax 0 f2+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequ�ncia (Hz)')
title(' Frequ�ncia ao longo do tempo, com o step de f2 ','Color','b','FontName','Arial','FontSize',12 )

