extends Node

class_name Officer

static func RandGen():
	match randi()%3:
		0:return randGenEng()
		1:return randGenSci()
		2:return randGenTac()

static func randGenTac():
	var base = randGenBase()
	base.cls = "tac"
	base.TAC = rand_rangei(35,40)
	return base

static func randGenEng():
	var base = randGenBase()
	base.cls = "eng"
	base.ENG = rand_rangei(35,40)
	return base

static func randGenSci():
	var base = randGenBase()
	base.cls = "sci"
	base.SCI = rand_rangei(35,40)
	return base

static func randGenBase():
	return {
		"name":RandomName.numName(),
		"icon":rndPortrait(),
		"lv":0,
		"exp":1,
		"DIP":rand_rangei(10,15),
		"ENG":rand_rangei(10,15),
		"SCI":rand_rangei(10,15),
		"TAC":rand_rangei(10,15),
		"skills":[]
	}

static func rndPortrait():
	var path = "res://images/portrait/"
	var list = FileRW.GetFileList(path,["*.png"])
	return path + list[randi()%len(list)]

static func TimeReduce(officer_dat,task_needs):
	var totel_needs:float = 0
	var rest_needs:float = 0
	for t in task_needs.keys():
		var rest = task_needs[t]-officer_dat.get(t,0)
		if rest>0:
			rest_needs += rest
		totel_needs += task_needs[t]
	return rest_needs/totel_needs

static func rand_rangei(a,b):
	return floor(rand_range(a,b))
