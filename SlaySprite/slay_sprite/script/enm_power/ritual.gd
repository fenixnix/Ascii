extends Node

func init(val = 2):
	get_parent().connect("end_turn",self,"on_end_turn",[val])

func on_end_turn(turn,val):
	get_parent().ModAttr({"type":"str","val":val})
