function [pl,ql,pr,qr]=ex20_1bc(xl,ul,xr,ur,t)
    pl=ul;
    ql=0;
    pr=pi*exp(-t);
    qr=1;
end
