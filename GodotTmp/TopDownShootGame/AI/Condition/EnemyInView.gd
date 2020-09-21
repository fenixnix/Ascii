static func Condition(obj,env):
	var enms = obj.ScanEnemy(64*8)
	return len(enms)>0
