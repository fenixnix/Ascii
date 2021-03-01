import os
import json
import shutil

fileList = []
with open("hit.json",'r') as f:
    js = f.read()
    fileList = json.loads(js)

srcPath = "G:/Nix/PDF/"
dstPath = "G:/Nix/Hit/"

for f in fileList:
    print('%s => %s'%(srcPath+f,dstPath+f))
    shutil.copyfile(srcPath+f,dstPath +f)