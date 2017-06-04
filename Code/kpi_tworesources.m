function[at,wt,def,fwi,ut,ut4]=kpi_tworesources(scheduleafter,schedulect4,patients,patientsbefore)
l=length(patients);
aux_at=0;
for i=2:l
    if isnan(patients(i,5))
        aux_at=aux_at+patients(i,9);
    end
end
    at=aux_at/sum(isnan(patients(:,5)));
    
aux_wt=0;
for i=2:l
    if patients(i,5)==1
        aux_wt=aux_wt+patients(i,10);
    end
end
    wt=aux_wt/sum(patients(:,5)==1);
    
def=sum(patients(:,11)==-1)/sum(patientsbefore(:,5)==1);
fwi=1-def;

k4=sum(schedulect4~=-1);
km4=mean(mean(k4,3))/22;
ut4=1-km4;

k=sum(scheduleafter~=-1);
km=mean(mean(k,3))/22;
ut=1-km;
end