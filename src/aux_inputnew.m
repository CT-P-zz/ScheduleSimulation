function[bool,r]=aux_inputnew(ts,wd,yw,search_schedule8WI)
bool=false;
r=1;
for timeslot=ts:22
    if search_schedule8WI(timeslot,wd,yw)==0
        bool=true;
        r=timeslot;
        break
    end
end
end