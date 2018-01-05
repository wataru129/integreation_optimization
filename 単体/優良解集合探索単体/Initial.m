function [gbest,fx,fgbest,x] = Initial(m,Trial,L,IP)
    %Step 1:‰Šú‰»
    global dim;
    global C;
    x = L*IP(1:m,1:dim,Trial); %‰Šú‰ğW’c
    x=x.';
    fx = zeros(m,1);
    for i = 1:m
        fx(i) = Calculate_value(x(:,i));
    end
    [fgbest,number] = min(fx);
    gbest = x(:,number);
end

