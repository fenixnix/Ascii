extends Area2D

class_name Site

var name_text = "site"
var population = 1000
var wealth = 0

var productions = []
var shopList = []

func RndGen(products):
	population = 100 + randi()%1000
	name_text = GlbDb.RndName()+ ' Town'
	productions = products
	for p in productions:
		var dat = GlbDb.itmDb[p]
		shopList.append({'id':p,"cnt":dat.stack})

func Tick(turn):
	for t in turn/8:
		for p in productions:
			AddCommodity(p)

func AddCommodity(id):
	for i in len(shopList):
		if shopList[i].id == id:
			shopList[i].cnt += 1
			return
	shopList.append({"id":id,"cnt":1})

func Take(index):
	shopList[index].cnt -= 1
	if shopList[index].cnt <=0:
		shopList.remove(index)

func RecommandPrice(id):
	var dat = GlbDb.itmDb[id]
	return calcPrice(dat.price,(storage(id)+1)/float(dat.stack))

func SiteInfoString():
	return '%s\nPopulation'

func storage(id):
	for i in shopList:
		if i.id == id:
			return i.cnt
	return 0

func calcPrice(rcPrice,storageRate:float):
	var scale = pow(1.1,pow(1/storageRate,0.3))
	return rcPrice * scale
