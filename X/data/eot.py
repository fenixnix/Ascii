import json

eot_lst =[
    "Sensors Offline",
    "Engines Down",
    "Crew Panic",
    "Hull Breach",
    "Ship Diable",
    "Vulnerable",
    "Weapons Disruption"
]

dat_lst = []
for n in eot_lst:
    dat = {
        "id":n.lower().replace(' ','_'),
        "name":n,
        "ico":"",
        "time":3,
        "efx":[]
    }
    dat_lst.append(dat)

with open("eot_debuff.json",'w') as f:
    f.write(json.dumps(dat_lst))