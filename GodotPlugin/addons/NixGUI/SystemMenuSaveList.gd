extends VBoxContainer

var cmd

signal action(cmd,index)

func Save():
	cmd = "save"
	$New.show()
	refresh_list()

func Load():
	cmd = "load"
	$New.hide()
	refresh_list()

func refresh_list():
	show()
	$SaveList.clear()
	#TODO show Save List
#	for s in SL.SavLst():
#		$SaveList.add_item("[%s]:%s"%[str(s.dt),s.id])

func _on_SaveList_item_activated(index):
	emit_signal("action",cmd,index)
	hide()

func _on_New_pressed():
	emit_signal("action","new",null)
	hide()

func _on_SaveList_item_rmb_selected(index, at_position):
	emit_signal("action","del",index)

func _on_Close_pressed():
	hide()
