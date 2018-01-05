%スケジュールFA
function x = Movement_FA( x,x_hat,gamma,alpha,m,dim,I,beta0 )
    for i = 1:m-1
        for j = i+1:m
            if I(i) < I(j)
                Sabun = x_hat(:,j)-x(:,i);
                r = norm(Sabun); %distance
                beta = beta0*exp(-gamma*r.^2); %miryoku
                x(:,i) = x(:,i) + Sabun.*beta + alpha.*(rand(dim,1) - 0.5); %update
            end
        end
    end
    x(:,m) = x(:,m) + alpha.*(rand(dim,1) - 0.5); %best firefly
end