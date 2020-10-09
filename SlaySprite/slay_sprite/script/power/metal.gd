extends Node

func init(owner,val):
	owner.connect("new_turn",self,"on_new_turn",[owner,val])

func on_new_turn(owner,val):
	owner.GainBlock(val)
