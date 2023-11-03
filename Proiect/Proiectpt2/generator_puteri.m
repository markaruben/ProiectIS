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
    if(suma>m)
        vector(k,:) = [];
        k=k-1;
        lung=lung-1;
    end
    k=k+1;
end

vector = unique(vector,'rows','stable');

x=vector;
end