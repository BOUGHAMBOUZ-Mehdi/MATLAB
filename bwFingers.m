%capture frame
frame = imread('2.jpg');
%Read the image, and capture the dimensions
% img=uint8(255*frame);
out=skinDetect2Func(frame);

stats=regionprops(out,'Centroid');

if length(stats)

    cx=stats.Centroid(1);
    cy=stats.Centroid(2);

    %find the nearest countour point
    boundary=bwboundaries(out);
    minDist=2*640*640;
    mx=cx;
    my=cy;
    bImg=uint8(zeros(480,640));

    for i=1:length(boundary)
        cell=boundary{i,1};
        for j=1:length(cell)
            y=cell(j,1);
            x=cell(j,2);

            sqrDist=(cx-x)*(cx-x)+(cy-y)*(cy-y);
            bImg(x,y)=255;

            if(sqrDist<minDist)
                minDist=sqrDist;
                mx=x;
                my=y;
            end
        end
    end
    
    sed=strel('disk',round(sqrt(minDist)/2));
    final=imerode(out,sed);
    final=imdilate(final,sed);
    final=out-final;
    
    final=bwareaopen(final,200);
	final=imerode(final,strel('disk',10));
    final=bwareaopen(final,400);
    
    [L,num]=bwlabel(final,8);
    final=imclearborder(final,8);
    imshow(final);
    sprintf('Le nombre de doigt est :%d',num)
else
    imshow(out)
end
  