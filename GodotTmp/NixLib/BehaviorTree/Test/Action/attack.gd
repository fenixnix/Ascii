static func Run(obj,env):
	obj.Attack()
	yield(obj,"attack_finish")
