clc
Yo = 1;
lamda = 1;
anpha = 0.75;
P0dB = 0:1:30;
P0 = 10.^(P0dB./10);
B=1;
%---
P1 = P0.*anpha;
P2 = P0.*(1-anpha);
%----------ly thuyet---------------------
for i =1 : length(P0dB)
    a(i) = (lamda*P1(i)*(exp(lamda/P2(i))))/(log(2)*lamda*P2(i));
    %-----I1------------------------------------------------------
    lnn(i) =log(((P1(i)*lamda)/(lamda*P2(i)))-2);
    I1(i) = ((lamda*P2(i))/((P1(i)*lamda)-(lamda*P2(i))))*lnn(i);
    %-----I2------------------------------------------------------
    b(i) = (lamda*P2(i))/((P1(i)*lamda)-(lamda*P2(i)));
    e(i) = (exp(((lamda*P2(i))-(P1(i)*lamda))/(P1(i)*P2(i))))*(expint(lamda/P1(i)));
    ln(i) = log(2-((P1(i)*lamda)/(lamda*P2(i))));
    E(i) = expint(((2*lamda*P2(i))-(lamda*P1(i)))/(P1(i)*P2(i)));
    I2(i) = b(i)*(e(i)+ln(i)-E(i));
    %-----------------------------------------
    C_LT(i) = a(i)*(-I1(i)-I2(i));     
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
C_MP =zeros(length(P0dB));
 for i = 1:length(P0dB)
     for j =1:N
         C_MP(i) = C_MP(i)+ sum(B.*log2(1+SNR(j,i)))/N;
     end 
 end
 
 plot( P0dB,C_MP, P0dB, C_LT, 'o' )