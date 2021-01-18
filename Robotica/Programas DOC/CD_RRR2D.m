function [R, T] = CD_RRR2D(THT,a1,a2,a3)
N = length(THT(:,1));

R = cell(1,N);
T = cell(N,3);

for k = 1:N
  t1 = THT(k,1);
  t2 = THT(k,2);
  t3 = THT(k,3);
  
  R{k} = DH(a1,0,0,t1)*DH(a2,0,0,t2)*DH(a3,0,0,t3);
  
  T{k,1} = DH(a1,0,0,t1);
  T{k,2} = DH(a1,0,0,t1)*DH(a2,0,0,t2);
  T{k,3} = DH(a1,0,0,t1)*DH(a2,0,0,t2)*DH(a3,0,0,t3);
end


