%Firefly Algorithm
clear all;
load InitialPoints_300_100_100
global dim; global C; global hyouka;
%%Step 0 prepare
th = 0.1;
kmax = 500;
Tmax = 10;
C = 13;  % The number of target
dim = 2; %dimension
m = 20; %The number of particle
beta0 = 1.0; delta = 1.0; alpha0 = 0.1; gamma = 1.0; gamma0=1.0; %FA parameters
line = 1; Gbest = zeros(Tmax,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[Opt1, OP, L] = OPT(dim); %Decide target problem
[Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT2(dim);
for Trial = 1:Tmax
    disp(Trial);
plotx = zeros(dim,m,kmax);
%%%%%%%%%%%%%%%%Step 1%%%%%%%%%%%%%%%%
    [gbest,fx,fgbest,x] = Initial(m,Trial,L,IP); %?Ω?Ω?Ω?Ω?Ω?Ω
    I = -fx;
    GBEST = zeros(1,kmax+1);
    for k = 1:kmax
        plotx(:,:,k) =x;
        x_hat = x;
        alpha = alpha0 * delta^k;
    %%%%%%%%%%%%%%%%%%%%%Step 2 sort decend%%%%%%%%%%%%%%%%%%%%%
                [I, SORT] = sort(I);
                x = x(:,SORT);
                x_hat = x_hat(:,SORT);
    %%%%%%%%%%%%%%%%%%%%%Step 3?ΩF?ΩT?Ω?Ω?Ω_?ΩÃà⁄ìÔøΩ%%%%%%%%%%%%%%%%%%%%%
                x = Movement_FA(x,x_hat,gamma,alpha,m,dim,I,beta0); %
    %%%%%%%%%%%%%%%%%%%%%Step 4?ΩF?ΩT?Ω?Ω?Ω_?ΩÃçX?ΩV%%%%%%%%%%%%%%%%%%%%%
                for i = 1:m
                    fx(i) = Calculate_value(x(:,i));
                end
                I = -fx;
                [fgbestnew,number] = min(fx);
                if fgbestnew < fgbest
                    fgbest = fgbestnew;
                    gbest = x(:,number);
                end
                GBEST(k+1) = fgbest;
        Gbest(Trial) = fgbest;
%        SUM = Judgement(th, Opt1, x, m, C); %?ΩD?Ω«âî≠åÔøΩ?ΩÃîÔøΩ?Ω?Ω
        SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C); %ÂÑ™ËâØËß£Áô∫Ë¶ã„?Âà§ÂÆ?
        PR_hozon(line,Trial) = SUM;
    end
            Results(:,line) = [max(PR_hozon(line,:)),min(PR_hozon(line,:)),mean(PR_hozon(line,:)),std(PR_hozon(line,:))]';
    line = line + 1;
end

heikin  = mean2(Gbest)
nice    = min(Gbest)
bad     = max(Gbest)
hennsa  = std(Gbest)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%FIGURE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}