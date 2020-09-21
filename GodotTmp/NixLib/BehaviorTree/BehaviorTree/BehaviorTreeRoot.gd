extends BT_AbstractNode

class_name BehaviorTreeRoot

var busy = false

func Run(obj,env):
	busy = true
	for c in get_children():
		if c.Condition(obj,env):
			c.Run(obj,env)
			yield(c,"finish")
			emit_signal("finish")
			busy = false
			return
	emit_signal("finish")
	busy = false
