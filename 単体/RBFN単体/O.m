%RBFN‚Ìo—ÍŠÖ”FO(x)
function out=O(x,omega,seikiten)
global sample_num r

out=zeros(size(x,1),1);
for i=1:size(x,1)
    for k1=1:sample_num
        out(i)=out(i)+omega(k1,1)*exp(- sum((x(i,:)-seikiten(k1,:)).^2) / (r^2));
    end
end
