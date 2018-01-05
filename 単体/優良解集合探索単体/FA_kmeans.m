%Firefly Algorithm
tic
clear all;
load InitialPoints_300_100_100
global n; global C; global hyouka;
global claster_number;
disp('Firefly Algorithm')
%%Step 0：準備%%
th = 0.5;%大域的最適解発見のための閾値
kmax = 500; Tmax = 1;%最大反復回数，試行回数
m = 200; %探索点数
beta0 = 1.0; delta = 1.0; alpha0 = 0.1;%各パラメータ
line = 1; Gbest = zeros(Tmax,1); %事前割り当て
Gamma = zeros(1,kmax);
claster_number = 4;
C = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for c = [5,6,7,8,9]
    for n = [5,10,15]
        [Opt1, Opt2, Opt3, Opt4, Opt5, OP, L, L1, L2] = OPT(n);
        hyouka = 0;
    for Trial = 1:Tmax    %試行回数
%%%%%%%%%%%%%%%%Step 1：初期化%%%%%%%%%%%%%%%%
            [gbest,fx,fgbest,x] = Initial( m,Trial,L,IP); %初期化
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
    %%%%%%%%%%%%%%%%%%%%%Step 2：評価値によるランキング%%%%%%%%%%%%%%%%%%%%%
                [I, SORT] = sort(I); %評価値によるランキング
                x = x(SORT,:); xo = xo(SORT,:); D_min = D_min(SORT);
    %%%%%%%%%%%%%%%%%%%%%Step 3：探索点の移動%%%%%%%%%%%%%%%%%%%%%
                [x,Gamma] = Movement_FA_kmeans( x,xo,alpha,m,n,I,beta0,D_min,k,Gamma,c );%探索点の移動
    %%%%%%%%%%%%%%%%%%%%%Step 4：探索点の更新%%%%%%%%%%%%%%%%%%%%%    
                fx = Evaluation( x,m ); %解の評価
                I = -fx; %光強度の保存

                %gbestの保存
                [fgbestnew,number] = min(fx);
                if fgbestnew < fgbest
                    fgbest = fgbestnew;
                    gbest = x(number,:);
                else
                end
                GBEST(1,k+1) = fgbest;
        %         x=Area( x,n,m,L ); %実行可能領域内に探索点を入れ込む
%             [ BGSS, WGSS, VRC ] = Calinski_Harabasz( x,m,Center,Group,count );
%             WGSS_k(k) = WGSS;
%             BGSS_k(k) = BGSS;
            end
        Gbest(Trial,1) = fgbest;
        SUM = Judgement(th, Opt1, Opt2, Opt3, Opt4, Opt5, x, m, C); %優良解発見の判定
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