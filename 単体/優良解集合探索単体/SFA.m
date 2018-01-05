%Split Firefly Algorithm�i��Ď�@�j
clear all;
load InitialPoints_300_100_100
global dim; global C; global hyouka;
disp('Split Firefly Algorithm')
%%Step 0�F����%%
th = 0.1;%���I�œK�𔭌��̂��߂�臒l
kmax = 500;
Tmax = 10;%�ő唽���񐔁C���s��
m = 20; %�T���_��
dim=2;
beta0 = 1.0; delta = 1.0; alpha0 = 0.1; %alpha0 = 0.1;%�e�p�����[�^
line = 1; Gbest = zeros(Tmax,1); %���O���蓖��
C = 13;
gamma = 0.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for gamma0 = [0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
gamma0 =1.0;
[Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT2(dim);
for Trial = 1:Tmax    %���s��
    disp(Trial);
plotx = zeros(dim,m,kmax);
%%%%%%%%%%%%%%%%Step 1�F������%%%%%%%%%%%%%%%%
    [gbest,fx,fgbest,x] = Initial(m,Trial,L,IP); %������
    hyouka = 0;
    GBEST = zeros(kmax+1,1);
    for k = 1:kmax
        plotx(:,:,k) =x;
        x_hat = x;
        alpha = alpha0*delta^k;
%%%%%%%%%%%%%%%%%%%%%Step 2�F�T���_�̈ړ�%%%%%%%%%%%%%%%%%%%%%
        x = Movement_SFA(x,x_hat,alpha,m,dim,beta0,fx,gamma,gamma0); %�T���_�̈ړ�
%%%%%%%%%%%%%%%%%%%%%Step 3�F�T���_�̍X�V%%%%%%%%%%%%%%%%%%%%%
        for i=1:m
            fx(i) = Calculate_value(x(:,i)); %���̕]��
        end
                %gbest�̕ۑ�
        [fgbestnew,number] = min(fx);
        if fgbestnew < fgbest
            fgbest = fgbestnew;
            gbest = x(:,number);
        end
        GBEST(k+1) = fgbest;
        Gbest(Trial,1) = fgbest;
        SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C); %�D�ǉ𔭌��̔���
        PR_hozon(line,Trial) = SUM;
    end
    Results(:,line) = [max(PR_hozon(line,:)),min(PR_hozon(line,:)),mean(PR_hozon(line,:)),std(PR_hozon(line,:))]';
    line = line + 1;
end

heikin  = mean2(Gbest)
nice    = min(Gbest)
bad     = max(Gbest)
hennsa  = std(Gbest)

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%FIGURE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=linspace(-5,5);
x2=linspace(-5,5);
[X1,X2]=meshgrid(x1,x2);
Z=zeros(100,100);
for i = 1:100
    for j =1:100
        n= [X1(1,j),X2(i,1)].';
        fsph1 = sum((n-2.5).^2);
        fsph2 = sum((n+2.5).^2);
        Z(j,i) = Z(j,i)+ min(fsph1,fsph2);
    end
end
figure(1);contour(X1,X2,Z,60);
figure(2);contour(X1,X2,Z,60);
figure(3);contour(X1,X2,Z,60);
figure(4);contour(X1,X2,Z,60);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
axis square;
%colormap gray
hold on
scatter(plotx(1,:,50),plotx(2,:,1));
set(0,'DefaultTextInterpreter','latex');
        xlim([-5 5]);
        ylim([-5 5]);


figure(2);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
axis square;
%colormap gray
hold on
scatter(plotx(1,:,50),plotx(2,:,50));
set(0,'DefaultTextInterpreter','latex');
        xlim([-5 5]);
        ylim([-5 5]);


figure(3);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
axis square;
%colormap gray
hold on
scatter(plotx(1,:,50),plotx(2,:,100));
set(0,'DefaultTextInterpreter','latex');
        xlim([-5 5]);
        ylim([-5 5]);


figure(4);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
axis square;
%colormap gray
hold on
scatter(plotx(1,:,50),plotx(2,:,500));
set(0,'DefaultTextInterpreter','latex');
        xlim([-5 5]);
        ylim([-5 5]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}
%}