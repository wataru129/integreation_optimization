global dimension


%%%%%%%%%%%%%%Setting for checking program%%%%%%%%%%%
load InitialPoints_300_100_100
syokipoint     = IP;
dimension      = 2;
sample_syoki   = 300;
sample_num     = sample_syoki;
add_sample_num = 10;
upper_limit    = 5;
low_limit      = -5;
normal         = syokipoint(1:sample_num,1:dimension,1).';
for i = 1:sample_num
    for j = 1:dimension
        normal(j,i) = upper_limit*normal(j,i);
    end
end
update_flag = 1;
C       = 1;
Cr      = 1;
C_total = 10;
x_pso  = [0.55;0.55];
normal_best = [0.55;0.55];
%%%%%%%%%%%%%%Setting for checking program%%%%%%%%%%%

%%%%%%%%%%%%%          Initial setting         %%%%%%%%%%%%%
normal_add      = [];  %Init additional sample point
normal_add_temp = [];  %Init temporary sample point
N_sparse        = floor((1-(C/C_total)).*add_sample_num+0.5); %Number of sparse area
if N_sparse == 10
    N_sparse = 9;
end
N_good=add_sample_num-N_sparse;  %Number of good area
for i = 1:dimension
    Area_x(i)=((1-(-1))/2)*(1-(Cr/(C_total+1)));  %caluculate Area_x
end
Area_x = Area_x.';
%%%%%%%%%%%%%          Initial setting         %%%%%%%%%%%%%%

%%%%%%%%%%%%% Main program of additional point %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Case of update best solution %%%%%%%%%%%%%
if update_flag == 1
    disp('case1')
    normal_add = Neighborhood(N_good,normal_best,Area_x,normal_add);
    Sparse_area
    Cr = Cr + 1;
%%%%%%%%%%%%% Case of NOT update best solution %%%%%%%%%%%%%
else
    distance_p_b = sqrt(sum((x_pso-normal_best).^2)); %distance pso and xbest
    Area_x_pb = sum(Area_x);                          %distance Area_x
    if Area_x_pb >= distance_p_b
        disp('case2')
    %/// xbest neighborhood ///%
        best_case = 1;
        normal_add = Neighborhood(N_good,normal_best,Area_x,normal_add);
        Sparse_area
        Cr = Cr + 1;
    else
        disp('case3')
    %/// pso neighborhood ///%
        x_best_times = floor(N_good/2);
        normal_add = Neighborhood(x_best_times,normal_best,Area_x,normal_add);
        normal_add = Neighborhood(N_good-x_best_times,x_pso,Area_x,normal_add);
        Sparse_area
    end
end

%%%%%%%%%%%%% Judgement of additional sample point %%%%%%%%%%%%%
%/// If it is outside the range, return it to the end point ///%
for i = 1:add_sample_num
    for j = 1:dimension
        if normal_add(j,i) > upper_limit
            normal_add(j,i) = upper_limit;
        end
        if normal_add(j,i) < low_limit
            normal_add(j,i) = low_limit;
        end
    end
end
%normal1 = [normal1;normal_add];
normal = [normal normal_add];
for i=1:add_sample_num
    for j = 1:dimension
        normal_add(j,i) = (upper_limit+low_limit)./2 ...
                          +((upper_limit-low_limit)./2).*normal_add(j,i);
    end
end
C = C + 1;