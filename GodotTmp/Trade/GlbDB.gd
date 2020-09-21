extends Node

var itmDb = []

func RndItem():
	var tmp = {"name":RndName()}
	tmp["price"] = randi()%1000
	tmp['wt'] = randi()%99/10.0 + 0.1
	tmp["stack"] = (1+randi()%15)*8
	return tmp

func RndName():
	var length = randi()%6+3
	var tmp = ''
	for i in length:
		tmp += char(randi()%26+65)
	return tmp

func GenItmDB(cnt):
	itmDb.clear()
	for i in cnt:
		itmDb.append(RndItem())
	#print(itmDb)
