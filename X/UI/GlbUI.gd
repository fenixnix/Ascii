extends CanvasLayer

var ui_queue = []
var ui_map = {}

func _init():
	pause_mode = Node.PAUSE_MODE_PROCESS
	layer = 2

func ShowSiteTip(site):
	var lab = load("res://UI/SiteInfoTip.tscn").instance()
	add_child(lab)
	lab.Set(site)
	#lab.rect_position = lab.get_global_mouse_position() + Vector2.ONE*32
	lab.show()
	return lab

func ShowSiteInfo(site):
	if GlbDat.player_teams.has(site.team):
		$"/root/Main/StarMap/MainCam".MoveTo(site.position)
		return PushUI("SiteInfoView",site)
	else:
		return PushUI("SiteViewEnm",site)

var root_path = "res://UI/%s.tscn"

func Show(file,dat):
	var ui = load(root_path%file).instance()
	add_child(ui)
	ui.Set(dat)
	ui.show()
	return ui

func SetUI(file,dat,key):
	var ui = load(root_path%file).instance()
	ui.Set(dat)
	add_child(ui)
	ui_map[key] = ui
	return ui

func EraseUI(key):
	ui_map[key].queue_free()
	ui_map.erase(key)

func PushUI(file,dat):
	var ui = load(root_path%file).instance()
	Push(ui)
	ui.Set(dat)
	return ui

func OverlapUI(file,dat):
	var ui = load(root_path%file).instance()
	Overlap(ui)
	ui.Set(dat)
	return ui

func ChangeUI(file,dat):
	Pop()
	PushUI(file,dat)

func Push(ui):
	if !ui_queue.empty():
		ui_queue.back().hide()
	add_child(ui)
	ui_queue.push_back(ui)
	ui.show()

func Overlap(ui):
	add_child(ui)
	ui_queue.push_back(ui)
	ui.show()

func Pop():
	if !ui_queue.empty():
		ui_queue.pop_back().queue_free()
	if !ui_queue.empty():
		ui_queue.back().show()

func Change(ui):
	Pop()
	Push(ui)
