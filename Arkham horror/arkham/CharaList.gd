extends HBoxContainer

var charaLabelPrefab = preload("res://CharaLabel.tscn")

signal select(chara)

func Init(charaList):
	for c in get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	for c in charaList.get_children():
		var lab = charaLabelPrefab.instance()
		add_child(lab)
		lab.Set(c)
		lab.connect("select",self,"on_select")

func on_select(chara):
	emit_signal("select",chara)
