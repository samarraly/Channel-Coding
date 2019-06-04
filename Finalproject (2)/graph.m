clc
clear all
close all
obj=VideoReader('highway.avi');
a=read(obj);
frames=get(obj,'NumberOfFrames');

%extracting Frames

for i=1:frames
     I(i).cdata=a(:,:,:,i);
end   
s=size(I(1).cdata);
mov(1:frames) =struct('cdata', zeros(s(1),s(2), 3, 'uint8'),'colormap', []);
 
for Frame=1:frames
%Red Components of the Frame
R=I(Frame).cdata(:,:,1); 
%Green Components of the Frame
G=I(Frame).cdata(:,:,2); 
%Blue Components of the Frame
B=I(Frame).cdata(:,:,3); 
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
%p = 0.0001:0.01:0.2;
trellisB = poly2trellis(7,[171 133]);

for i=1:198
codewordRed(i,:) = convenc(packetR(i,:),trellisR);
channel = bsc(packetR(i,:),p);
decodedRed(i,:) = vitdec(codewordRed(i,:), trellisR, 35,'trunc','hard');
end
for i=1:198
codewordGreen(i,:) = convenc(packetG(i,:),trellisG);
channel = bsc(packetG(i,:),p);
decodedGreen(i,:) = vitdec(codewordGreen(i,:), trellisG, 35,'trunc','hard');
end

for i=1:198
codewordBlue(i,:) = convenc(packetB(i,:),trellisB);
channel = bsc(packetB(i,:),p);
decodedBlue(i,:) = vitdec(codewordBlue(i,:), trellisB, 35,'trunc','hard');
end
Rstream = reshape(packetR,1,198*1024);
reshapedred = reshape(packetR,144*176,8);
Gstream = reshape(packetG,1,198*1024);
reshapedgreen = reshape(packetG,144*176,8);
Bstream = reshape(packetB,1,198*1024);
reshapedblue = reshape(packetB,144*176,8);
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
movie2avi(mov,'graph.avi')
%play the movie
implay('graph.avi')
