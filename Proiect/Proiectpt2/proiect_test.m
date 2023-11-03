clear all;close all;clc;

load('iddata-20.mat');

u_id = id.u;
y_id = id.y;

u_val = val.u;
y_val = val.y;

subplot(2,1,1);
plot(u_id);title("Date de intrare pentru identificare.");
subplot(2,1,2);
plot(y_id); title("Date de iesire pentru identificare.");

figure;
subplot(2,1,1);
plot(u_val);title("Date de intrare pentru validare.");
subplot(2,1,2);
plot(y_val); title("Date de iesire pentru validare.");

na = 1;
nb = 1;
nk = 1;

m = 2;

for k = 1:length(u_id)
    for i = 1:na
        if(k>i)
            x_id(k,i) = -y_id(k-i);
        else
            x_id(k,i) = 0;
        end
    end
    for i = 1:nb
        if(k>i)
            x_id(k,na+i) = u_id(k-i);
        else
            x_id(k,na+i) = 0;
        end
    end
end

 
for k=1:(m+1)*(na+nb)
    vector(k)=mod(k-1,m+1);
end

numbers = [1 2];
target_sum = 2;
puteri = []; % Matricea în care se salvează combinațiile

for i = 0:m
  for j =0:m
    if (i + j<= target_sum && i<=j)
      puteri = [puteri; i j]; % Salvare combinație
    end
  end
end
N=length(puteri)
i=1;
while(i<=N)
    sum=0;
    for j=1:na+nb
        sum=sum+puteri(i,j);
    end
    if(sum>m)
            puteri(i,:)=[];
            i=i-1;
            N=N-1;
    end
    i=i+1;
end
T1 = [];
for i=1:length(u_id)
    aux=[];
    for k=1:N
        a=1;
        for j=1:na+nb
            a=a*x_id(i,j)^puteri(k,j); 
        end
        aux=[aux,a];
    end
    T1=[T1;aux];
end

teta = T1\y_id;
yhat_predid = T1*teta;
figure
plot([yhat_predid,y_id]);legend('yhat predid','y id');

epred_id = (yhat_predid-y_id).^2;
suma = 0;
for i = 1:length(epred_id)
    suma = suma + epred_id(i);
end
MSEid_pred = (1/length(epred_id))*suma

for k=1:length(u_val)
    for i=1:na
       if(k>i)
        x_val(k,i)=-y_val(k-i);
       else
         x_val(k,i)=0;
       end
    end
    for i=1:nb
        if(k>i)
           x_val(k,na+i)=u_val(k-i);
        else
            x_val(k,na+i)=0;
        end
    end
end

T2 = [];
for i=1:length(u_val)
    aux=[];
    for k=1:N
        a=1;
        for j=1:na+nb
            a=a*x_val(i,j)^puteri(k,j); 
        end
        aux=[aux,a];
    end
    T2 = [T2;aux];
end

yhat_predval = T2*teta;
figure
plot([yhat_predval,y_val]);legend('yhat predval','y val');
epred_val = (yhat_predval-y_val).^2;
suma = 0;
for i = 1:length(epred_val)
    suma = suma + epred_val(i);
end
MSEval_pred = (1/length(epred_val))*suma

y_idsim = [];
for k=1:length(u_id)
    aux=[];
    for i=1:na
       if(k>i)
        x_idsim(k,i)=-y_idsim(k-i);
       else
         x_idsim(k,i)=0;
       end
    end
    for i=1:nb
        if(k>i)
           x_id(k,na+i)=u_id(k-i);
        else
            x_id(k,na+i)=0;
        end
    end
    for r=1:N
        a=1;
        for j=1:na+nb
            a=a*x_id(k,j)^puteri(r,j); 
        end
        aux=[aux,a];
    end
    y_idsim=[y_idsim;aux*teta];
end
figure
plot([y_idsim,y_id]);
legend('y idsim','y id');
epred_idsim = (y_idsim-y_id).^2;
suma = 0;
for i = 1:length(epred_idsim)
    suma = suma + epred_idsim(i);
end
MSEval_idsim = (1/length(epred_idsim))*suma

y_valsim=[];
for k=1:length(u_val)
    aux=[];
    for i=1:na
       if(k>i)
        x_valsim(k,i)=-y_valsim(k-i);
       else
         x_valsim(k,i)=0;
       end
    end
    for i=1:nb
        if(k>i)
           x_val(k,na+i)=u_val(k-i);
        else
            x_val(k,na+i)=0;
        end
    end
    for r=1:N
        a=1;
        for j=1:na+nb
            a=a*x_val(k,j)^puteri(r,j); 
        end
        aux=[aux,a];
    end
    y_valsim=[y_valsim;aux*teta];
end
figure
plot(y_valsim);
hold on;
plot(y_val);
legend('y valsim','y val')

epred_valsim = (y_valsim-y_val).^2;
suma = 0;
for i = 1:length(epred_valsim)
    suma = suma + epred_valsim(i);
end
MSEval_valsim = (1/length(epred_valsim))*suma


figure
plot([y_id,yhat_predid,y_idsim]);
legend('y id','yhat predid','y idsim');

figure
plot(y_val);
hold on
plot(yhat_predval);
hold on
plot(y_valsim');
legend('y val','yhat predval','y valsim');



 


