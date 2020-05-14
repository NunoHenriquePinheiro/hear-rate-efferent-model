clc
clear all

% MODELO PARA O EFEITO DOS NERVOS SIMP�TICOS NO BATIMENTO CARD�ACO (HRs)

% Implement�mos o m�todo de Euler, nas eqs. diferenciais existentes.

% Desejamos observar o efeito de um �nico step input de frequ�ncia (aqui,
% testamos v�rios inputs de f1, mas separadamente - introduzidos pelo
% utilizador) nos nervos simp�ticos (f1), sobre o HRs (que � o nosso
% principal output).

% Al�m da varia��o de HRs, tamb�m queremos relacionar a varia��o das
% concentra��es A1 e A2 com o step input de f1 introduzido, verificando que
% se mantenha, sempre, a rela��o de concentra��es B + AB = constante.

% Introduzimos o step de f1 entre intervalos de tempo com f1 = 0 Hz, de
% modo a destacar bem o seu efeito (de acordo com o pretendido no
% artigo analisado).
%--------------------------------------------------------------------------

% Os inputs introduzidos s�o os que se seguem: (o modelo, dentro dos seus
% limites, funciona para valores aleat�rios introduzidos, mas n�s test�mos,
% para v�rias frequ�ncias, sempre os mesmo par�metros de entrada, conforme
% vamos referindo)

f1=input('Frequ�ncia de estimula��o dos nervos simp�ticos, para o cora��o, f1= ');          % utilizamos f1= 2, 5, 10 e 20 Hz
A1a=input('Concentra��o inicial de neroepinefrina no final do nervo, A1(0)= ');             % utilizamos A1(0)=1
V1=input('Volume aparente de dilui��o de A1, V1= ');                                        % utilizamos V1= 0.04849 micrometros3
A0=input('Concentra��o de neroepinefrina no sangue, A0= ');                                 % utilizamos A0=1
A2a=input('Concentra��o inicial de neroepinefrina no n� SA, A2(0)= ');                      % utilizamos A2(0)=1
V2=input('Volume aparente de dilui��o de A2 e C2, V2= ');                                   % utilizamos V2= 0.01414 micrometros3
Ba=input('Concentra��o inicial da subst�ncia reagente no n� SA, B(0)= ');                   % utilizamos B(0)=1
ABa=input('Concentra��o inicial de A e B combinados, no n� SA, AB(0)= ');                   % utilizamos AB(0)=1
HRs0=input('Batimento card�aco inicial, HRs(0)= ');                                         % utilizamos HRs(0)= 2 batim./s
tmax=input('Dura�ao da simula�ao, tmax= ');                                                 % utilizamos tmax=180s
h=input('Valor do passo, h= ');                                                             % utilizamos h=0.01s

A1(1)=A1a; A2(1)=A2a; AB(1)=ABa; B(1)=Ba; HRs(1)=HRs0;                                      % condi��es iniciais
c= Ba + ABa;                                                                                % calcula constante entre B e AB
k1n=sqrt(0.356); k2=6.05; k3=0.25; k4=sqrt(0.356); k5=0.13; k6=0.75;                         % constantes necess�rias

a=1;                                                                                        % contador


for i=h:h:(tmax/5)                                                                          % 1� quinto do tempo, sem impulso de f1
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

for i=((tmax/5)+h):h:(2*(tmax/5))                                                           % 2� quinto do tempo, com impulso de f1
    A1(a+1)= A1(a) + h*( (k1n*f1 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

for i=(2*(tmax/5)+h):h:tmax                                                                 % 3�, 4� e 5� quintos do tempo, sem impulso de f1
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end


t=0:h:tmax; t1=0:h:(tmax/5); t2=((tmax/5)+h):h:(2*(tmax/5)); t3=(2*(tmax/5)+h):h:tmax;

freq1 = [zeros(size(t1)) f1*ones(size(t2)) zeros(size(t3))];


figure(1)
plot(t,HRs), grid
xlabel('Tempo (s)'), ylabel('Batimento Card�aco, HRs (batim./s)')
title(' Efeito de f1 no Batimento Card�aco (HRs), no 2� quinto do gr�fico ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq1), axis([0 tmax 0 f1+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequ�ncia (Hz)')
title(' Frequ�ncia ao longo do tempo, com o step de f1 ','Color','b','FontName','Arial','FontSize',11 )

figure(3), subplot(311)
plot(t,A1,t,A2), grid
xlabel('Tempo (s)'), ylabel('A1 e A2'), legend('A1','A2')
title(' A1 e A2 ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(312)
plot(t,freq1), axis([0 tmax 0 f1+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequ�ncia (Hz)')
title(' Frequ�ncia ao longo do tempo, com o step de f1 ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(313)
plot(t,AB+B)
xlabel('Tempo (s)'), ylabel('AB + B')
title(' AB + B = constante ','Color','b','FontName','Arial','FontSize',12 )

