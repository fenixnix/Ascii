import json
import copy

imgRootPath = "res://images/ships/"

pirate_lst = [
    ""
]

cls = ["tac","eng","sci"]

race = "Pirate"
dat_lst = []
for n in pirate_lst:
    dat = {
        "id":"priate_fighter",
        "name":n,
        "img": imgRootPath + "pirate_fighter.png",
        "info":{
            "race":race,
            "cls":"",
            "tier":0
        },
        "status":{
            "hull":200,
            "acc":10,
            "evd":15,
            "crt":3,
            "spd":40
        },
        "wpns":[
            1
        ],
        "resist":[

        ]
    }
    dat_lst.append(dat)

name_dict = {
    "tac":"Tactical",
    "eng":"Engineering",
    "sci":"Science"
}

def GenShipSet(id,name):
    dat_lst = []
    for i in range(1,6):
        for t in ["tac","eng","sci"]:
            sid = "%s_%s_%d"%(id,t,i)
            dat = {
                "id":sid,
                "name":"%s %s"%(name,name_dict[t]),
                "img": "%s%s.png"%(imgRootPath,sid),
                "info":{
                    "race":name,
                    "cls":name_dict[t],
                    "tier":i
                },
                "status":{
                    "hull":int(200*1.8**i),
                    "acc":0,
                    "evd":0,
                    "crt":0,
                    "spd":40
                },
                "wpns":[
                    1
                ],
                "resist":[

                ]
            }
            dat_lst.append(dat)
    return dat_lst

keyDict = {
    "Tactical":"tac",
    "Engineering":"eng",
    "Science":"sci"
}

terranNameList = [
    "Marksman","Rogue","Knight","Warder","Disciple","Acolyte",
    "Archer","Ronin","Crusader","Guardian","Sorcerer","Magus",
    "Ranger","Assassin","Paladin","Gallant","Witch","Conjurer",
    "Hunter","Ninja","Protector","Exemplar","Warlock","Enchanter",
    "Marksman","Rogue","Knight","Warden","","",
]

def GenTerranShips():
    with open("ship.json","r") as f:
        jdat = json.loads(f.read())
        new_list = []
        for tier in range(2,5):
            for s in jdat[1:7]:
                ship = copy.deepcopy(s)
                ship["img"] = imgRootPath + keyDict[ship["info"]["cls"]] + "_%d.png"%tier
                ship["info"]["tier"] = tier
                new_list.append(ship)
                print(s["name"])
        return new_list



# for s in GenShipSet("pir","Pirate"):
#     dat_lst.append(s)

# with open("pirate_ship.json","w") as f:
#     f.write(json.dumps(dat_lst))

#print(GenTerranShips())

# with open("ship.json","r") as f:
#     dat = json.loads(f.read())
#     for s in dat:
#         if "time" in s["cost"]:
#             s["time"] = s["cost"]["time"]
#             del s["cost"]["time"]
#     with open("ship_mod.json","w") as ff:
#         ff.write(json.dumps(dat))
    