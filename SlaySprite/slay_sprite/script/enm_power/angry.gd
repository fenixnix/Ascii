extends Node

func init(val = 2):
	get_parent().connect("take_dmg",self,"on_trig",[val])

func on_trig(card,val):
	get_parent().ModAttr({"type":"str","val":val})
