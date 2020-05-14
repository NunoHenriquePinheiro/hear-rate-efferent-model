clc
clear all

% MODELO PARA A VARIA��O DE HRsv EM FUN��O DE V�RIOS STEPS DE F1 E F2

% Aqui, pretendemos simular a varia��o do batimento card�aco (HRsv) ao
% longo do tempo, consoante v�rios steps de frequ�ncias diferentes, nos
% nervos simp�ticos (f1) e nos nervos vagos (f2). Assim, pretendemos
% avaliar a maior ou menor influ�ncia de f1 e f2 sobre HRsv, observando
% qual dos est�mulos predomina (isto � sugerido, no artigo,
% qualitativamente, mas n�o � quantificado).
% Temos, ent�o, como par�metros de entrada, os vectores de frequ�ncias
% f1 e f2, e, como par�metro de sa�da, o HRsv ao longo do tempo.

% Implement�mos o m�todo de Euler, nas eqs. diferenciais existentes.
%--------------------------------------------------------------------------

f1=[5 2 20 10]; f2=[7.5 4 1.5 6 10];                                                    % f1 e f2 utilizados no artigo


for j=1:1:length(f2)
    for w=1:1:length(f1)
        % Os restantes par�metros de entrada necess�rios s�o os mesmos das
        % simula��es individuais de cada f1 e f2:

        % f1
        A1(1)=1; A2(1)=1; A0=1; AB(1)=1; B(1)=1; HRs0=2; HRs(1)=HRs0; V1=0.04849; V2=0.01414;   % condi��es iniciais
        c= B(1) + AB(1);                                                                        % calcula constante entre B e AB
        k1n=sqrt(0.356); k2=6.05; k3=0.25; k4=sqrt(0.356); k5=0.13; k6=0.75;                    % constantes necess�rias

        % f2
        C1=1; C2(1)=1; P0=30; P(1)=P0; N(1)=270; Nm=450; HRv(1)= 60/(P0); V2=0.01414; n=8;      % condi��es iniciais
        k7=2.75; k8=0.69; k9=0.87; k10=0.01;                                                    % constantes necessarias

        a=1; h=0.01; tmax=180;                                                                  % contador, passo e tmax, para os ciclos
    
        HRsv(1)=2; HRmin=0.5;     % HRsv(0)=2 e HRmin=0.5 (batim./s)
    
        for i=h:h:(tmax/5)                                                                          % 1� quinto do tempo, sem impulso de f1 e f2
            A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
            A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
            AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
            B(a+1)= c - AB(a+1);
            HRs(a+1)= HRs0 + k6*AB(a+1);
            
            N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
            C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
            P(a+1)= P0 + k10*C2(a+1);
            HRv(a+1)= 60/(P(a+1));
            
            HRsv(a+1)= HRv(a+1) + (HRs(a+1)-HRsv(1)) * (HRv(a+1)-HRmin) / (HRsv(1)-HRmin);
            a= a+1;
        end
    
        for i=((tmax/5)+h):h:(2*(tmax/5))                                                           % 2� quinto do tempo, com impulso de f1 e f2
            A1(a+1)= A1(a) + h*( (k1n*f1(w) + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
            A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
            AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
            B(a+1)= c - AB(a+1);
            HRs(a+1)= HRs0 + k6*AB(a+1);
            
            N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*f2(j) );
            C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*f2(j) - k9*C2(a))/V2 );
            P(a+1)= P0 + k10*C2(a+1);
            HRv(a+1)= 60/(P(a+1));
            
            HRsv(a+1)= HRv(a+1) + (HRs(a+1)-HRsv(1)) * (HRv(a+1)-HRmin) / (HRsv(1)-HRmin);        
            a= a+1;
        end

        for i=(2*(tmax/5)+h):h:tmax                                                                 % 3�, 4� e 5� quintos do tempo, sem impulso de f1 e f2
            A1(a+1)= A1(a) + h*( (k1n*0 + k2*(A0-A1(a)) + k3*(A2(a)-A1(a)))/V1 );
            A2(a+1)= A2(a) + h*( (k3*(A1(a)-A2(a)) - k4*A2(a)*B(a) + k5*AB(a))/V2 );
            AB(a+1)= AB(a) + h*( k4*A2(a)*B(a) - k5*AB(a) );
            B(a+1)= c - AB(a+1);
            HRs(a+1)= HRs0 + k6*AB(a+1);    
                
            N(a+1)= N(a) + h*( k7*(Nm-N(a)) - k8*N(a)*0 );
            C2(a+1)= C2(a) + h*( (n*k8*N(a)*C1*0 - k9*C2(a))/V2 );
            P(a+1)= P0 + k10*C2(a+1);
            HRv(a+1)= 60/(P(a+1));
            
            HRsv(a+1)= HRv(a+1) + (HRs(a+1)-HRsv(1)) * (HRv(a+1)-HRmin) / (HRsv(1)-HRmin);
            a= a+1;
        end
        
        t=0:h:tmax;
        
        str = sprintf('Efeito de f1 = %.1f e f2 = %.1f (em Hz) no Batimento Card�aco (HRsv), no 2� quinto do gr�fico',f1(w),f2(j));
        
        figure, plot(t,HRsv), axis([0 tmax 0 max(HRsv)+0.5])
        xlabel('Tempo (s)'), ylabel('Batimento Card�aco, HRsv (batim./s)')
        title(str,'Color','b','FontName','Arial','FontSize',14 )
    end
end

    

