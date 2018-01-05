clear
global plotx  f_number count;

load InitialPoints_300_100_100
%%%PSO-parameter%%%
alpha   = 0.729;
beta    = 1.4955;
gamma   = 1.4955;
delta   =0;
%%%%%%%%%%%%%%%%%%
%%%PSO-Algolism%%%%%
%%%Step 0%%%Prepare
n       = 2;   %dimension
m       = 30;   %The number of Particle
k_max   = 100;  % Max of reiteration
k       = 1;    %initial value of reiteration
%%%Step 1%%%%Reset of initial value
[r1,r2] = region(f_number);   %Area of x

for k=1:k_max
    x       = r2*IP(1:m,1:n).';    %initial point r2=(|r1|+|r2|)/2
    x_hat = x;
    for i= 1:m
        tmp_fx(i)  = Calculate_value(x(:,i));
    end
    fmin = min(tmp_fx);
    for i= 1:m
        I(i) = (abs(fmin - tmp_fx) +1).^(-1);
    end
    x_hat(k)=x;
%%%Step 2%%%%x,v[update]
    for i = 1:m
        B(i)=beta*exp(-gamma*norm())
    end
%%%Step 3%%%%pbest,gbest[update]
    i=1;
    temp_fpbest=zeros(1,m);
    while(i<m+1)
      plotx(:,i,k)=x(:,i);
      temp_fpbest(1,i)=func_response_surface(x(:,i));
      if(temp_fpbest(1,i)<fpbest(1,i))
        pbest(:,i)=x(:,i);
        if fgbest>temp_fpbest(1,i)
          gbest=x(:,i);
          fgbest=temp_fpbest(1,i);
        end
      end
      i=i+1;
    end
%%%Step 4%%%%k addition
    k=k+1;
  end
%%%%%OUTPUT%%%%