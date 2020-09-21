extends Control

var data

var current_train_id

func _ready():
	$VBoxContainer/ItemList.clear()
	for o in GlbDb.ofcDB:
		$VBoxContainer/ItemList.add_item(GlbDb.cls_dict[o.id],load(o.get("icon","")))

func Set(dat):
	data = dat
	refresh()

func refresh():
	$OfficerRT.Set(data.get("ofc",{}))
	$AcademyRT.Set(data)

func _on_edit_pressed():
	var ui = GlbUi.OverlapUI("OfcSelUI",GlbDat.currentSite.ofcs)
	ui.connect("select",self,"on_select_ofc")

func on_select_ofc(ofc):
	data.ofc = ofc
	refresh()

func _on_ItemList_item_activated(index):
	if !data.has("task"):
		data.task = []
	var tsk = {"progress":0}
	tsk.item = GlbDb.ofcDB[index].duplicate(true)
	data.task.append(
		tsk
	)
	refresh()

func _on_ItemList_item_selected(index):
	current_train_id = index

func _on_Training_pressed():
	_on_ItemList_item_activated(current_train_id)

func _on_AcademyRT_select(task):
	#cancel task
	data.task.erase(task)
	refresh()
