static func Condition(obj,env):
	var enms = obj.ScanEnemy(64*3)
	return len(enms)>0
