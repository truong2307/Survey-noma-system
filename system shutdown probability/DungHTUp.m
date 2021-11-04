%xac suat dung user1 (Uplink)
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
% F_LT = 1-(((lamda*P1(:)).*(exp(-(Yo*lamda)./(P1(:)))))/((Yo*lamda*P2(:))+(lamda*P1(:))));
F_LT =zeros(length(P0dB));
for j = 1:length(P0dB)
    a(j) = exp(-(Yo*lamda)/(P1(j)));
    b(j) = (lamda*P1(j))/((Yo*lamda*P2(j))+(lamda*P1(j)));
    F_LT(j) = 1-(a(j)*b(j));
end
%Mo phong-------------------------------------
N = 10^5;
%tao he so kenh truyen
SNR = zeros(N,length(P0dB));
 for j = 1:length(P0dB)
    g1= gamrnd(1,1,1,N);
    g2= gamrnd(1,1,1,N);
    for i = 1:N
      SNR(i,j) = (P1(j)*g1(i))/(1+(P2(j)*g2(i)));
    end   
 end
 F_MP =zeros(length(P0dB));
 for i = 1:length(P0dB)
     for j =1:N
         F_MP(i) = F_MP(i)+ sum(SNR(j,i)<Yo)/N;
     end 
 end
% %-----
%  disp(SNR(1,2));
 plot( P0dB,F_LT,P0dB,F_MP,'o' );
%  legend('Ly Thuyet','Mo phong');