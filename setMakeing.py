import os, random, shutil
def file_filter(f):
    if f[-4:] in ['.jpg', '.png', '.bmp']:
        return True
    else:
        return False
def mkdir(path):
    isExists=os.path.exists(path)
    if not isExists:
        os.makedirs(path) 
        print (path+' create success!')
        return True
    else:
        print (path+' already exists! remove it')
        shutil.rmtree(path)
        return False
if __name__ == '__main__':
    
    key_name=['train','val','test1','test2','test3']
    image_dir = r"C:\Users\user\Desktop\result"    #源图片文件夹路径
    tarDir = r"C:\Users\user\Desktop\result\set"
    mkdir(tarDir)
    img_name_list = os.listdir(image_dir)
    for folder in key_name:
        mkdir(tarDir+'\\'+folder)
    files_dir = list(filter(file_filter, img_name_list))
    
    for i in range(len(files_dir)):
        a=random.randint(0,4)
        #put them to  5 different folder
        print(a)
        shutil.copy(image_dir+'\\'+files_dir[i],tarDir+'\\'+key_name[a]+'\\'+files_dir[i])
        print('copy success')
