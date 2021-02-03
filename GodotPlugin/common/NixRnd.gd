extends Node

class_name NixRnd

static func RandDictKeyByRate(dict):
	return dict.keys()[RandIndexByRate(dict.values())]

static func RandIndexByRate(rateList):
	var rate_sum = 0
	for r in rateList:
		rate_sum += r
	var val = randi()%rate_sum
	var cnt = 0
	var index = 0
	for r in rateList:
		cnt += r
		if cnt>val:
			return index
		index += 1
	return 0

static func RandInt(base,rnd_rate):
	var rndVal = base*rnd_rate
	return base + floor(rand_range(-rndVal,rndVal))

static func RandAffix(express,tier):
	var exp_tmp = str(express)
	if "t" in exp_tmp:
		exp_tmp = exp_tmp.replace("t","%d")%tier
	var res = 0
	if "+" in exp_tmp:
		var pair = exp_tmp.split("+")
		res += int(RandRange(pair[0]))
		exp_tmp = pair[1]
	var cnt = 1
	if "*" in exp_tmp:
		var pair = exp_tmp.split("*")
		cnt = int(pair[1])
		exp_tmp = pair[0]
	for c in cnt:
		res += RandRange(exp_tmp)
	return res

static func RandSelectInString(express):
	if "|" in express:
		var pair = express.split("|")
		return pair[randi()%len(pair)]
	else:
		if ";" in express:
			var pair = express.split(";")
			return pair[randi()%len(pair)]
	return express

static func RandSelectInArray(express):
	var size = len(express)
	if size>0:
		return express[randi()%len(express)]
	return null

static func RandRange(express):
	if "~" in express:
		var pair = express.split("~")
		var bse = int(pair[0])
		var maxVal = int(pair[1])+1
		return bse + randi()%(maxVal-bse)
	else:
		return int(express)

static func CheckRate(rate):
	return randi()%100<rate
