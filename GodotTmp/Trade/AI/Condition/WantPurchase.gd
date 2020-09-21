static func Condition(obj:Trader,env):
	return obj.LoadRate()<0.3&&obj.money>100
