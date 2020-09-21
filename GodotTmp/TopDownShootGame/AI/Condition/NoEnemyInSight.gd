extends Node

const sight = 64*3

static func Condition(obj,env):
	var enms = obj.ScanEnemy(sight)
	return len(enms)<=0
