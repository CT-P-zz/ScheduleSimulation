function[scanner,rf,jf,lf,atf]=shorter0(ts,wd,yw,search_schedule8,search_schedule4)

[r5,j5,l5]=ind2sub(size(search_schedule8),find(search_schedule8==5,1)); 
[r,j,l]=ind2sub(size(search_schedule8),find(search_schedule8==1,1)); 
[r4,j4,l4]=ind2sub(size(search_schedule4),find(search_schedule4==1,1)); 
a=isempty(r5);
b=isempty(r4);
wds=false;

if a==false && b==false
         at5=accesstime(ts,wd,yw,r5,j5,l5)/22;
         at=accesstime(ts,wd,yw,r,j,l)/22;
         A=[ at5 at ];
          [m i]=min(A);
    
    if i==2
        rf=r;
        jf=j;
        lf=l;
         wds=true;
         scanner=8;
         atf=at;
    end
    if i==1
          rf=r5;
        jf=j5;
        lf=l5;
         wds=true;
         scanner=8;
         atf=at5;
    end
end

if b==true && a==false wds==false
     at5=accesstime(ts,wd,yw,r5,j5,l5)/22;
         at=accesstime(ts,wd,yw,r,j,l)/22;
          at4=accesstime4(ts,wd,yw,r4,j4,l4)/22;
          A=[ at5 at at4];
          [m i]=min(A);
    if i==3
        rf=r4;
        jf=j4;
        lf=l4;
        wds=true;
        scanner=4;
        atf=at4;
    end

    if i==2
        rf=r;
        jf=j;
        lf=l;
         wds=true;
         scanner=8;
         atf=at;
    end
    if i==1
          rf=r5;
        jf=j5;
        lf=l5;
         wds=true;
         scanner=8;
         atf=at5;
    end
end

if a==true && b==false && wds==false
         at4=accesstime(ts,wd,yw,r4,j4,l4)/22;
         at=accesstime(ts,wd,yw,r,j,l)/22;
         A=[ at4 at ];
          [m i]=min(A);
    
    if i==2
        rf=r;
        jf=j;
        lf=l;
         wds=true;
         scanner=8;
         atf=at;
    end
    if i==1
          rf=r4;
        jf=j4;
        lf=l4;
         wds=true;
         scanner=4;
         atf=at4;
    end
end
if wds==false && a==true && b==true
    at=accesstime(ts,wd,yw,r,j,l)/22;
     rf=r;
        jf=j;
        lf=l;
         wds=true;
         scanner=8;
         atf=at;
end

end
