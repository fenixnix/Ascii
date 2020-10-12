extends Node

func init(val = 2):
	get_parent().connect("new_turn",self,"on_new_turn",[val])

func on_play(turn,val):
	get_parent().GainBlock(val)
