extends Node

class_name NixRnd

static func RandIndexByRate(rateList):
	var rate_sum = 0
	for r in rateList:
		rate_sum+=r
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
