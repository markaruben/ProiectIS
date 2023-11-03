clear all; close all; clc;

load('iddata-20.mat');

u_id = id.u;
y_id = id.y;

u_val = val.u;
y_val = val.y;

subplot(2,1,1);
plot(u_id);title("Date de intrare pentru identificare.");
subplot(2,1,2);
plot(y_id); title("Date de iesire pentru identificare.");

na = 2;
nb = 2;
m = 1;

puteri = generator_puteri(m,na,nb);

x_id = zeros(1,length(u_id));
for k = 1:length(u_id)
    for i = 1:na
        if(k<=i)
            x_id(k,i) = 0;
        else
            x_id(k,i) = y_id(k-i);
        end
    end
    for i = 1:nb
        if(k<=i)
             x_id(k,na+i) = 0;
        else
            x_id(k,na+i) = u_id(k-i);
        end
    end
end


mono1 = [];
for i=1:length(u_id)
    arr = [];
    for k=1:length(puteri)
        a=1;
        for j=1:na+nb
            a=a*x_id(i,j)^puteri(k,j);
        end
        arr=[arr,a];
    end
    mono1=[mono1;arr];
end

teta = mono1\y_id;
yhat_predid = mono1*teta;
epred_id = (yhat_predid-y_id).^2;
suma = 0;
for i = 1:length(epred_id)
    suma = suma + epred_id(i);
end
MSEid_pred = (1/length(epred_id))*suma


y_idsim(1:na)=y_id(1:na);
for k=1:length(u_id)
    arr=[];
    for i=1:na
        if(k<=i)
            x_id(k,i)=0;
           
        else
            x_id(k,i)=y_idsim(k-i);
        end
    end
    for i=1:nb
        if(k<=i)
            x_id(k,na+i)=0;
        else
             x_id(k,na+i)=u_id(k-i);
        end
    end
    for r=1:length(puteri)
        a=1;
        for j=1:na+nb
            a=a*x_id(k,j)^puteri(r,j);
        end
        arr=[arr,a];
    end
   y_idsim(k)=arr*teta;
end

epred_idsim = (y_idsim'-y_id).^2;
suma = 0;
for i = 1:length(epred_idsim)
    suma = suma + epred_idsim(i);
end
MSEid_sim = (1/length(epred_idsim))*suma

figure
plot([y_id,yhat_predid,y_idsim']);legend('y id','yhat predid', 'y idsim'); title("Iesirile de identificare suprapuse.");


x_val =  zeros(1,length(u_val));
for k=1:length(u_val)
    for i=1:na
        if(k<=i)
            x_val(k,i)=0;
        else
           x_val(k,i)=y_val(k-i);
        end
    end
    for i=1:nb
        if(k<=i)
            x_val(k,na+i)=0;
        else
            x_val(k,na+i)=u_val(k-i);
        end
    end
end


mono2 = [];
for i=1:length(u_val)
    arr=[];
    for k=1:length(puteri)
        a=1;
        for j=1:na+nb
            a=a*x_val(i,j)^puteri(k,j);
        end
        arr=[arr,a];
    end
    mono2 = [mono2;arr];
end

yhat_predval = mono2*teta;

epred_val = (yhat_predval-y_val).^2;
suma = 0;
for i = 1:length(epred_val)
    suma = suma + epred_val(i);
end
MSEval_pred = (1/length(epred_val))*suma

y_valsim(1:na)=y_val(1:na);
for k=1:length(y_val)
    arr=[];
    for i=1:na
        if(k<=i)
            x_val(k,i)=0;
        else
            x_val(k,i)=y_valsim(k-i);
        end
    end

    for i=1:nb
        if(k<=i)
            x_val(k,na+i)=0;
        else
            x_val(k,na+i)=u_val(k-i);
        end
    end

    for r=1:length(puteri)
        a=1;
        for j=1:na+nb
            a=a*x_val(k,j)^puteri(r,j);
        end
        arr=[arr,a];
    end
    y_valsim(k)=arr*teta;
end


epred_valsim = (y_valsim'-y_val).^2;
suma = 0;
for i = 1:length(epred_valsim)
    suma = suma + epred_valsim(i);
end
MSEval_sim = (1/length(epred_valsim))*suma

figure
plot(y_val);
hold on
plot(yhat_predval);
hold on
plot(y_valsim);
legend('y val', 'yhat predval ', 'yval sim');title("Iesirile de validare suprapuse.")


function x = generator_puteri(m,na,nb)

n = na+nb;

for i = 1:(m+1)
    vector(i) = i-1;
end

vector = repmat(vector,1,n);
vector = combntns(vector,n);
lung = length(vector);

k=1 ; 

while(k<=lung)
    suma = sum(vector(k,:));
    if(suma>m || suma == 0)
        vector(k,:) = [];
        k=k-1;
        lung=lung-1;
    end
    k=k+1;
end

vector = unique(vector,'rows','stable');

x=vector;
end