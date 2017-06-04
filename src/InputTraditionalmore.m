% clear all;
% % arrivalrates=zeros(22,5,1);
% setschedules=zeros(22,5,8);
% ptstype=zeros(5,2);
% 
% ptstype(:,:)=xlsread('ptstype.xlsx',2,'C2:D6');
% arrivalrates(:,:,1)=xlsread('Livro1.xlsx',1,'A1:E22');
% setschedules(:,:,1)=xlsread('SchedulesNikky.xlsx',9,'A1:E22');
% setschedulesct4(:,:,1)=xlsread('SchedulesNikky.xlsx',9,'G1:K8');
% 
% arrival=arrivalrates(:,:,1);
% for i=1:53
%     schedule(:,:,i)=setschedules(:,:,1);
% end
% 
% for i=1:53
%     schedule4(:,:,i)=setschedulesct4(:,:,1);
% end
% 
% 
% patients=RandompatientsT(ptstype,arrival);


 function[v,s,s4]=InputTraditionalmore(patients,schedule,schedulect4,g)

wds=false;%not scheduled yet
% n_ts=22;
% n_wd=5;
% a=52;

search_schedule8=schedule; %auxiliary schedule to search the first time slot available after arrival
search_schedule4=schedulect4;
search_schedule8WI=schedule; %auxiliary schedule to search the first time slot available after arrival
search_schedule4WI=schedulect4;
i=2;
while i<length(patients) && patients(i,3)<51 %checks line by line in patients table
    ts=patients(i,1); %timeslot inicial
    wd=patients(i,2); %weekday inicial
    yw=patients(i,3); %yearweek inicial
    search_schedule8WI(1:ts-1,wd,yw)=-1;
        search_schedule4WI(1:ts-1,wd,yw)=-1;
    search_schedule8(:,wd,yw)=-1;
    search_schedule8(:,wd+1,yw)=-1;
    search_schedule8(:,wd+2,yw)=-1;
        search_schedule4(:,wd,yw)=-1;
        search_schedule4(:,wd+1,yw)=-1;
    search_schedule4(:,wd+2,yw)=-1;
    
    if patients(i,4)==1 %Appointments, next day
        
        [r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==1,1)); %find the first ts=1 (pts w/ cont)
        [r2,j2,l2]=ind2sub(size(search_schedule8),find(search_schedule8==2,1)); 
        if r~=[]
        at=accesstime(ts,wd,yw,r,j,l)/22;
        at2=accesstime(ts,wd,yw,r2,j2,l2)/22;
        if at2<at
        schedule(r,j,l)=-1;
        search_schedule8(r,j,l)=-1;
        wds=true;
        patients(i,6)=r2;
        patients(i,7)=j2;
        patients(i,8)=l2;
        patients(i,9)=at2;
        else
            
        schedule(r,j,l)=-1;
        search_schedule8(r,j,l)=-1;
        wds=true;
        patients(i,6)=r;
        patients(i,7)=j;
        patients(i,8)=l;
        patients(i,9)=at;
        end
        else
            schedule(r,j,l)=-1;
        search_schedule8(r,j,l)=-1;
        wds=true;
        patients(i,6)=r2;
        patients(i,7)=j2;
        patients(i,8)=l2;
        patients(i,9)=accesstime(ts,wd,yw,r2,j2,l2)/22;
        end
    end
    
    if patients(i,4)==2 %Appointments, next day
        
        [r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==2,1)); %find the first ts=1 (pts w/ cont)
        [r4,j4,l4]=ind2sub(size(search_schedule4),find(search_schedule4==2,1));
        at=accesstime(ts,wd,yw,r,j,l)/22;
        at4=accesstime(ts,wd,yw,r4,j4,l4)/22;
        if at4<at
            schedulect4(r4,j4,l4)=-1;
            search_schedule4(r4,j4,l4)=-1;
            wds=true;
            patients(i,6)=r4;
            patients(i,7)=j4;
            patients(i,8)=l4;
            patients(i,9)=at4;
            patients(i,13)=1;
        end        
        
        if wds==false
            
            schedule(r,j,l)=-1;
            search_schedule8(r,j,l)=-1;
            wds=true;
            patients(i,6)=r;
            patients(i,7)=j;
            patients(i,8)=l;
            patients(i,9)=accesstime(ts,wd,yw,r,j,l)/22;
        end
    end
    
    if patients(i,4)==3 %Column 12 for contrast, if it is equal to 1 mean the pts needs contrast
        type=3;
        [bool,scanner]=today(type,ts,wd,yw,search_schedule4WI,search_schedule8WI);
       
        if bool==true && scanner==8
        [r,j,l]=ind2sub(size(search_schedule8WI),find(search_schedule8WI==3,1)); %type 3 in the same day
        at=accesstime(ts,wd,yw,r,j,l)/22;
        schedule(r,j,l)=-1;
            search_schedule8WI(r,j,l)=-1;
            wds=true;
            patients(i,6)=r;
            patients(i,7)=j;
            patients(i,8)=l;
            patients(i,9)=accesstime(ts,wd,yw,r,j,l)/22;
        end
        if bool==true && scanner==4
        [r4,j4,l4]=ind2sub(size(search_schedule4WI),find(search_schedule4WI==3,1));        
        at4=accesstime(ts,wd,yw,r4,j4,l4)/22;
            schedulect4(r4,j4,l4)=-1;
            search_schedule4WI(r4,j4,l4)=-1;
            wds=true;
            patients(i,6)=r4;
            patients(i,7)=j4;
            patients(i,8)=l4;
            patients(i,9)=at4;
            patients(i,13)=1;
        end
         if bool==false
            patients(i,12)=-1;%deferred
            patients(i,4)=2;
            i=i-1;%read the line again
        end
        
            end
    
    if patients(i,4)==4 %para alem do 2, têm tambem o 4
        
         type=4;
        [bool,scanner]=today(type,ts,wd,yw,search_schedule4WI,search_schedule8WI);
        
        if bool==true && scanner==8
        [r,j,l]=ind2sub(size(search_schedule8WI),find(search_schedule8WI==4,1)); %type 3 in the same day
        at=accesstime(ts,wd,yw,r,j,l)/22;
        schedule(r,j,l)=-1;
            search_schedule8WI(r,j,l)=-1;
            wds=true;
            patients(i,6)=r;
            patients(i,7)=j;
            patients(i,8)=l;
            patients(i,10)=accesstime(ts,wd,yw,r,j,l)/22;
        end
        if bool==true && scanner==4
        [r4,j4,l4]=ind2sub(size(search_schedule4WI),find(search_schedule4WI==4,1));        
        at4=accesstime(ts,wd,yw,r4,j4,l4)/22;
            schedulect4(r4,j4,l4)=-1;
            search_schedule4WI(r4,j4,l4)=-1;
            wds=true;
            patients(i,6)=r4;
            patients(i,7)=j4;
            patients(i,8)=l4;
            patients(i,10)=at4;
            patients(i,13)=1;
        end
        if bool==false 
            patients(i,12)=-1;%deferred
            patients(i,4)=2;
            i=i-1;%read the line again
        end
    end
    
    
    if patients(i,4)==5 %%para alem do 2, têm tambem o 5
        wds=false;
         type=5;
        [bool,scanner]=today(type,ts,wd,yw,search_schedule4WI,search_schedule8WI);
       
        if bool==true && scanner==8
        [r,j,l]=ind2sub(size(search_schedule8WI),find(search_schedule8WI==5,1)); %type 3 in the same day
        wt=accesstime(ts,wd,yw,r,j,l);
        if wt<=2
        schedule(r,j,l)=-1;
            search_schedule8WI(r,j,l)=-1;
            wds=true;
            patients(i,6)=r;
            patients(i,7)=j;
            patients(i,8)=l;
            patients(i,10)=accesstime(ts,wd,yw,r,j,l);
        end
        end
       
         if  wds==false
            patients(i,12)=-1;%deferred
            patients(i,4)=2;
            i=i-1;%read the line again
        end
    end
    bool=false;
    scanner=0;
    i=i+1;
    wds=false;
    
end
v(:,:)=patients(:,:);
s(:,:,:)=schedule(:,:,:);
s4(:,:,:)=schedulect4(:,:,:);
 end