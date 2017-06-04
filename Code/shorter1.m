function[scanner,rf,jf,lf,atf]=shorter1(ts,wd,yw,search_schedule8,search_schedule4)
[r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==1,1)); 
[r4,j4,l4]=ind2sub(size(search_schedule8),find(search_schedule4==1,1)); 
a=isempty(r);
b=isempty(r4);
wds=false;
if a==false && b==false
     at=accesstime(ts,wd,yw,r,j,l)/22;
      at4=accesstime4(ts,wd,yw,r4,j4,l4)/22;
if at4<at
    rf=r4;
    jf=j4;
    lf=l4;
    wds=true;
    scanner=4;
    atf=at4;
else
    rf=r;
    jf=j;
    lf=l;
     wds=true;
     scanner=8;
     atf=at;
end
end
if b==true &&  wds==false
    at=accesstime(ts,wd,yw,r,j,l)/22;
    rf=r;
    jf=j;
    lf=l;
    wds=true;
    scanner=8;
    atf=at;
end


end
