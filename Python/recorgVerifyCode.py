import os
from PIL import Image

def SplitGif(fileName):
    im = Image.open(fileName)
    os.mkdir('图形拆分')
    try:
    i = 0
    while True:
        im.seek(i)
        im.save('图形拆分/'+str(i)+'.png')
        i = i +1
    except:
    pass
    print('共拆解图像帧数'+str(i))

SplitGif('D:\\Python\\gif\\first.gif')