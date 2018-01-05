function [Center,Group,count,Cluster,cbest,Fx] = k_means3( m,x,fx )
% m=50;
% Trial=1;
% x = IP(1:m,1:5,Trial);
% n = 5;
%k-means
    global claster_number
    global n
    %Step 1 初期値の決定    
    [~,num] = sort(fx);
    x1 = x(num,:);
    x2 = x1(1:2*claster_number,:);
    Center_number = randperm(1,2*claster_number);
    Center(1,:) = x(Center_number,:);
    for l = 1:
    
    
    P = Center;
    Sum_Error = inf;
    while Sum_Error > 1e-6
        count = zeros(claster_number,1);
        %Step 2　各探索点をクラスタに所属させる
        Cluster = repmat(struct('number',[]),[1 claster_number]);
        Group = repmat(struct('number',[]),[1 claster_number]);
        Fx = repmat(struct('number',[]),[1 claster_number]);
        for i=1:m
            for l=1:claster_number
                Dist(l) = norm( x(i,:)-Center(l,:));
            end
            [~,D_min_num] = min(Dist);
            A = count(D_min_num);
            Cluster(D_min_num).number(A+1) = i;
            count(D_min_num) = A+1;
        end
        for l = 1:claster_number
            B = Cluster(l).number;
            Group(l).number = x(B,:);
        end
%         disp(count)
        %Step 3 重心を決定
        for l = 1:claster_number
            for j=1:n
                Center(l,j) = sum(Group(l).number(:,j))/count(l);
            end
        end
        %Step4 二乗誤差の計算
        error = abs(Center - P);
        Error = sum(error);
        Sum_Error = sum(Error);
        P = Center;
%         figure
%         hold on
%         plot(x(:,1),x(:,2),'go','MarkerSize',10);
%         plot(Center(:,1),Center(:,2),'rp','MarkerSize',10);
%         drawnow
%         hold off
    end
    cbest = [];
    for l = 1:claster_number
%         disp(Cluster(l).number)
        idx = Cluster(l).number;
        Fx(l).number = fx(idx);
        [~,idx_min1] = min(fx(idx));
        idx_min2 = idx(idx_min1);
         if isempty(idx_min2) == 1
             cbest(l,:) = inf*ones(1,n);
         else
             cbest(l,:) = x(idx_min2,:);
         end
    end
end