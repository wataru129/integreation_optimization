clear
global C;
load InitialPoints_300_100_100

C=13;
Trial=10;


%%%PSO-parameter%%%%%%%
if C==3
    w   = 0.6;
elseif C== 4
    w   = 0.6;
else
    w   = 0.729;
end
%w   = 0.729;
c1  = 1.4955;
c2  = 1.4955;
%%%%%%%%%%%%%%%%%%%%%%
%%%PSO-Algolism%%%%%
%%%Step 0%%%Prepare
n       = 10;   %dimension
m       = 200;   %The number of Particle
k_max   = 500;  % Max of reiteration
class_suii=zeros(3,Trial);
dist_suii=zeros(3,Trial);
result_suii=zeros(3,Trial);
for T = 1:Trial
%%%Step 1%%%%Reset of initial value
x       = 5*IP(1:m,1:n,T).';    %initial point r2=(|r1|+|r2|)/2
v       = IP(1:m,1:n,T).';       %initial velocity
plotx=zeros(size(x,1),size(x,2),k_max);
%%%%Clustring%%%%%%%%%%%%%%%%%%
idx =kmeans(x.',3);
for i=1:3
    class(i)=size(find(idx==i),1);
end
class_suii(:,T)=class;
ct =ones(4);
x_a = zeros(n,class(1));
x_b = zeros(n,class(2));
x_c = zeros(n,class(3));
v_a = zeros(n,class(1));
v_b = zeros(n,class(2));
v_c = zeros(n,class(3));

for i=1:m
    if idx(i)==1
      x_a(:,ct(1))=x(:,i);
      v_a(:,ct(1))=v(:,i);
      ct(1) = ct(1) + 1;
    elseif idx(i)==2
      x_b(:,ct(2))=x(:,i);
      v_b(:,ct(2))=v(:,i);
      ct(2) = ct(2) + 1;
    else
      x_c(:,ct(3))=x(:,i);
      v_c(:,ct(3))=v(:,i);
      ct(3) = ct(3) + 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Step 2%%%%x,v[update]
x =[x_a x_b x_c];
v =[v_a v_b v_c];
pbest   = x;
fpbest=zeros(1,m);
gbest_a=pbest(:,1);
gbest_b=pbest(:,class(1)+1);
gbest_c=pbest(:,class(1)+class(2)+1);
fgbest_a  = Calculate_value(gbest_a);
fgbest_b  = Calculate_value(gbest_b);
fgbest_c  = Calculate_value(gbest_c);
for i=1:m
    fpbest(i)=Calculate_value(pbest(:,i));
    if idx(i) ==1
        if fpbest(i)<fgbest_a
            gbest_a=pbest(:,i);
            fgbest_a=fpbest(i);
        end
    elseif idx(i) ==2
        if fpbest(i)<fgbest_b
            gbest_b=pbest(:,i);
            fgbest_b=fpbest(i);
        end
    else
        if fpbest(i)<fgbest_c
            gbest_c=pbest(:,i);
            fgbest_c=fpbest(i);
        end
    end
end
%%%Step 2%%%%x_p,v_p[update]
for k=1:k_max
plotx(:,:,k) = x;
    temp_fpbest=zeros(1,m);
    for i=1:m
        if idx(i) ==1
            gbest=gbest_a;
        elseif idx(i) ==2
            gbest=gbest_b;
        else
            gbest=gbest_c;
        end
        v(:,i)=w*v(:,i)+c1*rand*(pbest(:,i)-x(:,i))+c2*rand*(gbest-x(:,i));
        x(:,i)=x(:,i)+v(:,i);
%%%Step 3%%%%pbest,gbest[update]
        temp_fpbest(i)=Calculate_value(x(:,i));
        if(temp_fpbest(i)<fpbest(i))
            pbest(:,i)=x(:,i);
            fpbest(i) = temp_fpbest(i);
            if idx(i) ==1
                if fpbest(i)<fgbest_a
                    gbest_a=pbest(:,i);
                    fgbest_a=fpbest(i);
                end
            elseif idx(i) ==2
                if fpbest(i)<fgbest_b
                    gbest_b=pbest(:,i);
                    fgbest_b=fpbest(i);
                end
            else
                if fpbest(i)<fgbest_c
                    gbest_c=pbest(:,i);
                    fgbest_c=fpbest(i);
                end
            end
        end
    end
end
dist(1)=sum((gbest_a-gbest_b).^2);
dist(2)=sum((gbest_a-gbest_c).^2);
dist(3)=sum((gbest_b-gbest_c).^2);

dist_suii(:,T) = dist;
resurt(1,T)=fgbest_a;
resurt(2,T)=fgbest_b;
resurt(3,T)=fgbest_c;
answer(:,1,T)=gbest_a;
answer(:,2,T)=gbest_b;
answer(:,3,T)=gbest_c;
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