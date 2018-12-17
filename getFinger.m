     diff_im=imread('5.jpeg');
se=strel('disk',21);
bwerode=imerode(diff_im,se);
figure(1)
imshow(bwerode);
bwdil=imdilate(bwerode,se);
figure(2)
imshow(bwdil);
ori=diff_im-bwdil;
figure(3)
imshow(ori);
D = bwdist(~ori);
figure(4)
imshow(D,[],'InitialMagnification','fit')
title('Distance transform of ~bw')
BW4=im2bw(D); %active finger image coverted to binary
figure(5)
imshow(BW4)
[labeled,numObjects]=bwlabel(BW4);
 numObjects1=numObjects-1
 if(numObjects1==5)
     disp('zoom in')
  end