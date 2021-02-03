class_name RandomJunk

const name_seed = [
	"Broken Weapon",
	"Broken Core",
	"Broken Tool",
	"Broken Battery",
]

static func Gen(tier):
	return {
		"name":rndName(),
		"T":tier,
		"type":"junk",
		"$":rndPrice(tier),
		"desc":"Junk",
	}

static func rndName():
	return name_seed[randi()%len(name_seed)]

static func rndPrice(tier):
	var bse = 5 + rand_range(0,5)
	for t in tier:
		bse += rand_range(5,10) * pow(1.2,tier)
	return ceil(bse)
