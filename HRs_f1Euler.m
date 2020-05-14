clc
clear all

% MODELO PARA O EFEITO DOS NERVOS SIMPÁTICOS NO BATIMENTO CARDÍACO (HRs)

% Implementámos o método de Euler, nas eqs. diferenciais existentes.

% Desejamos observar o efeito de um único step input de frequência (aqui,
% testamos vários inputs de f1, mas separadamente - introduzidos pelo
% utilizador) nos nervos simpáticos (f1), sobre o HRs (que é o nosso
% principal output).

% Além da variação de HRs, também queremos relacionar a variação das
% concentrações A1 e A2 com o step input de f1 introduzido, verificando que
% se mantenha, sempre, a relação de concentrações B + AB = constante.

% Introduzimos o step de f1 entre intervalos de tempo com f1 = 0 Hz, de
% modo a destacar bem o seu efeito (de acordo com o pretendido no
% artigo analisado).
%--------------------------------------------------------------------------

% Os inputs introduzidos são os que se seguem: (o modelo, dentro dos seus
% limites, funciona para valores aleatórios introduzidos, mas nós testámos,
% para várias frequências, sempre os mesmo parâmetros de entrada, conforme
% vamos referindo)

f1=input('Frequência de estimulação dos nervos simpáticos, para o coração, f1= ');          % utilizamos f1= 2, 5, 10 e 20 Hz
A1a=input('Concentração inicial de neroepinefrina no final do nervo, A1(0)= ');             % utilizamos A1(0)=1
V1=input('Volume aparente de diluição de A1, V1= ');                                        % utilizamos V1= 0.04849 micrometros3
A0=input('Concentração de neroepinefrina no sangue, A0= ');                                 % utilizamos A0=1
A2a=input('Concentração inicial de neroepinefrina no nó SA, A2(0)= ');                      % utilizamos A2(0)=1
V2=input('Volume aparente de diluição de A2 e C2, V2= ');                                   % utilizamos V2= 0.01414 micrometros3
Ba=input('Concentração inicial da substância reagente no nó SA, B(0)= ');                   % utilizamos B(0)=1
ABa=input('Concentração inicial de A e B combinados, no nó SA, AB(0)= ');                   % utilizamos AB(0)=1
HRs0=input('Batimento cardíaco inicial, HRs(0)= ');                                         % utilizamos HRs(0)= 2 batim./s
tmax=input('Duraçao da simulaçao, tmax= ');                                                 % utilizamos tmax=180s
h=input('Valor do passo, h= ');                                                             % utilizamos h=0.01s

A1(1)=A1a; A2(1)=A2a; AB(1)=ABa; B(1)=Ba; HRs(1)=HRs0;                                      % condições iniciais
c= Ba + ABa;                                                                                % calcula constante entre B e AB
k1n=sqrt(0.356); k2=6.05; k3=0.25; k4=sqrt(0.356); k5=0.13; k6=0.75;                         % constantes necessárias

a=1;                                                                                        % contador


for i=h:h:(tmax/5)                                                                          % 1º quinto do tempo, sem impulso de f1
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

for i=((tmax/5)+h):h:(2*(tmax/5))                                                           % 2º quinto do tempo, com impulso de f1
    A1(a+1)= A1(a) + h*( (k1n*f1 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

for i=(2*(tmax/5)+h):h:tmax                                                                 % 3º, 4º e 5º quintos do tempo, sem impulso de f1
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
xlabel('Tempo (s)'), ylabel('Batimento Cardíaco, HRs (batim./s)')
title(' Efeito de f1 no Batimento Cardíaco (HRs), no 2º quinto do gráfico ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq1), axis([0 tmax 0 f1+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com o step de f1 ','Color','b','FontName','Arial','FontSize',11 )

figure(3), subplot(311)
plot(t,A1,t,A2), grid
xlabel('Tempo (s)'), ylabel('A1 e A2'), legend('A1','A2')
title(' A1 e A2 ao longo do tempo ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(312)
plot(t,freq1), axis([0 tmax 0 f1+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com o step de f1 ','Color','b','FontName','Arial','FontSize',12 )

figure(3), subplot(313)
plot(t,AB+B)
xlabel('Tempo (s)'), ylabel('AB + B')
title(' AB + B = constante ','Color','b','FontName','Arial','FontSize',12 )

