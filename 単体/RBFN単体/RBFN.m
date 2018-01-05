
%%%%%%%%%%%%%%%%%%%%%%パラメータ設定開始%%%%%%%%%%%%%%%%%%%%%%%%
samp_hyoukati_max=max(samp_hyoukati);
for h=1:samp_kazu
    y_rbf(h,1)=samp_hyoukati(h,1)-samp_hyoukati_max;
end
%%%%%%%%%%%%%%%%%%%%%パラメータ設定の終了%%%%%%%%%%%%%%%%%%%%%%%%%
H=zeros(samp_kazu,samp_kazu);                                   %H行列の初期化

%fprintf('******* RBFN開始 *******************\n')
%%%%%%%%%%%%% サンプル点間最大距離の計算開始 %%%%%%%%%%%%%%
d_max=0;                                                        %サンプル点間の最大距離の初期化
samp_kyori=0;                                                   %サンプル点間の各距離の行列の初期化
for j=1:samp_kazu-1
    for j1=j+1:samp_kazu
        samp_kyori(j1-1,j)=sum((seikiten(j,:)-seikiten(j1,:)).^2);
    end
end
samp_kyori;                                                      %サンプル点同士の距離の集合
d_max=sqrt(max(max((samp_kyori))));                             %サンプル点間の最大距離
%%%%%%%%%%%%%　サンプル点間最大距離の計算終了　%%%%%%%%%%%%%%
%%%%%%%%%%%%%　基底関数半径ｒの計算開始　%%%%%%%%%%%%%%
if dimension==2
    r=d_max/(sqrt(samp_kazu*dimension)^(1/dimension));
else
    r=d_max/(sqrt(dimension)*(sqrt(samp_kazu)^(1/dimension)));
end
if r==0
    r=0.5;
end
%%%%%%%%%%%%%　基底関数半径ｒの計算終了　%%%%%%%%%%%%%%
%%%%%%%%%%%%%　基底関数計算開始　%%%%%%%%%%%%%%
for j=1:samp_kazu
    for j1=1:samp_kazu
        H(j,j1)=sum((seikiten(j,:)-seikiten(j1,:)).^2);
        H(j,j1)=exp(-H(j,j1)/(r.^2));
    end
end
%%%%%%%%%%%%%%%　基底関数計算終了　%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%　ωの計算開始　%%%%%%%%%%%%%%
ramuda=10.^(-2);                                               %ラムダの設定
G_ramuda=ramuda.*eye(samp_kazu,samp_kazu);                     %ラムダの行列
A=H'*H+G_ramuda;
omega=inv(A)*H'*y_rbf;                                            %重み値ωの設定
%%%%%%%%%%%%%%%　ωの計算終了　%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%　出力関数O(x)　%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%　出力関数O(x)　%%%%%%%%%%%%%%
%fprintf('******* RBFN終了 *******************\n')