import json

raw_datas = {
    "red":"ironclad",
    "green":"silence",
    "blue":"defect",
#    "purple":"watcher",
    "gray":"colorless"
}

raw_eot = {
    "curse":"05",
    "status":"06"
}

data_path = "%s.txt"

def ParseCost(buffer,cost_str):
    if cost_str == "":
        return
    if cost_str == "X":
        buffer["cost"] = "X"
        return
    if '(' in  cost_str:
        pair = cost_str.split('(')
        buffer["cost"] = int(pair[0])
        buffer["upgrade"] = {}
        buffer["upgrade"]["cost"] = int(pair[1][:-1])-int(pair[0])
    else:
        buffer["cost"] = int(cost_str)

def cvtBuffer(buffer,k):
    if buffer["desc"] != "":
        detail = buffer["desc"].split('\t')
        buffer["rarity"] = detail[0].strip()
        buffer["type"] = detail[1].strip()
        ParseCost(buffer,detail[2].strip())
        buffer["img"] = "%s/%s/%s"%(k,buffer["type"],buffer["name"].lower().replace(' ','_').replace('-','_').replace('.',''))
        trait = detail[3].strip().split('.')
        tmp = []
        for t in trait:
            tt = t.strip()
            if tt!="":
                tmp.append(tt)
        buffer["desc"] = tmp

def LoadDb(file,k):
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
                    cvtBuffer(buffer,k)
                    buffer["class"] = raw_datas[k]
                    db.append(buffer)
                    buffer = {"desc":""}
                    buffer["name"] = arrays[0].strip()
                    buffer["img"] = arrays[1].strip()
            else:
                buffer["desc"]+=line
        cvtBuffer(buffer,k)
        db.append(buffer)
        db = db[1:]
    for d in db:
        print(d)
    return db

def CvtCardRawDatToJsonDat():
    for k in raw_datas.keys():
        v = raw_datas[k]
        file = data_path%k
        print(k,file)
        db = LoadDb(file,k)
        with open("slay_sprite/data/%s.json"%k,'w') as f:
            f.write(json.dumps(db))
        #CrawlerImage(db,root_url+urls_dict[k])
    
CvtCardRawDatToJsonDat()