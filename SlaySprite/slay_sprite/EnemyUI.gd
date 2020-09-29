extends Control

func drop_data(position, data):
	GlbAct.PlayCard(data.data,get_parent())

func can_drop_data(position, data):
	return true
