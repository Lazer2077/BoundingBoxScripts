  close all;
  %% single
  pathIm= 'uav0000086_00000_v_0000005.jpg'
  pathTx='uav0000086_00000_v_0000005.txt'
Im=imread(pathIm);
[nx,ny,~]=size(Im)

[t,p1x,p1y,p2x,p2y]=textread(pathTx,'%d %f %f %f %f');
p1x=nx*p1x;
p1y=ny*p1y;
p2x=nx*p2x;
p2y=ny*p2y;
x=round(p1x);
y=round(p1y);
w=round(p2x);
l=round(p2y);
target1=[3]
try
  [state,dst]=draw_rect(Im,[x,y],[w,l],0,t,target1);
catch err
  disp('boxing error');
  throw(err)
end
figure,imshow(dst);

folder = './result/';
if ~exist(folder,'dir')
mkdir result;
end
imwrite(dst,'result\uav0000086_00000_v_0000005.jpg')

%% muti

fileExt1 = '*.jpg';  
isDefault=input('Please input if use Relative Path(default) dir, y or n:','s');
if isDefault=='y'
  SamplePath1 =  'JPEGImages\';  
  SamplePath2 =  'labels\';  
  folder = 'result\';
  if ~exist(folder,'dir')
    mkdir result;
  end
elseif isDefault=='n'
  inPath=input('Please input the path of folder:','s');
  SamplePath1=strcat(inPath,'images\');
  SamplePath2=strcat(inPath,'annotations\');
  folder=strcat(inPath,'result\');
  if ~exist(inPath,'dir')
    disp('input path error');
    return
  end
end
files = dir(fullfile(SamplePath1,fileExt1)); 
len1 = size(files,1);
sprintf('read %d file sucess!',len1)
target=input('Please input the target vector:\n');
minNum=input('Please input the min number of target:\n');

for i=1:len1;
  ImfileName = strcat(SamplePath1,files(i).name); 
  TxfileName = strcat(SamplePath2,files(i).name(1:end-4),'.txt')
  WtPath=strcat(folder,files(i).name);
  try
    [t,p1x,p1y,p2x,p2y]=textread(TxfileName,'%d %f %f %f %f');
    Im=imread(ImfileName);
  catch
    disp('read error');
  end
  if max(sum(t==target))>=minNum
    continue;
  end
  [nx,ny,~]=size(Im)
  p1x=nx*p1x;
  p1y=ny*p1y;
  p2x=nx*p2x;
  p2y=ny*p2y;
  x=round(p1x);
  y=round(p1y);
  w=round(p2x);
  l=round(p2y);
  [state,result]= draw_rect(Im,[x,y],[w,l],0,t,target);
  imwrite(result,WtPath);
end