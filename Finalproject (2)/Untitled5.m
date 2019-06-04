
obj=VideoReader('highway.avi');
a=read(obj);
frames=get(obj,'NumberOfFrames');

%extracting Frames

for i=1:frames
     I(i).cdata=a(:,:,:,1);
end   
s=size(I(i).cdata);
mov(1:frames) =struct('cdata', zeros(s(1),s(2), 3, 'uint8'),'colormap', []);
 
for Frame=1:frames
%Red Components of the Frame
R=I(frames).cdata(:,:,1); 
%Green Components of the Frame
G=I(frames).cdata(:,:,2); 
%Blue Components of the Frame
B=I(frames).cdata(:,:,3); 
Rdouble = double(R);
Gdouble = double(G);
Bdouble = double(B);
Rbin = de2bi(Rdouble);
Gbin = de2bi(Gdouble);
Bbin = de2bi(Bdouble);
msgR = reshape(Rbin,[1024,198]);
packetR = reshape(Rbin, (25344*8)/1024,1024);
trellisR = poly2trellis(7,[171 133]);
msgG = reshape(Gbin,[1024,198]);
packetG = reshape(Gbin, (25344*8)/1024,1024);
trellisG = poly2trellis(7,[171 133]);
msgB = reshape(Bbin,[1024,198]);
packetB = reshape(Bbin, (25344*8)/1024,1024);
trellisB = poly2trellis(7,[171 133]);
 p = 0.0001:0.1:0.2;
for k=1:length(p)
for i=1:198
codewordRed(i,:) = convenc(packetR(i,:),trellisR);
channel = bsc(codewordRed,p(k));
decodedRed(i,:) = vitdec(channel , trellisR, 35,'trunc','hard');
CR = xor(packetR(i,:),decodedRed(i,:));
numOfonesR=find(CR==1)
LR = size(numOfonesR);
end
for i=1:198
codewordGreen(i,:) = convenc(packetG(i,:),trellisG);
channel = bsc(codewordGreen,p(k));
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard');
CG = xor(packetG(i,:),decodedGreen(i,:));
numOfonesG=find(CG==1)
LG = size(numOfonesG);
end

for i=1:198
codewordBlue(i,:) = convenc(packetB(i,:),trellisB);
channel = bsc(codewordBlue,p(k));
decodedBlue(i,:) = vitdec(channel , trellisB, 35,'trunc','hard');
CB = xor(packetB(i,:),decodedBlue(i,:));
numOfonesB=find(CB==1)
LB = size(numOfonesB);
end
end
Rstream = reshape(packetR,1,198*1024);
reshapedred = reshape(decodedRed,144*176,8);
Gstream = reshape(packetG,1,198*1024);
reshapedgreen = reshape(decodedGreen,144*176,8);
Bstream = reshape(packetB,1,198*1024);
reshapedblue = reshape(decodedBlue,144*176,8);
decimalred = bi2de(reshapedred);
decimalgreen = bi2de(reshapedgreen);
decimalblue = bi2de(reshapedblue);
redunsigned = uint8(decimalred);
greenunsigned = uint8(decimalgreen);
blueunsigned = uint8(decimalblue);
mov(1,Frame).cdata(:,:,1) = R; 
mov(1,Frame).cdata(:,:,2) = G;
mov(1,Frame).cdata(:,:,3) = B;
end
%saving the new Movie
movie2avi(mov,'halfrate02.avi')
%play the movie
implay('halfrate02.avi')
