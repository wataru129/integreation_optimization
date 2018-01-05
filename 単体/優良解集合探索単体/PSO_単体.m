def PSO
clear
global plotx  f_number count;

load InitialPoints_300_100_100
%%%PSO-parameter%%%
  w   = 0.729;
  c1  = 1.4955;
  c2  = 1.4955;
  count=0;
%%%%%%%%%%%%%%%%%%
%%%PSO-Algolism%%%%%
%%%Step 0%%%Prepare
  n       = 2;   %dimension
  m       = 30;   %The number of Particle
  k_max   = 100;  % Max of reiteration
  k       = 1;    %initial value of reiteration
%%%Step 1%%%%Reset of initial value
  [r1,r2] = region(f_number);   %Area of x
  x       = r2*IP(1:m,1:n).';    %initial point r2=(|r1|+|r2|)/2
  v       = IP(1:m,1:n).';       %initial velocity
  pbest   = x;               %Best x in the diviual particle
  plotx   = zeros(n,m,k);
  i=1;
  fpbest=zeros(1,m);
  gbest=pbest(:,1);
  fgbest  = func_response_surface(gbest);
  while i<m+1
    fpbest(1,i)=func_response_surface(pbest(:,i));
    if fpbest(1,i)<fgbest
        gbest=pbest(:,i);
        fgbest=fpbest(1,i);
    end
    i=i+1;
  end

%%%Step 2%%%%x,v[update]

  while(k<k_max+1)
      w=1/(2*k)+0.6;
    i=1;
    while(i<m+1)
      j=1;
      while(j<n+1)
        v(j,i)=w*v(j,i)+c1*rand*(pbest(j,i)-x(j,i))+c2*rand*(gbest(j)-x(j,i));
        x(j,i)=x(j,i)+v(j,i);
        j=j+1;
      end
    i=i+1;
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