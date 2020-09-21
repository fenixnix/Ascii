import os
import json

def ChangeType(file):
    with open("%s.json"%file,"r+") as f:
        data = f.read()
        jDat = json.loads(data)
        for w in jDat:
            w["type"] = "tac"
            print(w["name"])
        with open("%s_new.json"%file,"w") as fWrite:
            fWrite.write(json.dumps(jDat))

tac_wpn_lst = [
    "Bullseye"
    "Cripping Shot"
    "Disabling Strike"
    "Focused Beam"
    "Harass"
    "Missle Swarm"
    "Strafing Run"
    "Targeting Support"
    "Teleport Explosive"
    "Munitions Backfire"
    "Seeker Missles"
    "Triple Shot"
]

sci_wpn_lst = [
    "Adpative Armour",
    "Cauterize Hull",
    "Psionic Storm",
    "Upload Virus",
    "Incisor Beam",
    "Portal Cannon",
    "Protective Field",
    "Systems Overload",
    "Torture",
    "Void Spatter",
    "Disruptor Beam",
    "Wrap Storm"
    ]

eng_wpn_lst = [
    "Acid Bombs",
    "Brace",
    "Deconstruct",
    "Shock Mine",
    "Flak Barrage",
    "Instant Repairs",
    "Disintegrate Hull",
    "Release Mines",
    "Repair Drone",
    "Disable Countermeasures",
    "Eruption",
    "Shield Disruptor"
]

def AppendWpns(name_list,type):
    lst = []
    for n in name_list:
        dat = {
            "id":n.lower().replace(' ','_'),
            "name":n,
            "img":"",
            "anim":"",
            "type":type,
            "affix":["enm"],
            "select":"single",
            "efx":[]
        }
        lst.append(dat)
    return lst

def CombineDat(src,dst):
    dst_dat = []
    for s in src:
        with open(s,'r') as f:
            jDat = json.loads(f.read())
            for j in jDat:
                dst_dat.append(j)
    with open(dst,'w') as f:
        f.write(json.dumps(dst_dat))

# jDat = AppendWpns(sci_wpn_lst,"sci")
# with open("sci_wpn.json","w") as f:
#     f.write(json.dumps(jDat))

# jDat = AppendWpns(eng_wpn_lst,"eng")
# with open("eng_wpn.json","w") as f:
#     f.write(json.dumps(jDat))

#ChangeType("wpn")

CombineDat(["tac_wpn.json","eng_wpn.json","sci_wpn.json"],"wpn.json")