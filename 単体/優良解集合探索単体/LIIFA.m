%Firefly Algorithm
clear all;
load InitialPoints_300_100_100
global dim; global C; global hyouka;
%%Step 0 prepare
th = 0.1;
kmax = 500;
Tmax = 10;
C = 3;  % The number of target
dim = 2; %dimension
m = 20; %The number of particle
beta0 = 1.0; delta = 1.0; alpha0 = 0.1; gamma = 1.0; %FA parameters
line = 1; Gbest = zeros(Tmax,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Opt1, OP, L] = OPT(dim); %Decide target problem
for Trial = 1:Tmax
%%%%%%%%%%%%%%%%Step 1%%%%%%%%%%%%%%%%
    [gbest,fx,fgbest,x] = Initial(m,Trial,L,IP); %������
    I = -fx;
    GBEST = zeros(1,kmax+1);
    for k = 1:kmax
        x_hat = x;
        alpha = alpha0 * delta^k;
    %%%%%%%%%%%%%%%%%%%%%Step 2 sort decend%%%%%%%%%%%%%%%%%%%%%
                [I, SORT] = sort(I);
                x = x(:,SORT);
                x_hat = x_hat(:,SORT);
    %%%%%%%%%%%%%%%%%%%%%Step 3�F�T���_�̈ړ�%%%%%%%%%%%%%%%%%%%%%
                x = Movement_FA(x,x_hat,gamma,alpha,m,dim,I,beta0 ); %
    %%%%%%%%%%%%%%%%%%%%%Step 4�F�T���_�̍X�V%%%%%%%%%%%%%%%%%%%%%
                for i = 1:m
                    fx(i) = Calculate_value(x(:,i));
                end
                %fx = Evaluation(x,m); %���̕��
                I = -fx;
                [fgbestnew,number] = min(fx);
                if fgbestnew < fgbest
                    fgbest = fgbestnew;
                    gbest = x(:,number);
                end
                GBEST(k+1) = fgbest;
        Gbest(Trial) = fgbest;
        SUM = Judgement(th, Opt1, x, m, C); %�D�ǉ𔭌��̔���
        PR_hozon(line,Trial) = SUM;
    end
            Results(:,line) = [max(PR_hozon(line,:)),min(PR_hozon(line,:)),mean(PR_hozon(line,:)),std(PR_hozon(line,:))]';
    line = line + 1;
end
