import json

def rarity_class(dat,tmp):
    if '(' in dat:
        pair = dat.split('(')
        tmp["rarity"] = pair[0].strip()
        tmp["class"] = pair[1][:-6]
    else:
        tmp["rarity"] = dat.strip()
        tmp["class"] = "All"

def bufToDict(buffer):
    pairs = buffer.strip().split('\t')
    if len(pairs)!=4:
        print(pairs)
    tmp = { 
        "id":pairs[1].lower().replace(' ','_').replace('-','_'),
        "name":pairs[1],
        "desc":pairs[3]
    }
    rarity_class(pairs[2],tmp)
    return tmp

def rawToJson():
    with open('relic.raw','r') as f:
        file_dat = f.read()
        dat_lst = file_dat.split("\n")

        data_db = []
        buffer = ""
        for d in dat_lst:
            if d.strip().endswith(".png"):
                if buffer != "":
                    #data_db.append(buffer)
                    data_db.append(bufToDict(buffer))
                buffer = ""
            buffer += d+"\t"
        with open("relic.json",'w') as wf:
            wf.write(json.dumps(data_db))

def datClassify():# json data classify
    with open("relic.json",'r') as f:
        jsonDat = json.loads(f.read())
        tmp = {}
        for relic in jsonDat:
            if not relic["class"] in tmp:
                tmp[relic["class"]] = []
            tmp[relic["class"]].append(relic)
        #save all classified relic json file
        for k in tmp.keys():
            print(k)
            with open("relic_%s.json"%k,'w') as wf:
                wf.write(json.dumps(tmp[k]))

def GenScript():
    #generate gdscript
    file = "relic_All.json"
    path = "./relic_gdscript/"
    with open(file,'r') as f:
        jsonDat = json.loads(f.read())
        for relic in jsonDat:
            fileName = relic["name"].replace(' ','_').lower()
            with open("%s%s.gd"%(path,fileName),'w') as wf:
                content = """extends Node
    #Desc:%s

    func PickUp(chara):
        pass

    func Init(chara):
        pass
                """%(relic["desc"])
                wf.write(content)

rawToJson()
datClassify()