 function[result,aux,aux4]=biggerWIts(ts,wd,yw,g,search_schedule4WI,search_schedule8WI)
% ts=4;
% wd=2;
% yw=1;
% g=6;
% search_schedule8WI=schedule;
% search_schedule4WI=schedulect4;
aux=search_schedule8WI(:,wd,yw);
result=10;
xx=false;
for i=1:22
    if aux(i)==0
        xx=true;
        r=i;
        break
    end
end
xx4=false;
 aux4=search_schedule4WI(:,wd,yw);
% if (3<=ts) && (ts<=8) && wd~=1
   
   for i=1:8
   if aux4(i)==0
       xx4=true;
       r4=i;
   end
   end
% end
if xx==true && xx4==true
    if r4<r
        if r4-ts<=g
        result=4;
        end
    elseif r-ts<=g
        result=8;
    end
end
if xx==true && xx4==false
    
    if r-ts<=g
        result=8;
    end
    
end

if xx==false && xx4==true
    
    if r4-ts<=g
        result=4;
    end
    
end

    
 end
