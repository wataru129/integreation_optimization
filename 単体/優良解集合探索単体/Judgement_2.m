
function SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C)
    switch C
        case {8,10,13}
        answer = zeros(1,2);
        for i = 1:m
            if abs(x(:,i)-Opt1) < th
                answer(1,1) = 1;
            elseif abs(x(:,i)-Opt2) < th
                answer(1,2) = 1;
            else
            end
        end
        case {9,14}
        answer = zeros(1,3);
        for i = 1:m
            if abs(x(:,i)-Opt1) < th
                answer(1,1) = 1;
            elseif abs(x(:,i)-Opt2) < th
                answer(1,2) = 1;
            elseif abs(x(:,i)-Opt3) < th
                answer(1,3) = 1;
            else
            end
        end
        case {12,15}
        answer = zeros(1,4);
        for i = 1:m
            if abs(x(:,i)-Opt1) < th
                answer(1,1) = 1;
            elseif abs(x(:,i)-Opt2) < th
                answer(1,2) = 1;
            elseif abs(x(:,i)-Opt3) < th
                answer(1,3) = 1;
            elseif abs(x(:,i)-Opt4) < th
                answer(1,4) = 1;
            else
            end
        end
        case 16
        answer = zeros(1,5);
        for i = 1:m
            if abs(x(:,i)-Opt1) < th
                answer(1,1) = 1;
            elseif abs(x(:,i)-Opt2) < th
                answer(1,2) = 1;
            elseif abs(x(:,i)-Opt3) < th
                answer(1,3) = 1;
            elseif abs(x(:,i)-Opt4) < th
                answer(1,4) = 1;
            elseif abs(x(:,i)-Opt5) < th
                answer(1,5) = 1;
            else
            end
        end
        otherwise
        answer = 0;
        for i = 1:m
            if abs(x(:,i)-Opt1) < th
                answer = 1;
            else
            end
        end
    end
    SUM = sum(answer);
end

