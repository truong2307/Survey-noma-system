clc
lamda = 1;
B = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
%--------
P1 = P0.*anpha;
P2 = P0.*(1-anpha);
%-----------------------ly thuyet---------------------
for i =1 : length(P0dB)
%-------hang so ngoai dau tich phan------------
    a(i) = P1(i)/(log(2)*lamda);
    %---hang so tich phan 1 va 2 ---
    HS1(i) = (-exp(lamda/P2(i)))/P1(i);
    HS2(i) = (exp(lamda/(P1(i)+P2(i))))/P1(i);
%-------------tich phan 1 va 2------------------
    x1(i) =lamda/P2(i);
    x2(i) =lamda/(P2(i)+P1(i));
    TP1(i) = expint(x1(i));
    TP2(i) = expint(x2(i));
%---result
    C_LT(i) = a(i)*((HS1(i)*TP1(i))+(HS2(i)*TP2(i)));
end
%--------------------Mo phong-------------------------
N = 10^5;
g= gamrnd(1,1,1,N);
SNR = zeros(N,length(P0dB));
for i = 1:N
    for j = 1:length(P0dB)
        SNR(i,j) = (P1(j)*g(i))/((P2(j)*g(i))+1);
    end
end
%--
C_MP = sum(B.*log2(1+SNR))/N;
 plot( P0dB,C_MP, P0dB, C_LT, 'o' );
    
