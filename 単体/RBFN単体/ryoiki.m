%%%%%%%%%%%%—Ìˆæ–ß‚µ%%%%%%%%%%%%%%%%%
q=[];
q=samp_ten_add;
for i=1:samp_kazu_add

    if q(i,1)+q(i,3)+q(i,5)==7.5
        q(i,1)=2.49;
        
    end
    if q(i,2)==0
        q(i,2)=0.1;
    end
    sei=2.5;
    while q(i,1)+q(i,3)+q(i,5)+5 <q(i,7)+q(i,9)+q(i,11)+q(i,13)
        if q(i,7) >sei
            q(i,7)=sei;
        elseif q(i,9) >sei
            q(i,9)=sei;
        elseif q(i,11) >sei
            q(i,11)=sei;
        elseif q(i,13) >sei
            q(i,13)=sei;
        end
        sei=sei-0.1;
    end
end
samp_ten_add=q;