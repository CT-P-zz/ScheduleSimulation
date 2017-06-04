% 
% arrivalrate=zeros(22,5,1);
% setschedules=zeros(22,5,8);
% ptstype=zeros(5,2);
% 
% ptstype(:,:)=xlsread('ptstype.xlsx',2,'C2:D6');
% 
% 
% arrivalrate=xlsread('Livro1.xlsx',1,'A1:E22');

function [v]= RandompatientsT(ptstype,arrivalrate)
n_parameters=13;
a=52;
n_wd=5;
n_ts=21;
n_types=5;
   

patients=zeros(1,n_parameters);
   
for I_yd=1:a
for I_wd=1:n_wd
    for I_ts=1:n_ts
        lambda=arrivalrate(I_ts,I_wd);
        r=poissrnd(lambda,1);
        if r~=0
            for i=1:r
                a=[I_ts I_wd I_yd 0 0 0 0 0 0 0 0 0 0];
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
% for i=2:length(patients)
%    
%     
%     for t=1:n_types
%         if patients(i,4)==t
%            patients(i,5)=ptstype(t,3);
%         end
%     end
% end



v=patients;
end