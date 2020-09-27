import requests
import json

root_url = "https://static.wikia.nocookie.net/slay-the-spire/images/"

urls_dict ={
    "ironclad":"f/f0/%s",
    "silence":"8/8c/%s",
    "defect":"7/72/%s",
    "watcher":"f/f3/%s",
    "colorless":"e/e6/%s"
}

urls_eot_dict = [
    "0/07/%s",
    "a/a4/%s"
]

raw_datas = {
    "ironclad":"00",
    "silence":"01",
    "defect":"02",
    "watcher":"03",
    "colorless":"04"
}

raw_eot = {
    "curse":"05",
    "status":"06"
}

data_path = "%s.txt"

def cvtBuffer(buffer):
    if buffer["desc"] != "":
        detail = buffer["desc"].split('\t')
        buffer["rarity"] = detail[0].strip()
        buffer["type"] = detail[1].strip()
        buffer["cost"] = detail[2].strip()
        trait = detail[3].strip().split('.')
        tmp = []
        for t in trait:
            tt = t.strip()
            if tt!="":
                tmp.append(tt)
        buffer["desc"] = tmp

def LoadDb(file):
    db = []
    with open(file,'r',encoding='UTF-8') as f:
        index = 0
        buffer = {"desc":""}
        while True:
            line = f.readline()
            if not line:
                break
            arrays = line.split('\t')
            if len(arrays)==2:
                if arrays[1].strip().endswith(".png"):
                    cvtBuffer(buffer)
                    # if buffer["desc"] != "":
                    #     detail = buffer["desc"].split('\t')
                    #     buffer["rarity"] = detail[0].strip()
                    #     buffer["type"] = detail[1].strip()
                    #     buffer["cost"] = detail[2].strip()
                    #     trait = detail[3].strip().split('.')
                    #     tmp = []
                    #     for t in trait:
                    #         tt = t.strip()
                    #         if tt!="":
                    #             tmp.append(tt)
                    #     buffer["desc"] = tmp
                    db.append(buffer)
                    buffer = {"desc":""}
                    buffer["name"] = arrays[0].strip()
                    buffer["img"] = arrays[1].strip()
            else:
                buffer["desc"]+=line
        cvtBuffer(buffer)
        # detail = buffer["desc"].split('\t')
        # buffer["rarity"] = detail[0].strip()
        # buffer["type"] = detail[1].strip()
        # buffer["cost"] = detail[2].strip()
        # trait = detail[3].strip().split('.')
        # tmp = []
        # for t in trait:
        #     tt = t.strip()
        #     if tt!="":
        #         tmp.append(tt)
        # buffer["desc"] = tmp
        db.append(buffer)
        db = db[1:]
    for d in db:
        print(d)
    return db

image_path = "./slay_sprite/image/%s"

def download(url,file):
    r = requests.get(url) 
    if r.status_code!=200:
        return False
    with open(file, "wb") as f:
        f.write(r.content)
    return True

def CrawlerImage(db,url):
    print("crawler",url)
    for d in db:
        img_url = url%d["img"]
        img_path = image_path%d["img"]
        print("crawler:",img_url,img_path)
        download(img_url,img_path)

for k in raw_datas.keys():
    v = raw_datas[k]
    file = data_path%v
    print(k,file)
    db = LoadDb(file)
    with open("slay_sprite/data/%s.json"%k,'w') as f:
        f.write(json.dumps(db))
    #CrawlerImage(db,root_url+urls_dict[k])