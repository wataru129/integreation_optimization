candidate=[];
sample_distance_add_total=[];
sparse_rand_num =100;
sample_distance=zeros(sparse_rand_num,1);

for i=1:sparse_rand_num
%Create random point for additional point
    for k=1:dimension
        candidate(k,i) = (-5 + (5+5)*rand);
    end
end

for J=1:sparse_rand_num
%Caluculate total distance
    for i=1:sample_num
    %Existing point
        dis                = sqrt(sum((candidate(:,J)-normal(:,i)).*2));
        sample_distance(J) = sample_distance(J)+dis;
    end
    for i=1:size(normal_add_temp,2)
    %Additional point
        dis                = sqrt(sum((candidate(:,J)-normal_add_temp(:,i)).*2));
        sample_distance(J) = sample_distance(J)+dis;
    end
end

%Select max distance point
[sample_distance_max index]    = max(sample_distance);
selected_point                 = candidate(:,index);
normal_add_temp(:,sp_count)    = selected_point;
%disp(normal_add_temp);
sp_count             = sp_count + 1;

