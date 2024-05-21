function separate = checkSeparate(r1,x1,y1,r2,x2,y2)
    dist = sqrt((x2-x1)^2 + (y2-y1)^2);
    if(r1+r2 < dist || r1 == 0 || r2 == 0)
        separate = true;
    else
        separate = false;
    end
end