function [D_min,Center,Group,count] = k_means( m,x )
% m=50;
% Trial=1;
% x = IP(1:m,1:5,Trial);
% n = 5;
%k-means
    global claster_number
    global n
    %Step 1 初期値の決定
    Center_number = randperm(m,claster_number);
    Center = x(Center_number,:);
    P = Center;
    Sum_Error = inf;
    while Sum_Error > 1e-3
        count = zeros(claster_number,1);
        %Step 2　各探索点をクラスタに所属させる
        Group = zeros(m,n,claster_number);
        for i=1:m
            for s=1:claster_number
                Dist(s) = norm( x(i,:)-Center(s,:));
            end
            [D_min(i),D_min_num] = min(Dist);
            Group(count(D_min_num)+1,:,D_min_num) = x(i,:);
            count(D_min_num) = count(D_min_num)+1;
        end
        %Step 3 重心を決定
        for l = 1:claster_number
            if count(l) == 0
                count(l) = 1;
            else
            end
            
            for j=1:n
                Center(l,j) = sum(Group(:,j,l))/count(l);
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
    for i=1:m
        for s=1:claster_number
            Dist(s) = norm( x(i,:)-Center(s,:));
        end
        [D_min(i),~] = min(Dist);
    end
end