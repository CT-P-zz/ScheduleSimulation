clear all;
close all;
tic

setschedules=zeros(22,5,8);
ptstype=zeros(61,3);
test=zeros(7,2);
contrast=zeros(15,2);
ptstype(:,:)=xlsread('ptstype.xlsx',1,'A2:C62');
ptstypeT(:,:)=xlsread('ptstype.xlsx',2,'C2:D6');
test(:,:)=xlsread('ptstype.xlsx',3,'A2:B8');
contrast(:,:)= xlsread('ptstype.xlsx',4,'A2:B16');



arrival=xlsread('Livro1.xlsx',1,'H1:L21');
%schedules in 'SchedulesNikky
setschedules(:,:,1)=xlsread('SchedulesNikky.xlsx',1,'A1:E22');%1
setschedules(:,:,2)=xlsread('SchedulesNikky.xlsx',2,'A1:E22');%1r
setschedules(:,:,3)=xlsread('SchedulesNikky.xlsx',3,'A1:E22');%2
setschedules(:,:,4)=xlsread('SchedulesNikky.xlsx',4,'A1:E22');%2r
setschedules(:,:,5)=xlsread('SchedulesNikky.xlsx',5,'A1:E22');%3
setschedules(:,:,6)=xlsread('SchedulesNikky.xlsx',6,'A1:E22');%3r
setschedules(:,:,7)=xlsread('SchedulesNikky.xlsx',7,'A1:E22');%4
setschedules(:,:,8)=xlsread('SchedulesNikky.xlsx',8,'A1:E22');%4r
setschedules(:,:,9)=xlsread('SchedulesNikky.xlsx',9,'A1:E22');%T

setschedules4(:,:,1)=xlsread('SchedulesNikky.xlsx',7,'G1:K8');
setschedules4(:,:,2)=xlsread('SchedulesNikky.xlsx',9,'G1:K8');%T


vone=[1,2,5,6]; %1;1r;3;3r just one CT: CT08, with the best schedule for Nikky

vtwo=[3,4,7,8]; %2 and 2r with the best nikky schedule for both CTs, 4 and 4r with spread procedure
n_sche=8;
a=200;
n_ts=22;
n_wd=5;
g=6;
kpi_allruns=zeros(a,5,8);
kpi_allruns2R=zeros(a,6,8);
kpi_allruns2RT=zeros(50,9);
for s=8:n_sche
    schedule=zeros(n_ts,n_wd,52);
    for i=1:52
        schedule(:,:,i)=setschedules(:,:,s);
    end


    for run=1:a
        patientsbeforeT=RandompatientsT(ptstypeT,arrival);
        patientsbefore=Randompatients(ptstype,test, contrast,arrival);
        if any(s==vone)%1;1r;3;3r just one CT: CT08, with the best schedule for Nikky
            [patientsafter,scheduleafter]=Inputnew(patientsbefore,schedule,g);

            [at,wt,def,fwi,ut]=kpi_oneresource(scheduleafter,patientsbefore,patientsafter);
            kpi_allruns(run,:,s)=[at,wt,def,fwi,ut];

        end
        if any(s==vtwo)%2 and 2r with the best nikky schedule for both CTs
           
            schedulect4=zeros(8,5,52);
            for i=1:52
                schedulect4(:,:,i)=setschedules4(:,:,1);
            end

            [patientsafter,scheduleafter,schedulect4after]=Inputnewboth(patientsbefore,schedule,schedulect4,g);

           [at,wt,def,fwi,ut,ut4]=kpi_tworesources(scheduleafter,schedulect4after,patientsafter,patientsbefore);
           kpi_allruns2R(run,:,s)=[at,wt,def,fwi,ut,ut4];

        end
        
        if s==9
            schedulect4=zeros(8,5,52);
            for i=1:52
                schedulect4(:,:,i)=setschedules4(:,:,2);
            end
           [patientsafterT,scheduleafter,schedulect4after]=InputTraditionalmore(patientsbeforeT,schedule,schedulect4,g);
           [at,wt,def,fwi,l3,l4,l5,ut,ut4]=kpi_tworesourcesT(scheduleafter,schedulect4after,patientsafterT,patientsbeforeT);
            kpi_allruns2RT(run,:)=[at,wt,def,fwi,l3,l4,l5,ut,ut4];
        end
%         clearvars patientsafter scheduleafter schedulect4after
    end

      
   
end

xlswrite('Results4.xlsx',kpi_allruns(:,:,1),1);
xlswrite('Results4.xlsx',kpi_allruns(:,:,2),2);
xlswrite('Results4.xlsx',kpi_allruns(:,:,5),5);
xlswrite('Results4.xlsx',kpi_allruns(:,:,6),6);

xlswrite('Results4.xlsx',kpi_allruns2R(:,:,3),3);
xlswrite('Results4.xlsx',kpi_allruns2R(:,:,4),4);
xlswrite('Results4.xlsx',kpi_allruns2R(:,:,7),7);
xlswrite('Results4.xlsx',kpi_allruns2R(:,:,8),8);
xlswrite('Results4.xlsx',kpi_allruns2RT(:,:),9);

toc
load handel
sound(y,Fs)