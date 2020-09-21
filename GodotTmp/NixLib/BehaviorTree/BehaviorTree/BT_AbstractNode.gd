extends Node

class_name BT_AbstractNode

signal finish()

func Run(obj,env):
	if !Condition(obj,env):
		emit_signal("finish")
	yield(Exec(),"completed")
	emit_signal("finish")

func Condition(obj,env):
	return true

func Exec():
	pass
