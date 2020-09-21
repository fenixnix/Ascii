extends Control

onready var srcSheet = $HBoxContainer/ScrollContainer2/SrcSheet
onready var dstSheet = $HBoxContainer/ScrollContainer/DstSheet

func _ready():
	srcSheet.LoadImage("res://colored.png")
	$Panel/Root/List.Init(srcSheet)

func _on_ToolButton_toggled(button_pressed):
	$Panel/Root/List.visible = button_pressed

func _on_SrcSheet_select_rect(img,rect):
	$HBoxContainer/ScrollContainer/DstSheet.AddTile(img,rect)

func _on_Save_pressed():
	$SaveDialog.popup_centered_ratio()
	var file = yield($SaveDialog,"file_selected")
	$HBoxContainer/ScrollContainer/DstSheet.SaveTileSheet(file)

func _on_Load_pressed():
	$LoadDialog.popup_centered_ratio()
	var file = yield($LoadDialog,"file_selected")
	srcSheet.LoadImage(file)

func _on_TileSize_value_change(vec):
	srcSheet.tileSize = vec
	srcSheet.Refresh()

func _on_GridSize_value_change(vec):
	srcSheet.gridSize = vec
	dstSheet.gridSize = vec
	srcSheet.Refresh()

func _on_StartPoint_value_change(vec):
	srcSheet.startPoint = vec
	srcSheet.Refresh()

func _on_GridOffest_value_change(vec):
	srcSheet.gridOffset = vec
	srcSheet.Refresh()
