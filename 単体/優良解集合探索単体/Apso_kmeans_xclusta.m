
clear
global C dimension upper_limit low_limit
load InitialPoints_300_100_100
C=13;
Trial=10;
clusta =5;
th=1;
upper_limit = 5;
low_limit   = -5;
dimension   = 10;   %dimension
particle    = 300;   %The number of Particle
Iteration   = 1000;  % Max of reiteration
w_pso       = 0.729;
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
        c1     = 1.4955 * ones(class(c_index),1);
        c2     = 1.4955 * ones(class(c_index),1);
        alpha             = zeros(class(c_index),1);
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
            for i=1:class(c_index)
                v_p(:,i)=w_pso*v_p(:,i)+c1(i)*rand*(pbest(:,i)-x_p(:,i))+c2(i)*rand*(gbest-x_p(:,i));
                x_p(:,i)=x_p(:,i)+v_p(:,i);
                x_p(:,i)=Area_back(x_p(:,i));
                v_p(:,i)=Area_back(v_p(:,i));
                temp_fpbest(i)=Calculate_value(x_p(:,i),C);
                if(temp_fpbest(i)<fpbest(i))
                    pbest(:,i)=x_p(:,i);
                    fpbest(i) = temp_fpbest(i);
                end
            end
            [now_best , ig] = min(fpbest);
            if now_best<fgbest
                flag= 1;
                update_particle(ig) = update_particle(ig) +1;
                gbest=pbest(:,ig);
                fgbest=fpbest(ig);
            end
            if flag ==0
                alpha = zeros(class(c_index),1);
            else
                for i=1:class(c_index)
                    if update_particle(i) < update_particle(ig)
                        alpha(i) = 1/k;
                    else
                        alpha(i) = 0;
                    end
                end
            end
            flag = 0;
            c1 = c1 + alpha.* (c1(ig)*ones(1,class(c_index)) -c1);
            c2 = c2 + alpha.* (c1(ig)*ones(1,class(c_index)) -c2);
        end
        answer(:,c_index,T) = gbest;
    end
    SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, answer(:,:,T), clusta, C);
    result(T) = SUM;
end




