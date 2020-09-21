extends RichTextLabel

class_name ShipInfoRT

func _ready():
	Init()

func Init():
	connect("meta_hover_started",self,"on_hover_wpn_slot_begin")
	connect("meta_hover_ended",self,"on_hover_wpn_slot_end")
	connect("meta_clicked",self,"on_click_wpn_slot")

func Set(dat):
	bbcode_enabled = true
	bbcode_text = BBCode.ship(dat)
	wpn_code(dat)

func wpn_code(dat):
	bbcode_text += "[color=#80ffff][u][Weapons][/u][/color]"
	newline()
	for slot in dat.get("wpns",[]):
		if slot.slot!=null:
			push_meta(slot)
			add_image(load(slot.slot.get("icon","")))
			pop()

func on_hover_wpn_slot_begin(wpn):
	#print(wpn)
	pass

func on_hover_wpn_slot_end(wpn):
	#print(wpn)
	pass

func on_click_wpn_slot(slot):
	GlbUi.OverlapUI("InfoDlg",{"script":"res://UI/WpnInfoRT.gd","data":slot.slot})
