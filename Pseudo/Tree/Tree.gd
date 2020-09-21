extends Control

func _ready():
	#var tree = Tree.new()
	var tree = $Tree
	var root = tree.create_item()
	tree.set_hide_root(true)
	var child1 = tree.create_item(root)
	child1.set_text(0,"child1")
	child1.set_text(1,"child11")
	var child2 = tree.create_item(root)
	child2.set_text(0,"child2")
	var subchild1 = tree.create_item(child1,2)
	subchild1.set_text(0, "Subchild1")
	subchild1.set_text(1, "hello")
