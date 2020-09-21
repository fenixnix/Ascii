import cv2 as cv
import pytesseract as tess
import easyocr
import json
import os

path = "/home/nix/Pictures/halcyon6_shipdata/"
src = "1.png"

jsonDat = ""
with open("tmp1.json","r") as f:
    jsonDat = f.read()
template = json.loads(jsonDat)

def Page_OCR(filePath):
    print("ocr:",filePath)
    img = cv.imread(filePath,cv.IMREAD_GRAYSCALE)
    r,img = cv.threshold(img,100,255,cv.THRESH_BINARY_INV)
    res_data = {}
    for t in template:
        #print(t["key"])
        rect = t["roi"][1:-1].split(',')
        x = int(rect[0])
        y = int(rect[1])
        w = int(rect[2])
        h = int(rect[3])
        #print(x,y,w,h)
        roi = img[y:h+y,x:w+x]
        #print(roi)
        #cv.imwrite("%s.jpg"%(t["key"]),roi)
        res = tess.image_to_string(roi)
        res_data[t["key"]] = res.strip()
    return res_data

dataList = []

for p in os.walk(path):
    for f in p[2]:
        fileName = p[0]+f
        dataList.append(Page_OCR(fileName))

with open("ship.json","w") as f:
    f.write(json.dumps(dataList))
