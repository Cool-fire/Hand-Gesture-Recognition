%configure hardware input device
clc;
clear;
close all;

vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 
%Capture one frame per trigger
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp');
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
  imshow(BW); hold on;
       for k=1:length(B),
         if(~sum(A(k,:)))
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end
       
       
%        imshow(AA); hold on;
load boundary       
       
aa=1;
%Infinite while loop
load r;
load c;
% r=69:400;
% c=83:500;
while(1)
% preview(vid)
%Get Image
trigger(vid);
im=getdata(vid,1);
imshow(im);
hold on
if aa == 25
    red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
figure;
imshow(Out);title('Capturing BackGround');
imwrite(Out,'bg.bmp');
   
end


plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
disp(aa);
if aa == 60
   break 
end


end

stop(vid),delete(vid),clear vid; 

red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
figure, imshow(Out,[])
        a=imread('bg.bmp');
C1=segment(a,Out);
% close all;
figure;
str='.bmp';
str1='F'
for i=1:50
    a=strcat(num2str(i),str);
    b=imread(a);
    re1=corr2(b,C1);
      fresultValues_r(i) = re1;
    fresultNames_r(i) = {a};
  
    result1(i)=re1
%     figure;
%     subplot(1,2,1);imshow(C1);
%     subplot(1,2,2);imshow(b);
%     xlabel(re1);
end

[re ma]=max(result1);
 a=strcat(num2str(ma),str);
b=imread(a);
figure;
imshow(b);title('recognition result');
    
[sortedValues_r, index_r] = sort(-fresultValues_r);     % Sorted results... the vector index

count1=0;
count2=0;
count3=0;
count4=0;
count5=0;
    fid = fopen('recognition.txt', 'w+');         % Create a file, over-write old ones.
for i = 1:10        % Store top 5 matches...
    
    
    
    imagename = char(fresultNames_r(index_r(i)));
    fprintf(fid, '%s\r', imagename);
    
    a=index_r(i)
    
    if a > 0 && a <=10
        
        count1=count1+1;
        
    elseif a > 10 && a <=20
        count2=count2+1;
    elseif a > 20 && a <=30
        count3=count3+1;
    elseif a > 30 && a <=40
        count4=count4+1;
    else
            count5=count5+1;
    end
    
    
    
end
fclose(fid);
disp('exit');

Out =[count1 count2 count3  count4  count5];

 
 [Res ind]=max(Out);
 
 warndlg(num2str(ind));

%   