normal_add_temp_c=[];
normal_ex = normal;
normal_ex = [normal_ex normal_add_temp];
sort_point = sort(normal_ex,1);
for i = 1:size(normal_ex,2)-1
    for j = 1:dimension
        normal_add_temp_c(j,i) = abs(sort_point(j,i+1)-sort_point(j,i));
    end
end

[distance_max index] = max(normal_add_temp_c);
for j = 1:dimension
    selected_point(j) = sort_point(index(j),j)+distance_max(j)./2;
end
normal_add_temp(:,sp_count)=selected_point;
%disp(normal_add_temp);
sp_count             = sp_count + 1;