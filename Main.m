clc
clear all
f =imread('cameraman.tif');
f=double(f);
[M,N]=size(f);
U=1;  % Level of decomposition
L = max(M, N);
NN=L;
l = L;
%g = 2;
g=2+3*(U-1);
f =imresize(f,[L,L]);
F=twodfbse(f);
%F1=twodinvfbse(F);


a=2;
b=2;
c=2;
d=2;
for i = 1: U
   [LPF , HPF , w0, w1, w2, w3]=filterdesign(L, a, b, c, d, l);
   L=ceil(w0);
   G{1, 1} = LPF;
   G{2, 1} = HPF;
       for j = 1: 2
            C=repmat(G{j, 1}, NN, 1);
            subrow=C.*F;
              for s = 1 : 2
                 D=repmat(G{s, 1}, NN, 1)';
                 if j == 1 && s == 1
                   Y=D.*subrow;
                   F=Y;
                 else
                 SBI{g}=twodinvfbse(D.*subrow);
                 g=g+1;
                 end
              end
       end
       if U>1
           g=g-6;
       end
       F = Y;
end
SBI{1}=twodinvfbse(Y);

function [LPF , HPF , w0, w1, w2, w3]=filterdesign(L, a, b, c, d, l)
  beta = c/d;
  eta = (1/32)*((a-b)+(beta*b))/(a + b)*L;
  w0 = ((1-beta)*L) + eta;
  w1 = (a*L)/b; 
  w2 = (L-eta);
  w3 = (L+eta);

  if w3>=l
     w3=l;
  else 
     w3=w3;
  end
  LPF=zeros(1,l);
  w = 1:l;
  LPF (1:ceil(w0))=ones(1,ceil(w0));
  p=(floor(w1)-ceil(w0))/pi;
  wscaled=(w(ceil(w0):floor(w1))-ceil(w0))/p;
  LPF (ceil(w0):floor(w1))=(1+cos(wscaled)).*sqrt(2-cos(wscaled))/2;
  HPF =zeros(1,l);
  trans=(1-(LPF(ceil(w0):floor(w1))));
  HPF(ceil(w0):floor(w1))=trans;
  HPF (floor(w1)+1:floor(w2))=ones(1,(floor(w2))-floor(w1));
  p=(floor(w3)-floor(w2))/pi;
  wscaled=(w(ceil(w2):ceil(w3))-ceil(w2))/p;
  HPF(ceil(w2):ceil(w3))=(1+cos(wscaled)).*sqrt(2-cos(wscaled))/2;
end