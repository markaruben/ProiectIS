k = [1 2 3 4 5 6 7 8 9 10];
y = [4; 9; 10; 20; 29; 39; 54; 70; 91; 110];
for i=1:length(k)
    X(i,1) = 1;
    X(i,2) = k(i);
    X(i,3) = k(i)*k(i);
end

teta = X\y
yhat = [0; 0 ; 0; 0; 0 ;0 ;0 ;0 ;0 ;0 ];
for i=1:length(k)
    yhat(i) = X(i,1)*teta(1)+X(i,2)*teta(2)+X(i,3)*teta(3);
end

E = y-yhat

sum = 0;

for i = 1:length(E)
    sum = sum + E(i)^2;
end

MSE  = sum/length(E)




