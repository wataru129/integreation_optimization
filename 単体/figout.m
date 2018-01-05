function figout
%figure:�摜�o�͊֐�


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�œK���[�~��5��@%�����
%��3��ō쐬�ς�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Defult
global f_number;     %�ۑ�ԍ��I��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_number=7;
%�Ώۖ��
switch f_number
    case 1 %%%�Ώ�1%%%
        x1=linspace(-5,5);
        x2=linspace(-5,5);
        [X1,X2]=meshgrid(x1,x2);
        Z=X1.^2+X2.^2;
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z);
    case 2 %%%�Ώ�2%%%
        x1=linspace(-2,2);
        x2=linspace(-2,2);
        [X1,X2]=meshgrid(x1,x2);
        Z=100*((X1.^2-X2).^2)+(1-X1).^2;
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,50);
    case 3 %%%�Ώ�3%%%
        x1=linspace(-5,5);
        x2=linspace(-5,5);
        [X1,X2]=meshgrid(x1,x2);
        Z=(X1.^4-16*X1.^2+5*X1)+(X2.^4-16*X2.^2+5*X2);
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,20);
    case 4 %%%�Ώ�4%%%      
        x1=linspace(-5,5);
        x2=linspace(-5,5);
        [X1,X2]=meshgrid(x1,x2);
        Z=(X1.^2-10*cos(2*pi*X1)+10)+(X2.^2-10*cos(2*pi*X2)+10);
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,6);
    case 5 %%%�Ώ�5%%%
        x1=linspace(-100,100);
        x2=linspace(-100,100);
        [X1,X2]=meshgrid(x1,x2);
        Z=X1.^2+(X1+X2).^2;
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,30);
    case 6 %%%�Ώ�%%%
        x1=linspace(-100,100);
        x2=linspace(-100,100);
        [X1,X2]=meshgrid(x1,x2);
        Z=X1.^2+(X1*X2)+8*X2.^2;
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,30);
    case 7
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
        figure(1);surf(X1,X2,Z);
        figure(2);contour(X1,X2,Z,60);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
zlabel('$f(\mbox{\boldmath $x$})$','Fontsize',32);
%colormap bone

figure(2);
set(0,'DefaultTextInterpreter','latex');
set(gca,'Fontsize',32,'FontName','Times New Roman');
xlabel('$x_1$','Fontsize',34);
ylabel('$x_2$','Fontsize',34);
axis square;
%colormap gray
end