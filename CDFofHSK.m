clc
lamda = 2;
n = 10^4;
Po = 1:30;
%tao he so kenh truyen
h =sqrt(lamda/2).*(randn(1,n)+1i*randn(1,n));
%mo phong
CDF_MP = zeros(size(Po));
for ipo = 1:length(Po)
    CDF_MP(ipo) = sum(h<Po(ipo))/n;
end
%ly thuyet
CDF_LT = 1-exp(-(lamda*Po));
disp(CDF_LT)
 plot(Po,CDF_LT,Po,CDF_MP);