
clear
global C;
load InitialPoints_300_100_100
C=13;
Trial=10;
clusta =5;
th=1;
%%%PSO-parameter%%%%%%%
%w   = 0.729;
%w   = 0.7;
c1  = 1.4955;
c2  = 1.4955;
%%%%%%%%%%%%%%%%%%%%%%
%%%PSO-Algolism%%%%%
n       = 10;   %dimension
m       = 300;   %The number of Particle
k_max   = 1000;  % Max of reiteration
[Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT2(n);
for T = 1:Trial
    x_init          = 5*IP(1:m,1:n,T).';
    v_init          = IP(1:m,1:n,T).';
    idx             = kmeans(x_init.',clusta);
    for c_index=1:clusta
        ct             = 1;
        class(c_index) = size(find(idx == c_index),1);
        x              = zeros(n,class(c_index));
        v              = zeros(n,class(c_index));
        for i=1:class(c_index)
            if idx(i)==c_index
                x(:,ct)= x_init(:,i);
                v(:,ct)= v_init(:,i);
                ct     = ct + 1;
            end
        end
        pbest   = x;
        fpbest=zeros(1,m);
        gbest=pbest(:,1);
        fgbest  = Calculate_value(gbest);
        for i=1:class(c_index)
            fpbest(i)=Calculate_value(pbest(:,i));
            if fpbest(i)<fgbest
                gbest=pbest(:,i);
                fgbest=fpbest(i);
            end
        end
        for k=1:k_max
            w=1/(8*k)+0.7;
            temp_fpbest=zeros(1,m);
            for i=1:class(c_index)
                v(:,i)=w*v(:,i)+c1*rand*(pbest(:,i)-x(:,i))+c2*rand*(gbest-x(:,i));
                x(:,i)=x(:,i)+v(:,i);
%%%Step 3%%%%pbest,gbest[update]
                temp_fpbest(i)=Calculate_value(x(:,i));
                if(temp_fpbest(i)<fpbest(i))
                    pbest(:,i)=x(:,i);
                    fpbest(i) = temp_fpbest(i);
                    if fpbest(i)<fgbest
                        gbest=pbest(:,i);
                        fgbest=fpbest(i);
                    end
                end
            end
        end
        answer(:,c_index,T)=gbest;
    end
    SUM = Judgement_2(th, Opt1, Opt2, Opt3, Opt4, Opt5, answer(:,:,T), clusta, C);
    result(T) = SUM;
end



















%{

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%FIGURE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=linspace(-5,5);
x2=linspace(-5,5);
[X1,X2]=meshgrid(x1,x2);

if C ==3
    Z=(X1.^4-16*X1.^2+5*X1)+(X2.^4-16*X2.^2+5*X2);
elseif C==4
    Z=(X1.^2-10*cos(2*pi*X1)+10)+(X2.^2-10*cos(2*pi*X2)+10);
elseif C==13
    Z=zeros(100,100);
    for i = 1:100
        for j =1:100
            n= [X1(1,j),X2(i,1)].';
            fsph1 = sum((n-2.5).^2);
            fsph2 = sum((n+2.5).^2);
            Z(j,i) = Z(j,i)+ min(fsph1,fsph2);
        end
      end
end
%figure(1);contour(X1,X2,Z,60);
%figure(2);contour(X1,X2,Z,60);
%figure(3);contour(X1,X2,Z,60);
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
scatter(plotx(1,:,1),plotx(2,:,1));
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
scatter(plotx(1,:,10),plotx(2,:,10));
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
scatter(plotx(1,:,30),plotx(2,:,30));
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
scatter(plotx(1,:,k_max),plotx(2,:,k_max));
set(0,'DefaultTextInterpreter','latex');
        xlim([-5 5]);
        ylim([-5 5]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}