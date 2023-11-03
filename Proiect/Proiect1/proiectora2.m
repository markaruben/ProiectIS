clear all
load("product_12.mat");
plot(time,y,"g");hold on
yid = zeros(floor(0.8*length(y)),1);
for i = 1:floor(0.8*length(y))
    yid(i) = y(i);
end

yval = zeros(length(y)-floor(0.8*length(y)),1);
r=1;
for i =floor(0.8*length(y)):length(y)
    yval(r)=y(i);
    r=r+1;
end

for i = 1:floor(0.8*length(time))
    kid(i) = time(i);
end
a=1;
for i =floor(0.8*length(time)):length(time)
    kval(a) = time(i);
a = a+1;
end


for i = 1:length(kid)
phi(i,1:6) = [1 kid(i) cos(pi*kid(i)/6) sin(pi*kid(i)/6) cos(pi*kid(i)/3) sin(pi*kid(i)/3)];
end


for i = 1:length(kval)
phi1(i,1:6) = [1 kval(i) cos(pi*kval(i)/6) sin(pi*kval(i)/6) cos(pi*kval(i)/3) sin(pi*kval(i)/3)];
end


teta = phi \ yid

yhatval = phi1*teta;
yhatid = phi*teta;
plot(kid,yhatid,"r");
hold on
plot(kval,yhatval,"b");

