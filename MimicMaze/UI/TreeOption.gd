extends Control

var data = {}

onready var tree = $Tree

func _ready():
	Set({
		tr("language"):"en",
		tr("grapic"):{
			tr("resolution"):"800*600",
			tr("fullscreen"):false,
		},
		tr("audio"):{
			tr("BGM"):0,
			tr("SFX"):0,
		},
	})

func Set(dat):
	data = dat
	Refresh()
	
func Refresh():
	tree.clear()
	tree.columns = 5
	var root = tree.create_item()
	tree.set_hide_root(true)
	AddBranch(root,data)

func AddBranch(branch,json):
	for k in json.keys():
		var child = tree.create_item(branch)
		child.set_text(0,k)
		match typeof(json[k]):
			1:
				child.set_cell_mode(1,TreeItem.CELL_MODE_CHECK)
				child.set_text(1,str(json[k]))
				child.set_editable(1,true)
			2:
				child.set_cell_mode(1,TreeItem.CELL_MODE_RANGE)
				child.set_range(2,json[k])
				child.set_range_config(2,-80,20,1)
				child.set_editable(1,true)
			4:
				child.set_cell_mode(1,TreeItem.CELL_MODE_CUSTOM)
				child.set_custom_draw(1,Button.new(),"call")
				child.set_text(1,str(json[k]))
				child.set_editable(1,true)
			18:AddBranch(child,json[k])
			_:print(json[k],typeof(json[k]))

func call(text):
	print("call")
