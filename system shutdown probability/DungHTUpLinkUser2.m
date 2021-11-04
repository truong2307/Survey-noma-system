clc
Yo = 1;
lamda = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
%---
P1 = P0.*anpha;
P2 = P0.*(1-anpha);
%Ly thuyet------------------------
F_LT = 1-exp(-(lamda*Yo)./(P2(:)));
%Mo phong
N = 10^5;
SNR = zeros(N,length(P0dB));
for i = 1:length(P0dB)
    g= gamrnd(1,1,1,N);
    for j = 1:N
        SNR(j) = P2(i)*g(j);
    end
end
F_MP = zeros(length(P0dB));
for i = 1:length(P0dB)
    for j =1:N
        F_MP(i) = F_MP(i) + sum(SNR(j,i)<Yo)/N;
    end
    
end
plot( P0dB,F_LT,P0dB,F_LT,'o' );
