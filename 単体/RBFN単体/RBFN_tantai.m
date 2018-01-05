clear
tic                                                            %タイマ�?スター�?
global r R dimension sample_num h ra

load InitialPoints_300_100_100
load Initial_sample_10000_100_100
%syokipoint=sample_RANDOM_X;
syokipoint=IP;
%%%%%%%%%%%%%%%%%%%%%%Parameter setting%%%%%%%%%%%%%%%%%%%%%%%
dimension=2;                                                   %次�?��
sample_syoki=300;                                                 %初期サンプル点数
sample_num=sample_syoki;                                          %サンプル点の数
ramuda=10.^(-2)*eye(sample_num,sample_num);
upper_limit     = 5;
H=zeros(sample_num,sample_num);
d_max=0;

%%%%%% setting initial point %%%%%&%%%
rbf_mid=syokipoint(1:sample_num,1:dimension,1).';


%Create rbf midle and teaching data
for i = 1:sample_num
    for j = 1:dimension
        rbf_mid(j,i) = upper_limit*rbf_mid(j,i);
    end
end

for h=1:sample_num
    teaching_value(h)=func(rbf_mid(:,h));
end
%{
teaching_value_max=max(teaching_value);
for h=1:sample_num
    y_rbf(h)=teaching_value(h)-teaching_value_max;
end
%}

%%%%%%%%%%%%%%%%%%%%%% RBFN main program  %%%%%%%%%%%%%%%%%%%%%%%
%caluculate_dmax
for j = 1:sample_num
    for j1=j+1:sample_num
        sample_distance(j,j1-1)=sum((rbf_mid(:,j)-rbf_mid(:,j1)).^2);
    end
end

d_max=sqrt(max(max((sample_distance))));

%make r
r=d_max/(sqrt(sample_num*dimension)^(1/dimension));
if r==0
    r=0.5;
end

%make H

for j=1:sample_num
    for j1=1:sample_num
        H(j,j1)=exp(-(sum((rbf_mid(:,j)-rbf_mid(:,j1)).^2))/(r.^2));
    end
end


A=H'*H+ramuda;
A_inv =inv(A);
omega=inv(A)*H'*teaching_value.';                                            %重み値ω�?設�?





fprintf('*******Create Graph *******************\n')
x1=linspace(-5,5)';
x2=linspace(-5,5)';
[X1,X2]=meshgrid(x1,x2);


Z=zeros(100,100);
for i = 1:100
    for j =1:100
        for k1=1:sample_num
            n= [X1(1,j),X2(i,1)].';
            Z(j,i) = Z(j,i) + omega(k1) * ...
            exp(- sum((n - rbf_mid(:,k1)).^2) / (r^2));
        end
    end
end


figure(1);surf(X1,X2,Z);
figure(1);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',16,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',18);
ylabel('$x_2$','Fontsize',18);
zlabel('$f(\mbox{\boldmath $x$})$','Fontsize',16);



%Z(i,j) = Z(i,j) + omega(k1,1) *exp(- sum((n - rbf_mid(k1,1)).^2) / (r^2));


%{
for j=1:sample_num
    for i=1
    n= [X1(j),X2(i)]
    hx(j)=exp(- (n(1,:)-rbf_mid(j,:).'*(n(1,:)-rbf_mid(j,:))) / (r^2))
    Z=omega*hx(j)
end
%}



%{
x1=linspace(-2,2);
x2=linspace(-2,2);
[X1,X2]=meshgrid(x1,x2);
Z=X1.^2+X2.^2;
figure(1);surf(X1,X2,Z);
%}