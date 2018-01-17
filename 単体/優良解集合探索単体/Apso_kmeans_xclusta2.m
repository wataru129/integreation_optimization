
clear
global C dimension upper_limit low_limit
load InitialPoints_300_100_100
C=13;
Trial=1;
clusta =5;
th=1;
upper_limit = 5;
low_limit   = -5;
dimension   = 50;   %dimension
particle    = 300;   %The number of Particle
Iteration   = 1000;  % Max of reiteration
answer      = zeros(dimension,clusta,Trial);
[Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT2(dimension);
for T = 1:Trial
    x_init          = 5*IP(1:particle,1:dimension,T).';
    v_init          = IP(1:particle,1:dimension,T).';
    idx             = kmeans(x_init.',clusta);
    for c_index=1:clusta
%%%%%%%%%%%%%%%%%%%%%%Initialization%%%%%%%%%%%%%%%%%%%%%%%%%
        ct             = 1;
        class(c_index) = size(find(idx == c_index),1);
        x_p            = zeros(dimension,class(c_index));
        v_p            = zeros(dimension,class(c_index));
        for i=1:class(c_index)
            if idx(i)==c_index
                x_p(:,ct)= x_init(:,i);
                v_p(:,ct)= v_init(:,i);
                ct     = ct + 1;
            end
        end
        c1     = 1.4955 * ones(dimension,class(c_index));
        c2     = 1.4955 * ones(dimension,class(c_index));
        w_pso   = 0.729 * ones(dimension,class(c_index));
        alpha             = zeros(1,class(c_index));
        c1_ex     = 1.4955 * ones(1,class(c_index));
        c2_ex     = 1.4955 * ones(1,class(c_index));
        flag              = 0;
        update_particle   = zeros(class(c_index),dimension);
        pbest   = x_p;
        fpbest=zeros(1,class(c_index));
        for i=1:class(c_index)
            fpbest(i)=Calculate_value(pbest(:,i),C);
        end
        [now_best , ig] = min(fpbest);
        gbest=pbest(:,ig);
        fgbest=now_best;
%%%%%%%%%%%%%%%%%%%%%%Initialization%%%%%%%%%%%%%%%%%%%%%%%%%
        for k=1:Iteration
            temp_fpbest=zeros(1,class(c_index));
            gbest_ex = gbest * ones(1,class(c_index));
            rd1      = repelem(rand(1,class(c_index)),dimension,1);
            rd2      = repelem(rand(1,class(c_index)),dimension,1);
            v_p = w_pso.*v_p + c1.*rd1.*(pbest-x_p) ...
                  + c2.*rd2.*(gbest_ex-x_p);
            x_p = x_p + v_p;
            %x_p=Area_back(x_p);
            %v_p=Area_back(v_p);
            x_p(x_p>5)=5;
            x_p(x_p<-5)=-5;
            v_p(v_p>5)=5;
            v_p(v_p<-5)=-5;
            for i=1:class(c_index)
                temp_fpbest(i)=Calculate_value(x_p(:,i),C);
                if(temp_fpbest(i)<fpbest(i))
                    pbest(:,i)=x_p(:,i);
                    fpbest(i) = temp_fpbest(i);
                end
            end
            [now_best , ig] = min(fpbest);
            if now_best < fgbest
                flag= 1;
                update_particle(ig) = update_particle(ig) +1;
                gbest=pbest(:,ig);
                fgbest=fpbest(ig);
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%% Adaptive %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if flag ==0
                alpha = zeros(1,class(c_index));
            else
                for i=1:class(c_index)
                    if update_particle(i) < update_particle(ig)
                        alpha(1,i) = 1/k;
                    else
                        alpha(1,i) = 0;
                    end
                end
            end
            flag = 0;
            c1_ex = c1_ex + alpha.* (c1_ex(ig)*ones(1,class(c_index)) -c1_ex);
            c2_ex = c2_ex + alpha.* (c1_ex(ig)*ones(1,class(c_index)) -c2_ex);
            c1 = repelem(c1_ex,dimension,1) ;
            c2 = repelem(c2_ex,dimension,1) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Adaptive %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        answer(:,c_index,T) = gbest;
    end
    SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, answer(:,:,T), clusta, C);
    result(T) = SUM;
end




