import json
from imgCrawler import GrabByName


def Cvt(start,src,dst):
    db = []
    with open(src,'r',encoding='UTF-8') as f:
        while True:
            line = f.readline()
            if not line:
                break
            d = line.split("\t")
            if len(d)<=1:
                continue

            d6 = d[6].strip().rsplit(' ',1)
            if len(d6)!=2:
                print("err",d)
            index = start + int(d6[1])
            set_id = d6[0]

            dat = {
                    "id":index,
                    "set":set_id,
                    "name":d[0],
                    "img":"%05d"%(index),
                    "class":d[1].strip(),
                    "type":d[3].strip(),
                    "icons":d[4],
                    "traits":d[5],
                    #"encounter":d[7]
                }
            #GrabByName(dat["img"])
            if dat["type"] in ["Investigator","Scenario","Act","Agenda","Location"]:
                dat["imgb"] = "%05db"%(index)
                #GrabByName(dat["imgb"])
            if len(d[2])>0:
                #print("print",d[2])
                dat["cost"] = int(d[2])
            if len(d)>=8:
                pair = d[7].strip().rsplit(' ',1)
                if len(pair)==2:
                    print(index,pair)
                    dat["encounter"] = pair[0].strip()
                    dat["encounter#"] = pair[1].strip()
            else:
                print("err len:",d)
            db.append(dat)
            #print(d)
        with open(dst,'w') as fw:
            fw.write(json.dumps(db))

srcPath = "./raw/%s.txt"
dstPath = "./arkham/data/%s.json"

Cvt(1000,srcPath%"raw",dstPath%"db_core")
Cvt(2000,srcPath%"raw_y2",dstPath%"db_y2")
Cvt(3000,srcPath%"raw_y3",dstPath%"db_y3")
Cvt(4000,srcPath%"raw_y4",dstPath%"db_y4")
Cvt(5000,srcPath%"raw_y5",dstPath%"db_y5")
Cvt(6000,srcPath%"raw_y6",dstPath%"db_y6")
Cvt(7000,srcPath%"raw_y7",dstPath%"db_y7")

Cvt(50000,srcPath%"raw_y50",dstPath%"db_y50")
Cvt(51000,srcPath%"raw_y51",dstPath%"db_y51")
Cvt(52000,srcPath%"raw_y52",dstPath%"db_y52")
Cvt(53000,srcPath%"raw_y53",dstPath%"db_y53")

for i in range(1,6):
    Cvt(60000+100*i,srcPath%"raw_y60%d"%i,dstPath%"db_y60%d"%i)

for i in range(1,6):
    Cvt(80000+1000*i,srcPath%"raw_y8%d"%i,dstPath%"db_y8%d"%i)

Cvt(90000,srcPath%"raw_y90",dstPath%"db_y90")
Cvt(98000,srcPath%"raw_y98",dstPath%"db_y98")
Cvt(99000,srcPath%"raw_y99",dstPath%"db_y99")