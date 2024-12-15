%Read the input images
clear;
path='frames';
fileinfo = dir(fullfile(path,'*.png'));
filesnumber=size(fileinfo);
fileinformation = struct2cell(fileinfo);
fileinformation=fileinformation';
for i=1:filesnumber(1,1)
names{i,1}=fileinformation{i,1};
end;
outputVideo = VideoWriter(fullfile('Sample.avi'));
open(outputVideo)
for i = 1:filesnumber(1,1)
   img = imread(fullfile(path,names{i}));
   writeVideo(outputVideo,img)
       disp(['Joining IMG :   ' num2str(i) ]);
end
close(outputVideo)