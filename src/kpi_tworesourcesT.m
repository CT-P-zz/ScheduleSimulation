function[at,wt,def,fwi,l3,l4,l5,ut,ut4]=kpi_tworesourcesT(scheduleafter,schedulect4,patientsafterT,patientsbeforeT)
l=length(patientsafterT);
aux_at=0;
for i=2:l
    if patientsafterT(i,9)~=0
        aux_at=aux_at+patientsafterT(i,9);
    end
end
    at=aux_at/sum(patientsafterT(:,9)~=0);
    
aux_wt=0;
for i=2:l
    if patientsafterT(i,10)~=9
        aux_wt=aux_wt+patientsafterT(i,10);
    end
end
    wt=aux_wt/sum(patientsafterT(:,10)~=0);
    k4=sum(patientsbeforeT(:,4)==4);
     k5=sum(patientsbeforeT(:,4)==5);
      k3=sum(patientsbeforeT(:,4)==3);
def=sum(patientsafterT(:,12)==-1)/(k4+k5+k3);
fwi=1-def;

l3=mean(mean(sum(scheduleafter==3),3))/4;
l4=mean(mean(sum(scheduleafter==4),3))/2;
l5=mean(mean(sum(scheduleafter==5),3))/2;

k=sum(scheduleafter~=-1);
km=mean(mean(k,3))/22;
ut=1-km;

k4=sum(schedulect4~=-1);
km4=mean(mean(k4,3))/22;
ut4=1-km4;
end