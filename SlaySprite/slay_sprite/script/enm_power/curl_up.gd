extends Node

func init(val = 2):
	get_parent().connect("take_dmg",self,"on_take_dmg",[val])

func on_take_dmg(dmg,val):
	get_parent().GainBlock(val)
	get_parent().disconnect("take_dmg",self,"on_take_dmg")
	GlbAct.modDict({"type":"curl_up","val":val},get_parent().power)
