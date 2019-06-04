clc;
clear all;
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
trellisB = poly2trellis(7,[171 133]);
p = 0.1;
for i=1:198
punc8 =[1 1 1 0 1 0 1 0 0 1 1 0 1 0 1 0];
codewordRed = convenc(packetR(i,:),trellisR,punc8);
channel = bsc(codewordRed,p);
decodedRed(i,:) = vitdec(channel, trellisR, 35,'trunc','hard',punc8);
true = isequal(packetR(i,:),decodedRed(i,:));
if(true ==0)
 punc4 =[1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
codewordRed = convenc(packetR(i,:),trellisR,punc4);
channel = bsc(codewordRed,p);
decodedRed(i,:) = vitdec(channel, trellisR, 35,'trunc','hard',punc4);
true = isequal(packetR(i,:),decodedRed(i,:));
end
if(true==0)
punc2 = [1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0];
codewordRed = convenc(packetR(i,:),trellisR,punc2);
channel = bsc(codewordRed,p);
decodedRed(i,:) = vitdec(channel, trellisR, 35,'trunc','hard',punc2);
true = isequal(packetR(i,:),decodedRed(i,:));
end
if(true==0)
punc7 =[1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0];
codewordRed = convenc(packetR(i,:),trellisR,punc7);
channel = bsc(codewordRed,p);
decodedRed(i,:) = vitdec(channel, trellisR, 35,'trunc','hard',punc7);
true = isequal(packetR(i,:),decodedRed(i,:));
end
if(true==0)
punchalf =[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
codewordRed = convenc(packetR(i,:),trellisR,punchalf);
channel = bsc(codewordRed,p);
decodedRed(i,:) = vitdec(channel, trellisR, 35,'trunc','hard',punchalf);
true = isequal(packetR(i,:),decodedRed(i,:));
end
end


for i=1:198
punc8 =[1 1 1 0 1 0 1 0 0 1 1 0 1 0 1 0];
codewordGreen = convenc(packetG(i,:),trellisG,punc8);
channel = bsc(codewordGreen,p);
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard',punc8);
true = isequal(packetG(i,:),decodedGreen(i,:));
if(true ==0)
 punc4 =[1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
codewordGreen = convenc(packetG(i,:),trellisG,punc4);
channel = bsc(codewordGreen,p);
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard',punc4);
true = isequal(packetG(i,:),decodedGreen(i,:));
end
if(true==0)
punc2 =[1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0];
codewordGreen = convenc(packetG(i,:),trellisG,punc2);
channel = bsc(codewordGreen,p);
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard',punc2);
true = isequal(packetG(i,:),decodedGreen(i,:));
end
if(true==0)
punc7 =[1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0];
codewordGreen = convenc(packetG(i,:),trellisG,punc7);
channel = bsc(codewordGreen,p);
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard',punc7);
true = isequal(packetG(i,:),decodedGreen(i,:));
end
if(true==0)
punchalf =[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
codewordGreen = convenc(packetG(i,:),trellisG,punchalf);
channel = bsc(codewordGreen,p);
decodedGreen(i,:) = vitdec(channel, trellisG, 35,'trunc','hard',punchalf);
true = isequal(packetG(i,:),decodedGreen(i,:));
end
end

for i=1:198
punc8 =[1 1 1 0 1 0 1 0 0 1 1 0 1 0 1 0];
codewordBlue = convenc(packetB(i,:),trellisB,punc8);
channel = bsc(codewordBlue,p);
decodedBlue(i,:) = vitdec(channel, trellisB, 35,'trunc','hard',punc8);
true = isequal(packetB(i,:),decodedBlue(i,:));
if(true ==0)
 punc4 =[1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
codewordBlue = convenc(packetB(i,:),trellisB,punc4);
channel = bsc(codewordBlue,p);
decodedBlue(i,:) = vitdec(channel, trellisB, 35,'trunc','hard',punc4);
true = isequal(packetB(i,:),decodedBlue(i,:));
end
if(true==0)
punc2 =[1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0];
codewordBlue = convenc(packetB(i,:),trellisB,punc2);
channel = bsc(codewordBlue,p);
decodedBlue(i,:) = vitdec(channel, trellisB, 35,'trunc','hard',punc2);
true = isequal(packetB(i,:),decodedBlue(i,:));
end
if(true==0)
punc7 =[1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0];
codewordBlue = convenc(packetB(i,:),trellisB,punc7);
channel = bsc(codewordBlue,p);
decodedBlue(i,:) = vitdec(channel, trellisB, 35,'trunc','hard',punc7);
true = isequal(packetB(i,:),decodedBlue(i,:));
end
if(true==0)
punchalf =[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
codewordBlue = convenc(packetB(i,:),trellisB,punchalf);
channel = bsc(codewordBlue,p);
decodedBlue(i,:) = vitdec(channel, trellisB, 35,'trunc','hard',punchalf);
true = isequal(packetB(i,:),decodedBlue(i,:));
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
movie2avi(mov,'punct01.avi')
%play the movie
implay('punct01.avi')