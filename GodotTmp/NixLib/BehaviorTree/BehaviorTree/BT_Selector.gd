extends BT_AbstractNode

class_name BT_Selector

export(Script) var condition

func Run(obj,env):
	for c in get_children():
		if c.Condition(obj,env):
			yield(c.Run(obj,env),"completed")
			break
	#print_debug()
	emit_signal("finish")

func Condition(obj,env):
	if condition == null:
		return true
	return condition.Condition(obj,env)
