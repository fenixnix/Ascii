extends Control

func drop_data(_position, data):
	GlbAct.PlayCard(data.data,get_parent())

func can_drop_data(_position, data):
	return true
