extends WindowDialog

onready var itmLst = $ItemList

var project_path = "D:/3D DATA/ZWCNAuto3D/XM/20200727/"

var lst = []

signal select_file(path)

func Open():
	popup_centered()
	dir_contents(project_path)

func dir_contents(path):
	itmLst.clear()
	lst.clear()
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir()&&file_name!="."&&file_name!='..'&&file_name!="TempGroup":
				var localPath = path+file_name+"/thumbmesh.jpg"
				print("thumbmesh:" + localPath)
				var img = Image.new()
				img.load(localPath)
				var tx = ImageTexture.new()
				tx.create_from_image(img)
				itmLst.add_item(file_name,tx)
				lst.append(localPath)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _on_ItemList_item_activated(index):
	emit_signal("select_file",lst[index])
	hide()
