function [v]= Randompatients(ptstype,test, contrast,arrivalrate)
n_parameters=12;
a=52;
n_wd=5;
n_ts=21;
n_types=61;
   

patients=zeros(1,n_parameters);
   
for I_yd=1:a
for I_wd=1:n_wd
    for I_ts=1:n_ts
        lambda=arrivalrate(I_ts,I_wd);
        r=poissrnd(lambda,1);
        if r~=0
            for i=1:r
                a=[I_ts I_wd I_yd 0 0 0 0 0 0 0 0 0];
                patients=[patients;a];
            end
        end
    end
end
end


for i=2:length(patients)
     
   
    r=rand;
    prob=ptstype(:,2)';
    value=ptstype(:,1)';    %values corresponding to the probabilities
    ind=find(r<=prob,1,'first');
    patients(i,4)=value(ind);
end
for i=2:length(patients)
   
    
    for t=1:n_types
        if patients(i,4)==t
           patients(i,5)=ptstype(t,3);
        end
    end
end
%test
for i=1:length(patients)
     
    
    for t=1:length(test)
        if patients(i,4)==test(t,1)
            p=test(t,2);
            n=2;
            u=rand(n,1);
            x=sum(u<p);
            if x==1
                patients(i,5)=NaN;
            end
        end
    end
end

for i=1:length(patients)
    
    for n_type=1:length(contrast)
        if patients(i,4)==contrast(n_type,1)
            p=contrast(n_type,2);
            n=2;
            u=rand(n,1);
            x=sum(u<p);
            if x==1
                patients(i,12)=1;
            end
        end
    end
end


v=patients;
end