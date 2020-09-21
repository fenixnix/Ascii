extends PanelContainer

signal gen_maze(maze_data)

func _ready():
	pass
#	var tree = $Node/Tree
#	var root = tree.create_item()
#	tree.set_hide_root(true)
#	var child1 = tree.create_item(root)
#	var child2 = tree.create_item(root)
#	var subchild1 = tree.create_item(child1)
#	subchild1.set_text(0, "Subchild1")
#	var subObj = tree.create_item(child2)
#	subObj.set_button(2,0,null)

func _on_Start_pressed():
	GlbAudio.PlayUISfx("res://Audio/UI/confirmation_001.ogg")
	emit_signal("gen_maze",$List/ScrollContainer/Data.GetData())
	queue_free()


func _on_Back_pressed():
	MazeGlb.UITitleMenu()
	queue_free()
