function  out  = ft( x )

global hyouka;
global dim;
global C;

out = 0;

switch C
    case 1%Sphere
          out = out + sum(x.^2);
    case 2%Rosen
        for i=1:dim-1
          out = out + 100*( x(i)^2-x(i+1) )^2 + ( 1-x(i) )^2;
        end
    case 3%2nminima
        for i=1:dim
          out = out + x(i)^4 - 16*x(i)^2 + 5*x(i);
        end
    case 4%Rastrigin
        for i=1:dim
          out = out + x(i)^2 - 10*cos(2*pi*x(i) ) + 10;
        end
    case 5%Schwefel
         for i=1:dim
             y1 = 0;
             for  j =1:i
                 y1 = y1 + x(j) ;
             end
             out = out + y1^2;
         end
end
end
