function [normal_add] = Neighborhood(Times,good,Area_x,normal_add)
%%%%%%%%%%%%%%%%%Sprinkle a point near goood solution %%%%%%%%%%%%%%%%%
global dimension
    add_tmp=[];
    for J=1:Times
        for i=1:dimension
            add_tmp(i,J)=(good(i)+2*rand*Area_x(i))-Area_x(i);
        end
    end
    normal_add=[normal_add;add_tmp];
end