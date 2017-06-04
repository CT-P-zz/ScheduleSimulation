function[a]=accesstime(ts,wd,yw,r,j,l)

% ts=5;
% wd=1;
% yw=1;
% r=3;
% j=2;
% l=1;



a=0;
for w=1:52
    for k=1:5
        for i=1:22
            a=a+1;
            if i==ts && k==wd && w==yw
              a=0;
            end
            if i==r && k==j && w==l
                return
            end
        end
    end
end

end
