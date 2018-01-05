%%%PSO-parameter%%%
w_pso   = 0.729;
c1      = 1.4955;
c2      = 1.4955;
m       = 40;      %The number of Particle
k_max   = 400;     % Max of reiteration
%%%%%%%%%%%%%%%%%%

%%%PSO-Algolism%%%%%
%%%Step 1%%%%prepare
x_p       = upper_limit*IP(1:m,1:dimension).';    %initial point r2=(|r1|+|r2|)/2
v_p       = IP(1:m,1:dimension).';       %initial velocity
pbest   = x_p;               %Best x_p in the diviual particle
fpbest=zeros(1,m);
gbest=pbest(:,1);
fgbest  = func_response_surface(gbest, cur_sample_num, omega, r, sample_point);
for i=1:m
    fpbest(i)=func_response_surface(pbest(:,i), cur_sample_num, omega, r, sample_point);
    if fpbest(i)<fgbest
        gbest=pbest(:,i);
        fgbest=fpbest(i);
    end
end
%%%Step 2%%%%x_p,v_p[update]
for k=1:k_max
    temp_fpbest=zeros(1,m);
    for i=1:m
        v_p(:,i)=w_pso*v_p(:,i)+c1*rand*(pbest(:,i)-x_p(:,i)) ...
               +c2*rand*(gbest(:)-x_p(:,i));
        x_p(:,i)=x_p(:,i)+v_p(:,i);
        for j = 1:dimension
            if x_p(j,i) > upper_limit
                    x_p(j,i) = upper_limit;
            end
            if x_p(j,i) < low_limit
                x_p(j,i) = low_limit;
            end
        end

%%%Step 3%%%%pbest,gbest[update]
        temp_fpbest(i)=func_response_surface(x_p(:,i), cur_sample_num, omega, r, sample_point);
        if(temp_fpbest(i)<fpbest(i))
            pbest(:,i)=x_p(:,i);
            fpbest(i) = temp_fpbest(i);
            if fgbest>temp_fpbest(i)
                gbest=x_p(:,i);
                fgbest=temp_fpbest(i);
            end
        end
    end
end
%%%%%OUTPUT%%%%
x_pso = gbest;
suii_fgbest(C) = fgbest;
suii_pso(C) = Calculate_value(x_pso);