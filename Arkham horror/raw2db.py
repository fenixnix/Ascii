import json
from imgCrawler import GrabByName


def Cvt(start,src,dst):
    db = []
    with open(src,'r',encoding='UTF-8') as f:
        index = start
        while True:
            line = f.readline()
            if not line:
                break
            d = line.split("\t")
            index+=1
            dat = {
                    "id":index,
                    "name":d[0],
                    "img":"%05d"%(index),
                    "class":d[1].strip(),
                    "type":d[3].strip(),
                    "icons":d[4],
                    "traits":d[5],
                    "set":d[6],
                    #"encounter":d[7]
                }
            GrabByName(dat["img"])
            if dat["type"] in ["Investigator","Scenario","Act","Agenda","Location"]:
                dat["imgb"] = "%05db"%(index)
                GrabByName(dat["imgb"])
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
# Cvt(2000,"./data/raw_y2.txt","./data/db_y2.json")
# Cvt(3000,"./data/raw_y3.txt","./data/db_y3.json")
# Cvt(4000,"./data/raw_y4.txt","./data/db_y4.json")
# Cvt(5000,"./data/raw_y5.txt","./data/db_y5.json")
# Cvt(6000,"./data/raw_y6.txt","./data/db_y6.json")
# Cvt(7000,"./data/raw_y7.txt","./data/db_y7.json")
# Cvt(50000,"./data/raw_y50.txt","./data/db_y50.json")
# Cvt(51000,"./data/raw_y51.txt","./data/db_y51.json")
# Cvt(52000,"./data/raw_y52.txt","./data/db_y52.json")
# Cvt(53000,"./data/raw_y53.txt","./data/db_y53.json")
# Cvt(60100,"./data/raw_y601.txt","./data/db_y601.json")
# Cvt(60200,"./data/raw_y602.txt","./data/db_y602.json")
# Cvt(60300,"./data/raw_y603.txt","./data/db_y603.json")
# Cvt(60400,"./data/raw_y604.txt","./data/db_y604.json")
# Cvt(60500,"./data/raw_y605.txt","./data/db_y605.json")
# Cvt(81000,"./data/raw_y81.txt","./data/db_y81.json")
# Cvt(82000,"./data/raw_y82.txt","./data/db_y82.json")
# Cvt(83000,"./data/raw_y83.txt","./data/db_y83.json")
# Cvt(84000,"./data/raw_y84.txt","./data/db_y84.json")
# Cvt(85000,"./data/raw_y85.txt","./data/db_y85.json")
# Cvt(90001,"./data/raw_y90.txt","./data/db_y90.json")
# Cvt(98000,"./data/raw_y98.txt","./data/db_y98.json")