clc
clear all

% MODELO PARA A VARIAÇÃO DE HRs EM FUNÇÃO DE VÁRIOS STEPS DE F1

% Aqui, pretendemos simular o gráfico da fig.6 do artigo analisado,
% relacionando a variação do batimento cardíaco (HRs) ao longo do tempo,
% consoante vários steps de frequência diferente, nos nervos simpáticos
% (f1). Assim, temos, como parâmetro de entrada, o vector de frequências
% f1, e, como parâmetro de saída, o HRs ao longo do tempo.

% Implementámos o método de Euler, nas eqs. diferenciais existentes.
%--------------------------------------------------------------------------

f1=[5 2 20 10];                                                                         % f1 introduzidas no artigo, por ordem

% Os restantes parâmetros de entrada necessários são os mesmos das
% simulações individuais de cada f1:

A1(1)=1; A2(1)=1; A0=1; AB(1)=1; B(1)=1; HRs0=2; HRs(1)=HRs0; V1=0.04849; V2=0.01414;   % condições iniciais
c= B(1) + AB(1);                                                                        % calcula constante entre B e AB
k1n=sqrt(0.356); k2=6.05; k3=0.25; k4=sqrt(0.356); k5=0.13; k6=0.75;                    % constantes necessárias

a=1; h=0.01;                                                                            % contador e passo, para os ciclos

% O tempo, no eixo das abcissas do gráfico, varia entre t=0seg e t=280seg.

% No intervalo t=[0,10]seg, f1=0:
for i=h:h:10
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]10,40]seg, f1=5:
for i=(10+h):h:40
    A1(a+1)= A1(a) + h*( (k1n*f1(1) + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]40,80]seg, f1=0:
for i=(40+h):h:80
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]80,120]seg, f1=2:
for i=(80+h):h:120
    A1(a+1)= A1(a) + h*( (k1n*f1(2) + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]120,160]seg, f1=0:
for i=(120+h):h:160
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]160,185]seg, f1=20:
for i=(160+h):h:185
    A1(a+1)= A1(a) + h*( (k1n*f1(3) + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]185,225]seg, f1=0:
for i=(185+h):h:225
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]225,250]seg, f1=10:
for i=(225+h):h:250
    A1(a+1)= A1(a) + h*( (k1n*f1(4) + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

% No intervalo t=]250,280]seg, f1=0:
for i=(250+h):h:280
    A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
    A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
    AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
    B(a+1)= c - AB(a+1);
    HRs(a+1)= HRs0 + k6*AB(a+1);
    
    a= a+1;
end

t=0:h:280;
t1=0:h:10; t2=(10+h):h:40; t3=(40+h):h:80; t4=(80+h):h:120; t5=(120+h):h:160;
t6=(160+h):h:185; t7=(185+h):h:225; t8=(225+h):h:250; t9=(250+h):h:280;

freq1 = [zeros(size(t1)) f1(1)*ones(size(t2)) zeros(size(t3)) f1(2)*ones(size(t4)) zeros(size(t5)) f1(3)*ones(size(t6)) zeros(size(t7)) f1(4)*ones(size(t8)) zeros(size(t9))];


figure(1)
plot(t,HRs), grid, axis([0 280 0 3.5])
xlabel('Tempo (s)'), ylabel('Batimento Cardíaco, HRs (batim./s)')
title(' Efeito de diferentes f1 no Batimento Cardíaco (HRs) ','Color','b','FontName','Arial','FontSize',14 )

figure(2)
plot(t,freq1), axis([0 280 0 f1(3)+0.5])
xlabel('Tempo (s)'), ylabel('Step input de frequência (Hz)')
title(' Frequência ao longo do tempo, com os vários steps de f1 ','Color','b','FontName','Arial','FontSize',11 )

