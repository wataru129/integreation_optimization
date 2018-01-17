function Z = func(x)
  Z = 0;
  X1 = x(1);
  X2 = x(2);
  f_number = 3;
switch f_number
    case 1 %%%対象1%%%
        Z=X1.^2+X2.^2;
    case 2 %%%対象2%%%
        Z=100*((X1.^2-X2).^2)+(1-X1).^2;
    case 3 %%%対象3%%%
        Z=(X1.^4-16*X1.^2+5*X1)+(X2.^4-16*X2.^2+5*X2);
    case 4 %%%対象4%%%      
        Z=(X1.^2-10*cos(2*pi*X1)+10)+(X2.^2-10*cos(2*pi*X2)+10);
    case 5 %%%対象5%%%
        Z=X1.^2+(X1+X2).^2;
    case 6 %%%対象%%%
        Z=X1.^2+(X1*X2)+8*X2.^2;
end