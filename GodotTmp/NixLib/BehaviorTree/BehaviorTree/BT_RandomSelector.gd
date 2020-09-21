extends BT_AbstractNode

class_name BT_RandomSelector

export(Script) var condition

func Run(obj,env):
	var c = get_child(RndIndex())
	if c.Condition(obj,env):
		yield(c.Run(obj,env),"completed")
	#print_debug()
	emit_signal("finish")
	yield()

func Condition(obj,env):
	if condition == null:
		return true
	return condition.Condition(obj,env)

func RndIndex():
	var sum = 0
	for c in get_children():
		sum += c.pr
	var selIndex = randi()%sum
	sum = 0
	for i in get_child_count():
		sum += get_child(i).pr
		if sum >= selIndex:
			return i
	return get_child_count()-1
