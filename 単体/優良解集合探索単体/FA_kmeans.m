%Firefly Algorithm
tic
clear all;
load InitialPoints_300_100_100
global n; global C; global hyouka;
global claster_number;
disp('Firefly Algorithm')
%%Step 0�F����%%
th = 0.5;%���I�œK�𔭌��̂��߂�臒l
kmax = 500; Tmax = 1;%�ő唽���񐔁C���s��
m = 200; %�T���_��
beta0 = 1.0; delta = 1.0; alpha0 = 0.1;%�e�p�����[�^
line = 1; Gbest = zeros(Tmax,1); %���O���蓖��
Gamma = zeros(1,kmax);
claster_number = 4;
C = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for c = [5,6,7,8,9]
    for n = [5,10,15]
        [Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT(n);
        hyouka = 0;
    for Trial = 1:Tmax    %���s��
%%%%%%%%%%%%%%%%Step 1�F������%%%%%%%%%%%%%%%%
            [gbest,fx,fgbest,x] = Initial( m,Trial,L,IP); %������
            I = -fx;
            GBEST = zeros(1,kmax+1);
            for k = 1:kmax
                [D_min,Center,Group,count] = k_means( m,x );
%                 A = Anime( x,L,L1,L2,Opt1,Opt2,Opt3,Opt4,Opt5);
%                     if k==kmax
%                         A = Anime2( x,L,L1,L2,Opt1,Opt2,Opt3,Opt4,Opt5 );
%                     end
                xo = x;
                alpha = alpha0*delta^k;
    %%%%%%%%%%%%%%%%%%%%%Step 2�F�]���l�ɂ�郉���L���O%%%%%%%%%%%%%%%%%%%%%
                [I, SORT] = sort(I); %�]���l�ɂ�郉���L���O
                x = x(SORT,:); xo = xo(SORT,:); D_min = D_min(SORT);
    %%%%%%%%%%%%%%%%%%%%%Step 3�F�T���_�̈ړ�%%%%%%%%%%%%%%%%%%%%%
                [x,Gamma] = Movement_FA_kmeans( x,xo,alpha,m,n,I,beta0,D_min,k,Gamma,c );%�T���_�̈ړ�
    %%%%%%%%%%%%%%%%%%%%%Step 4�F�T���_�̍X�V%%%%%%%%%%%%%%%%%%%%%    
                fx = Evaluation( x,m ); %���̕]��
                I = -fx; %�����x�̕ۑ�

                %gbest�̕ۑ�
                [fgbestnew,number] = min(fx);
                if fgbestnew < fgbest
                    fgbest = fgbestnew;
                    gbest = x(number,:);
                else
                end
                GBEST(1,k+1) = fgbest;
        %         x=Area( x,n,m,L ); %���s�\�̈���ɒT���_����ꍞ��
%             [ BGSS, WGSS, VRC ] = Calinski_Harabasz( x,m,Center,Group,count );
%             WGSS_k(k) = WGSS;
%             BGSS_k(k) = BGSS;
            end
        Gbest(Trial,1) = fgbest;
        SUM = Judgement(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C); %�D�ǉ𔭌��̔���
%         SUM = New_Judgement(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C);
        PR_hozon(line,Trial) = SUM;
    end
            Results(:,line) = [max(PR_hozon(line,:)),min(PR_hozon(line,:)),mean(PR_hozon(line,:)),std(PR_hozon(line,:))]';
            line = line + 1;
    end
end
%     Gamma = Gamma/(m-1);
%     plot(Gamma)
%     ylim([0,10])
    %     ax1 = subplot(2,1,1);
%     hold(ax1,'on')
%     plot(WGSS_k)
%     xlabel('$k$','FontSize',15,'Fontname','Times','interpreter','latex')
%     ylabel('WGSS','FontSize',15,'Fontname','Times','interpreter','latex')
%     ax2 = subplot(2,1,2);
%     hold(ax1,'off')
%     hold(ax2,'on')
%     plot(BGSS_k)
%     xlabel('$k$','FontSize',15,'Fontname','Times','interpreter','latex')
%     ylabel('BGSS','FontSize',15,'Fontname','Times','interpreter','latex')
%     hold(ax2,'off')
% xlswrite('Results',Results);
toc