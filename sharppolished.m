function [pic,polished]=sharppolished(pic)
pic = imsharpen(pic,'Radius',5,'Amount',0.5);
% pic=rgb2gray(pic);
pic = wiener2(pic,[5 5]);
polished1=[-1.2 -0.8 -0.6 ;0 0 0 ;1.2 0.8 0.6 ];
polished11=[1.2 0.8 0.6 ;0 0 0 ;-1.2 -0.8 -0.6 ];
polished111=[-0.1 -0.8 -0.6 ;0 0  0;0.1 0.8 0.6 ];
polished1111=[0.1 0.8 0.6 ;0 0 0 ;-0.1 -0.8 -0.6 ];
polished2=polished1';
polished22=polished11';
polished222=polished111';
polished2222=polished1111';
polished1filter=imfilter(pic,polished1);
polished2filter=imfilter(pic,polished2);
polished11filter=imfilter(pic,polished11);
polished22filter=imfilter(pic,polished22);
polished111filter=imfilter(pic,polished111);
polished222filter=imfilter(pic,polished222);
polished1111filter=imfilter(pic,polished1111);
polished2222filter=imfilter(pic,polished2222);
polished=abs(polished1filter)+abs(polished2filter)+abs(polished11filter)+abs(polished22filter)+abs(polished111filter)+abs(polished222filter)+abs(polished1111filter)+abs(polished2222filter);
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,5,1),imshow(pic);title('Original');
% subplot(2,5,2),imshow(polished1filter);title('Horizontal Edges');
% subplot(2,5,3),imshow(polished2filter);title('Vertical Edges');
% subplot(2,5,4),imshow(polished11filter);
% subplot(2,5,5),imshow(polished22filter);
% subplot(2,5,6),imshow(polished111filter);
% subplot(2,5,7),imshow(polished222filter);
% subplot(2,5,8),imshow(polished1111filter);
% subplot(2,5,9),imshow(polished2222filter);
% subplot(2,5,10),imshow(polished);
end


