class_name PG_Def

const max_width:int = 4096
const MAX_W = 4096

#grid neighbour order``

#012
#345
#678

# $ deep sea
# ~ sea
# - lake
# . land
# ^ mountain
# # wall
# " swamp
# : desert
# * snow
# ! forest

# P port
# S site
# C cave

enum Temp{warm,warm_prime,cold,hot}
enum Ecology{plain,forest,desert,marsh}
enum SiteType{empty,settlement,cave,dungeon}

const warmPrimEco = {Ecology.plain:40,Ecology.forest:30,Ecology.desert:30}
const warmEco = {Ecology.plain:30,Ecology.forest:30,Ecology.desert:30,Ecology.marsh:10}
const hotEco = {Ecology.plain:25,Ecology.forest:40,Ecology.desert:35}
const coldEco = {Ecology.plain:60,Ecology.forest:40}

const ecoCharList = [".","!",":",'"']
const siteCharList = ["E","S","C","D"]

static func Vec2Index(vec:Vector2)->int:
	return int(vec.x + vec.y * max_width)
	
static func Index2Vec(index:int)->Vector2:
	return Vector2(index%max_width,index/max_width)

static func PosToIndex(x,y):
	return x+y*MAX_W
	
static func GenerateEcology(cnt,temp = Temp.warm_prime):
	var tmp = []
	var weight = []
	match temp:
		Temp.warm:
			weight = warmEco
		Temp.warm_prime:
			weight = warmPrimEco
		Temp.hot:
			weight = hotEco
		Temp.cold:
			weight = coldEco
	for i in cnt:
		tmp.append(ecoCharList[WeightedRandom(weight)])
	return tmp

static func WeightedRandom(list):
	var tmpList = []
	for k in len(list.keys()):
		for w in list[list.keys()[k]]:
			tmpList.append(k)
	var key = randi()%tmpList.size()
	return list.keys()[tmpList[key]]

static func GenRndPointsInArea(width:int, height:int, count):
	var tmp = []
	for i in count:
		tmp.append(Vector2(randi()%width,randi()%height))
	return tmp
