%function Cofcol=twodfbse(img,dim)
function Cofcol=twodfbse(img)
%img=img-mean(mean(mean(img)));
dim=3;
[M,N]=size(img);
A=1:M;
A=repmat(A,M,1);
alfa=besselzero(0,M);
K=2/(M*M);

Bes=besselj(0,([1:M]'.*repmat(alfa/M,M,1)))./(besselj(1,repmat(alfa,M,1))).^2;
if dim==1
Aimg=A.*img;
Cofcol=K*Aimg*Bes;

% col
elseif dim==2
imgcol=img';
Aimgcol=A.*imgcol;
Cofcol=K*Aimgcol*Bes;
Cofcol=Cofcol';

% 2d
elseif dim==3
Aimg=A.*img;
Cof=K*Aimg*Bes;
imgcol=Cof';
Aimgcol=A.*imgcol;
Cofcol=K*Aimgcol*Bes;
Cofcol=Cofcol';

end

