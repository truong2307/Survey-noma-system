%xac suat dung user1
clc
Yo = 1;
lamda = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
%---
P1 = P0.*anpha;
P2 = P0.*(1-anpha);
%Li thuyet-------------------------------------
F_LT = 1-exp(-(Yo*lamda)./(P1(:)-(P2(:)*Yo)));
    %Mo phong-------------------------------------
    N = 10^5;
    %tao he so kenh truyen
    g = gamrnd(1,1,1,N);
SNR = zeros(N,length(P0dB));
for i = 1:N
    for j = 1:length(P0dB)
        SNR(i,j) = (P1(j)*g(i))/((P2(j)*g(i))+1);
    end
end
F_MP = sum(SNR<Yo)/N;
%----------------------------------------------
 plot( P0dB,F_LT,P0dB,F_MP,'o' );
 legend('Ly thuyet','Mo phong');