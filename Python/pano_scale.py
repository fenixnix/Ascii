import os
from PIL import Image

path = "./IR_Images/"

for p in os.walk(path):
    for f in p[2]:
        file = p[0]+'/'+f
        print(file)
        try:
            img = Image.open(file)
        except:
            print("error image: ",file)
            pass
        else:
            img = img.resize((int(img.size[0]/2),int(img.size[1]/2)),Image.NEAREST)
            if file.endswith('.png'):
                img = img.resize((int(img.size[0]/2),int(img.size[1]/2)),Image.NEAREST)
            img.save(file)