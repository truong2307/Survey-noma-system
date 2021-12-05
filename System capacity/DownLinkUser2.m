clc
lamda = 1;
B = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
%--------
P1 = P0.*anpha;
P2 = P0.*(1-anpha);
%--------------------ly thuyet-----------------------
for i= 1:length(P0dB)
%-------------hang so truoc dau tich phan-----------
    HS(i) = (exp(lamda/P2(i)))/(lamda*log(2));
%-------------tich phan--------------------
    TP(i) = expint((lamda/P2(i)));
%----result
    C_LT(i) = HS(i)*TP(i);
end
%--------------------Mo phong-------------------------
N = 10^5;
g= gamrnd(1,1,1,N);
SNR = zeros(N,length(P0dB));
for i = 1:length(P0dB)    
    for j = 1:N
        SNR(j,i) = P2(i)*g(j);
    end
end
%--
C_MP = sum(B.*log2(1+SNR))/N;
 plot( P0dB,C_MP,P0dB,C_LT,'o');
