import pdfplumber
import os
import json
import codecs
import shutil

allowList = ['国资委','业绩预告']
blockList = []

srcPath = "G:/Nix/PDF/"
dstPath = "G:/Nix/Hit/"

hit_list = []
snapshot = []

fileList = []
with open("hit.json",'r') as f:
    js = f.read()
    fileList = json.loads(js)

def SaveSnapShot(ss):
    with open("%s%s[%s].txt"%(dstPath,ss["file"],ss['key']),'w',encoding='utf-8') as f:
        f.write(ss["snapshot"])

def AnalyzePDF(pdfFile):
    content = ''
    with pdfplumber.open(srcPath + pdfFile) as pdf:
        for i in range(len(pdf.pages)):
            page = pdf.pages[i]
            #page_content = '\n'.join(page.extract_text().split('\n')[:-1])
            page_content = str(page.extract_text())
            for a in allowList:
                if a in page_content:
                    data = page_content.replace(a,"|-|-|-|-|%s|-|-|-|-|"%(a))
                    ss = {"file":pdfFile,"key":a,"snapshot":data}
                    snapshot.append(ss)
                    SaveSnapShot(ss)
                    return True
    return False

for p in os.listdir(srcPath):
    print(p)
    hit = AnalyzePDF(p)
    if hit:
        print('hit!')
        hit_list.append(p)

with open("hit.json",'w') as f:
    f.write(json.dumps(hit_list))
    