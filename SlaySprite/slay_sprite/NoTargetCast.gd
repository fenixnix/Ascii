extends Control

func can_drop_data(position, data):
	return data.data.type!="Attack"

func drop_data(position, data):
	GlbAct.PlayCard(data.data,data)
