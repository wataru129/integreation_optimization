function [Opt1, OP, L] = OPT(n)
    global C
    switch C
            case 1 %Sphere
                Opt1 = zeros(1,n);
                OP = 1; L = 5;
            case 2 %Rosen
                Opt1 = ones(1,n);
                OP = 1; L = 2;
            case 3 %2nminima
                Opt1 = -2.9*ones(1,n);
                OP = 1; L = 5;
            case 4 %Rastrigin
                Opt1 = zeros(1,n);
                OP = 1; L = 5;
            case 5 %Schwefel
                Opt1 = zeros(1,n);
                OP = 1; L = 5;
    end
end

