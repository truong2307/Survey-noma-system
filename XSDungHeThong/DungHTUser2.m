%xac suat dung user2
clc
Yo = 1;
lamda = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
P2 = P0.*(1-anpha);
%ly thuyet 
F_LT = 1- exp(-(lamda*Yo)./(P2(:)));
%Mo phong
n =10^5;
g = gamrnd(1,1,1,n);
SNR = zeros(n,length(P0dB));
for i = 1:n
    for j = 1:length(P0dB)
        SNR(i,j) = P2(j)*g(i);
    end
end
F_MP =sum(SNR<Yo)/n;
%-------------------------
plot(P0dB,F_LT,P0dB,F_MP,'o');
legend('Ly thuyet','Mo phong');