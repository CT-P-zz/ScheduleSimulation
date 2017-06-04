% clear all;
% setschedules(:,:,3)=xlsread('SchedulesNikky.xlsx',4,'A1:E22');
% 
% ptstype=zeros(61,3);
% test=zeros(7,2);
% contrast=zeros(15,2);
% ptstype(:,:)=xlsread('ptstype.xlsx',1,'A2:C62');
% test(:,:)=xlsread('ptstype.xlsx',3,'A2:B8');
% contrast(:,:)= xlsread('ptstype.xlsx',4,'A2:B16');
% 
% arrival=xlsread('Livro1.xlsx',1,'A1:E21');
% patients=Randompatients(ptstype,test, contrast,arrival);
% 
 function[v,s]=Inputnew(patients,schedule,g)
%  patients(:,13)=zeros(length(patients),1);
 wds=false;

% wds=false;%not scheduled yet
% n_ts=22;
% n_wd=5;
% a=52;
% g=6;
% 
% schedule=zeros(n_ts,n_wd,52);
% for i=1:52
%     schedule(:,:,i)=setschedules(:,:,3);
% end
% 
% setschedules4(:,:,2)=xlsread('SchedulesNikky.xlsx',7,'G1:K8');
% schedulect4=zeros(8,5,52);
% for i=1:52
%     schedulect4(:,:,i)=setschedules4(:,:,2);
% end
search_schedule8=schedule; %auxiliary schedule to search the first time slot available after arrival
search_schedule8WI=schedule;
% search_schedule8DEF=schedule;
% search_schedule4=schedulect4;
i=2;
while i<length(patients) && patients(i,3)<51 %checks line by line in patients table
    ts=patients(i,1); %timeslot inicial
    wd=patients(i,2); %weekday inicial
    yw=patients(i,3); %yearweek inicial
    
    if isnan(patients(i,5))
        %%%%%%%%%APP W/ CONT%%%%%%%%%few
        
        
        
        if patients(i,12)==1 %Column 12 for contrast, if it is equal to 1 mean the pts needs contrast
            
            search_schedule8(:,wd,yw)=-1; %all entries before arrival set to zero, so they do not count
            
            [r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==5,1)); %find the first ts=1 (pts w/ cont)
               b=isempty(r);
            if b==false
            schedule(r,j,l)=2;
            search_schedule8(r,j,l)=-1;
            wds=true;
            patients(i,6)=r;
            patients(i,7)=j;
            patients(i,8)=l;
            patients(i,9)=accesstime(ts,wd,yw,r,j,l)/22;
            end
        end
        
        
        
        
        %%%%%%%APP NO CONT%%%%%%
        
        if patients(i,12)==0 %Column 12 for contrast, if it is equal to 0 mean the pts dont need contrast
            
            
            search_schedule8(:,wd,yw)=-1;
            [r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==1,1));%find the first ts=5 (pts without cont)
            b=isempty(r);
            if b==false
                schedule(r,j,l)=2;
                search_schedule8(r,j,l)=-1;
                wds=true;
                patients(i,6)=r;
                patients(i,7)=j;
                patients(i,8)=l;
                patients(i,9)=accesstime(ts,wd,yw,r,j,l)/22;
            end
            end
       
    end
    
    
    %%%%%%%WALKIN%%%%%%
    if patients(i,5)==1 %%INLOOP
        
        if wd~=1
            
            search_schedule8WI(:,wd-1,yw)=-1;
        end
        
        search_schedule8WI(1:ts-1,wd,yw)=-1; %all entries before arrival set to zero, so they do not count
        
        [bool,r]=aux_inputnew(ts,wd,yw,search_schedule8WI);
        if bool==true
            if (r-ts)<=g
                
                schedule(r,wd,yw)=-1;
                search_schedule8WI(r,wd,yw)=-1;
                wds=true;
                patients(i,6)=r;
                patients(i,7)=wd;
                patients(i,8)=yw;
                patients(i,10)=r-ts;
            end
        end
        if wds==false
            a=patients(1:i-1,:);
            b=[patients(i,1),patients(i,2),patients(i,3),patients(i,4),NaN,0,0,0,0,0,-1,0];
            c=patients((i+1):length(patients),:);
            patients=[a;b;c];
            i=i-1;
        end
        
        
        
        
    end
    
    
    
    bool=false;
    i=i+1;
    wds=false;
    
end
v(:,:)=patients(:,:);
s(:,:,:)=schedule(:,:,:);

 end