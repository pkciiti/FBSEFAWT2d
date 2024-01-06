function [LPF , HPF , w0, w1, w2, w3]=filterdesign(L, a, b, c, d, l)
  beta = c/d;
  eta = (1/32)*((a-b)+( beta*b))/(a + b)*L;
  w0 = ((1- beta)*L) + eta;
  w1 = (a*L)/b; 
  w2 = (L-eta);
  w3 = (L +eta);

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