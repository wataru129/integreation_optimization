
function [Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT2(dim)
    L = 0; L1 = 0; L2 = 0;
    Opt1 = inf; Opt2 = inf; Opt3 = inf; Opt4 = inf; Opt5 = inf;
    global C
    switch C
            case 1 %Sphere
                Opt1 = zeros(dim,1);
                OP = 1; L = 5;
            case 2 %Rosen
                Opt1 = ones(dim,1);
                OP = 1; L = 2;
            case 3 %2nminima
                Opt1 = -2.9*ones(dim,1);
                OP = 1; L = 5;
            case 4 %Rastrigin
                Opt1 = zeros(dim,1);
                OP = 1; L = 5;
            case 5 %Schwefel
                Opt1 = zeros(dim,1);
                OP = 1; L = 5;
            case 6 %Double-Cone
                L = 5;
            case 7 %Double-Rosen
                L = 2;
            case 8 %Six-hump Camelback
                Opt1 = [-0.0898,0.7126];
                Opt2 = [0.0898,-0.7126];
                OP = 2; L1 = 2; L2 = 1;
            case 9 %Branin's
                Opt1 = [-3.142,12.275];
                Opt2 = [3.142,2.275];
                Opt3 = [9.425,2.475];
                OP = 3; L1 = 5; L2 = 15;
            case 10 %Shubert's
                Opt1 = [-1.425,-0.800];
                Opt2 = [-0.800,-1.425];
                OP = 2; L = 2;
            case 11 %Ackley's
                Opt1 = zeros(dim,1);
                OP = 1; L = 5;
            case 12 %Himmelblau's
                Opt1 = [3.0,2.0];
                Opt2 = [-2.805,3.131];
                Opt3 = [-3.779,-3.283];
                Opt4 = [3.584,-1.848];
                OP = 4; L = 5;
            case 13 %Double-Sphere
                Opt1 = 2.5*ones(dim,1);
                Opt2 = -2.5*ones(dim,1);
                OP = 2; L = 5;
            case 14 %Triple-Sphere
                Opt1 = 2.5*ones(dim,1);
                Opt2 = -2.5*ones(dim,1);
                Opt3 = zeros(dim,1);
                OP = 3; L = 5;
            case 15 %Quadruple-Sphere
                A = zeros(dim,1);
                A(1:2:dim) =  2.5;
                A(2:2:dim) = -2.5;
                Opt1 = 2.5*ones(dim,1);
                Opt2 = -2.5*ones(dim,1);
                Opt3 = A;
                Opt4 = -A;
                OP = 4; L = 5;
            case 16 %Quintuple-Sphere
                A = zeros(dim,1);
                A(1:2:dim) =  2.5;
                A(2:2:dim) = -2.5;
                Opt1 = 2.5*ones(dim,1);
                Opt2 = -2.5*ones(dim,1);
                Opt3 = A;
                Opt4 = -A;
                Opt5 = zeros(dim,1);
                OP = 5; L = 5;
    end
end

