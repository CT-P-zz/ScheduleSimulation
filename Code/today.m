 function[bool,scanner]=today(type,ts,wd,yw,search_schedule4WI,search_schedule8WI)
bool=false;
for timeslot=ts:22
    if search_schedule8WI(timeslot,wd,yw)==type
        bool=true;
        scanner=8;

    end
end
if (ts<=8) && (ts>=3)
    for timeslot=ts:8
        if search_schedule4WI(timeslot,wd,yw)==type
            bool=true;
            scanner=4;
     
        end
    end
end
if bool==false
    scanner=0;
end
 end