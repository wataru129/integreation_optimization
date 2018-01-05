%�K��FA
function [x,Gamma] = Movement_FA_kmeans2( x,xo,alpha,m,n,I,beta0,cbest,k,Gamma,c )
    global claster_number
    for i = 1:m-1
        for l = 1:claster_number
            D_min(l) = norm(x(i,:)-cbest(l,:));
        end
        [~,num] = min(D_min);
        gamma = c/D_min(num)^2;
%         Gamma(k) = Gamma(k)+gamma; 
        for s = i+1:m
            if I(i,1) < I(s,1)
                Sabun = xo(s,:)-x(i,:);
                r = norm(Sabun); %2�_�Ԃ̋���
                beta = beta0*exp(-gamma*r.^2); %����
                x(i,:) = x(i,:) + Sabun.*beta + alpha.*(rand(1,n) - 0.5); %�X�V��
            else
            end
        end
    end
    x(m,:) = x(m,:) + alpha.*(rand(1,n) - 0.5); %�ł����邢�u�̈ړ�
end

