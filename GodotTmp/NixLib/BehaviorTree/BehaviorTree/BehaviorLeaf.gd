extends BT_AbstractNode

class_name BehaviorLeaf

export(Script) var conditionScript
export(Script) var actionScript
export var pr = 5

func Condition(obj,env):
	if conditionScript == null:
		return true
	return conditionScript.Condition(obj,env)

func Run(obj,env):
	yield(actionScript.Run(obj,env),"completed")
	emit_signal("finish")
