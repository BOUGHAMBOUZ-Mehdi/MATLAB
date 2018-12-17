%skin detect return pixels
function out=skinDetect2func(img)
imshow(img)
sz=size(img);
r=1;g=2;b=3;y=1;u=2;v=3;
yuv=img;
region=yuv;

yuv(:,:,y) = (img(:,:,r)+2.*img(:,:,g)+img(:,:,b))/4;
yuv(:,:,u) = img(:,:,r)-img(:,:,g);
yuv(:,:,v)=img(:,:,b)-img(:,:,g);

region = (yuv(:,:,u)>20 & yuv(:,:,v)<74) .* 255;

out=region;
%filtering
out=im2bw(out);
out=bwareaopen(out,100);
out=imdilate(out,strel('diamond',4));
 imshow(out)
%retain largest only
res=out;
cc=bwconncomp(res);
arr=(cellfun('length',cc.PixelIdxList));
newLabel=res;
if ~isempty(round(arr))
    msz=0;
    for i=1:length(arr)
        if msz<arr(i:i)
            msz=arr(i:i);
            index=i;
        end
    end
    labels=labelmatrix(cc);
    newLabel=(labels==index);
    out=newLabel;
end
out=imfill(out,'holes');
 imshow(out)
end