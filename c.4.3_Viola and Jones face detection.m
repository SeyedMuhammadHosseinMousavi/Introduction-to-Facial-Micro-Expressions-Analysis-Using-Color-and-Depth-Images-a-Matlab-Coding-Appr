clear;
%Detect objects using Viola-Jones Algorithm
%To detect Face
FDetect = vision.CascadeObjectDetector('FrontalFaceCART','MergeThreshold',16');
% NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
% MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
% EyePairBigDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',16);
%Read the input images
path='viola';
fileinfo = dir(fullfile(path,'*.jpg'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
%Returns Bounding Box values based on number of objects
for i = 1 : filesnumber(1,1)
BB{i}=step(FDetect,(imread(fullfile(path,fileinfo(i).name)))); 
    disp(['BB :   ' num2str(i) ]);
end;
% find number of empty BB and index of them
c=0;
for  i = 1 : filesnumber(1,1)
   if  isempty(BB{i})
        c=c+1;
        indexempty(c)=i;
   end;
end;
% replace the empty cells with bounding box
for  i = 1 : c
BB{indexempty(i)}=[40 60 180 180];
end;
%Removing other founded faces and keep just frist face or box
for  i = 1 : filesnumber(1,1)
    BB{i}=BB{i}(1,:);
end;
%% Croping the Bounding box(face)
for i = 1 : filesnumber(1,1)
croped{i}=imcrop(images{i},BB{i}); 
    disp(['Croped :   ' num2str(i) ]);
end;
%%  Enhance the contrast of an intensity image using histogram equalization.
%rgb to gray convertion
for i = 1 : filesnumber(1,1)
hist{i}=rgb2gray(croped{i});
    disp(['To Gray :   ' num2str(i) ]);
end;
%imadjust
for i = 1 : filesnumber(1,1)
adjusted{i}=imadjust(hist{i}); 
    disp(['Image Adjust :   ' num2str(i) ]);
end;
%% resize the final image size
for i = 1 : filesnumber(1,1)
resized{i}=imresize(croped{i}, [30 40]); 
    disp(['Image Resized :   ' num2str(i) ]);
end;
%% montage plot
montage(images); title('Originals');
figure;
montage(resized); title('Cropped');

