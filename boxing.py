# coding-utf8
import cv2
import glob
from cv2 import imshow
import numpy
import os
array_of_img = [] # this if for store all of the image data
# this function is for read image,the input is directory name
def file_filter(f):
    if f[-4:] in ['.jpg', '.png', '.bmp']:
        return True
    else:
        return False
def mkdir(path):
    isExists=os.path.exists(path)
    if not isExists:
        os.makedirs(path) 
        print (path+'创建成功')
        return True
    else:
        print (path+'目录已存在')
        return False
target=input("Please input target\n")
minNum=input("Please input Minimum number\n")

img_dir=r'C:\Users\user\Desktop\strong\result'
txt_dir=r'C:\Users\user\Desktop\strong\labels'
wrt_dir=r'C:\Users\user\Desktop\strong\res'
wsi_mask_paths = glob.glob(os.path.join(img_dir, '*.jpg'))
wsi_mask_paths.sort()
print('read the '+str(len(wsi_mask_paths))+' files...')
mkdir(wrt_dir)
for filename in wsi_mask_paths:
    src=cv2.imread(filename)
    dst=src
    h,w=src.shape[0],src.shape[1]
    filename_t=filename.split( "\\" ) [-1]
    wrt_src=wrt_dir+'\\'+filename_t
    ext = os.path.splitext(filename_t)
    if ext[1]=='.jpg':
        new_name='\\'+ext[0]+'.txt'
    src_txt=txt_dir+new_name
    xy1=[]
    xy2=[]
    target_num=0
    f=open(src_txt,'r')
    for line in f:
        numbers_str = line.split()
        numbers_float = [float(x) for x in numbers_str] 
        if target==numbers_str[0]:
            target_num+=1
            #类别 标注框中心X比例 标注框中心y比例 标注框比例 标注框比例
            a = numbers_float[0]
            b = numbers_float[1]
            c = numbers_float[2]
            d = numbers_float[3]
            e = numbers_float[4]
            wi = b * w  # 求
            hi = c * h
            wh = d * w
            hh = e * h
            x1 = int(wi - wh / 2)
            y1 = int(hi - hh / 2)
            x2 = int(wi + wh / 2)
            y2 = int(hi + hh / 2)
            xy1.append((x1, y1))
            xy2.append((x2, y2))
    if int(target_num)>=int(minNum):
        for i in range(len(xy1)):
            cv2.rectangle(dst,xy1[i],xy2[i], (0,255,0), 1)
            cv2.imshow('src',dst)
            cv2.waitKey(0)
            print(wrt_src)
            #cv2.imwrite(wrt_src,src)
    f.close()
        
