import os
import json

def createScript(path,name,desc):
    print("name:",name)
    name_ = name.strip().replace(' ','_').lower()
    path_ = "%s/%s.gd"%(path,name_)
    print(path_)
    with open(path_,'w') as f:
        for d in desc:
            f.write("#%s\n"%d)

def GenScript(jsonFile,folder):
    with open(jsonFile,"r") as f:
        js = json.loads(f.read())
        print("file:",jsonFile)
        for card in js:
            createScript("./script/%s/"%folder,card["name"],card["desc"])

for file in os.walk("./slay_sprite/data/"):
    print(file)
    for f in file[2]:
        GenScript(file[0]+f,f.split('.')[0])