%Split Firefly Algorithm
function x = Movement_SFA( x,x_hat,alpha,m,dim,beta0,fx,gamma,gamma0 )
    fmin = min(fx);
    FF = ones(m,1)./(abs(fmin*ones(m,1)-fx)+1);
    for i = 1:m
        %Œõ‹­“x‚ÌŒvŽZ
        I0 =1/(abs(fmin-fx(i))+1);
%         gamma0 = gamma;
        for s = 1:m
            sabun = x_hat(:,s)-x(:,i);
            r = norm(sabun);
            I(s) = FF(s,1)*exp(-gamma0*r.^2);
        end
        [I, Sort] = sort(I);
        x_hat = x_hat(:,Sort);
        FF = FF(Sort,1);
        counter = 0;
        for s = 1:m
            if I0 < I(s)
                sabun = x_hat(:,s)-x(:,i);
                beta = beta0*exp(-gamma*norm(sabun).^2);
                x(:,i) = x(:,i) + beta*(sabun) + alpha*(rand(dim,1) - 0.5);
                counter = 1;
            else
            end
        end
        %ŽQÆ‚·‚é’Tõ“_‚ª‚È‚©‚Á‚½ê‡
        if counter == 0
            x(:,i) = x(:,i) + alpha*(rand(dim,1) - 0.5);
        end
    end
end