%function imgnew1=twodinvfbse(Cofcol,dim)
function imgnew1=twodinvfbse(Cofcol)
dim=3;
[M,N]=size(Cofcol);
% inverse
alfa=besselzero(0,M);
Besinv=besselj(0,(alfa/M)'*(1:M));
if dim==1
imgnew1=Cofcol*Besinv;
imshow(uint8(imgnew1),[]);

elseif dim==2
imgnew1=Cofcol'*Besinv;
imshow(uint8(imgnew1'),[]);

elseif dim==3
 imgnew=Cofcol'*Besinv;    
 imgnew1=imgnew'*Besinv;


imgnew1(M,:)=imgnew1(M-2,:);
imgnew1(:,N)=imgnew1(:,N-2);
imgnew1(M-1,:)=imgnew1(M-2,:);
imgnew1(:,N-1)=imgnew1(:,N-2);
imgnew1(1,:)=imgnew1(3,:);
imgnew1(:,1)=imgnew1(:,3);
imgnew1(2,:)=imgnew1(3,:);
imgnew1(:,2)=imgnew1(:,3);
end