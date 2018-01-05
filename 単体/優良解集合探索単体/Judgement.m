function SUM = Judgement(th, Opt1, x, m, C)
    switch C
        case {8,10,13}
            answer = zeros(1,2);
            for i = 1:m
                if abs(x(:,i)-Opt1) < th
                    answer(1,1) = 1;
                elseif abs(x(:,i)-Opt2) < th
                    answer(1,2) = 1;
                end
            end
        otherwise
            answer = 0;
            for i = 1:m
                if abs(x(:,i)-Opt1) < th
                    answer = 1;
                end
            end
        SUM = sum(answer);
    end
end

