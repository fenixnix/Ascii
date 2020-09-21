
selection_dat = [
    {
        "efct":["enm"],
        "sel":"single"
    },
    {
        "efct":["aly"],
        "sel":"single"
    },
    {
        "efct":["enm"],
        "sel":"multi"
    },
    {
        "efct":["aly"],
        "sel":"multi"
    }
]

types = [
    "tac",
    "eng",
    "sci"
]

tier_name = ["","I","II","III","IV","V","VI","VII","VIII","IX","X"]

def SingleTargetDamageWeapons():
    lst = []
    for tier in range(6):
        #single target damage
        single_target_dmg = {
            "id":"single%d"%tier,
            "name":"Single %s"%tier_name[tier],
            "selection" : {
                "efct":["enm"],
                "sel":"single"
            },
            "efx":[
                {
                    "type":"dmg",
                    "aim":"target",
                    "dmg":30+10*tier,
                    "rnd":20
                }
            ]
        }
        lst.append(single_target_dmg)
    return lst

print(SingleTargetDamageWeapons())