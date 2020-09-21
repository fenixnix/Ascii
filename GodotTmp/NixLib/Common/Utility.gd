extends Node

export var path = "res://TopDownShootGame/Image/Terrain/"
export var dstPath = "res://TopDownShootGame/Object/"

var collisionPolygon2DTmp = ""
var tmp = ""

func _ready():
	tmp = FileRW.LoadFile("res://Common/StaticObj.tmp")
	print(tmp)
	collisionPolygon2DTmp = FileRW.LoadFile("res://Common/CollisionPolygon2D.tmp")
	var fileList = FileRW.GetFileList(path,["*.png"])
	print(fileList)
	for f in fileList:
		createStaticObj(path+f,dstPath)
	#saveObjs()

func createStaticObj(filePath,dstPath):
	var baseName = filePath.get_file().get_basename()
	var img = load(filePath)
	var points = PointsFromImage(img)
	print(points)
	var pointsString = PointsToString(points,Vector2(-img.get_width()/2,-img.get_height()/2))
	var res = tmp%[filePath,baseName]
	res += pointsString
	var dstFile = dstPath + baseName + ".tscn"
	print(dstFile)
	FileRW.SaveFile(dstFile,res)

func PointsFromImage(tx):
	var bm = BitMap.new()
	bm.create_from_image_alpha(tx.get_data())
	var w = tx.get_width()
	var h = tx.get_height()
	var rect = Rect2(0,0,w,h)
	return bm.opaque_to_polygons(rect)

func PointsToString(points,offset):
	var stringTmp = ""
	var index = 0
	for o in points:
		var tmp:PoolStringArray = []
		for p in o:
			tmp.append(p.x+offset.x)
			tmp.append(p.y+offset.y)
		stringTmp += collisionPolygon2DTmp%["Collision%d"%[index],tmp.join(", ")]
		stringTmp += "\n"
		index+=1
	return stringTmp

#func createStaticObj(imgPath):
#	print("create:",imgPath)
#	var tx = load(imgPath)
#	print(tx)
#	tx.reference()
#	tx.resource_path = imgPath
#	print(tx.load_path)
#	print(tx.reference())
#	var obj = StaticBody2D.new()
#	var spr = Sprite.new()
#	var col = CollisionShape2D.new()
#	add_child(obj)
#	obj.add_child(spr)
#	obj.add_child(col)
#	obj.name = imgPath.get_basename()
#	spr.texture = Resource.
#	spr.texture = StreamTexture.new()
#	spr.texture.resource_path = tx.resource_name
#	spr.texture.load(tx.load_path)
#	col.shape = RectangleShape2D.new()
#
#func saveObjs():
#	for c in get_children():
#		var pack = PackedScene.new()
#		setOwner(c,c)
#		pack.pack(c)
#		ResourceSaver.save("%s%s.tscn"%[dstPath,c.name],pack)

func setOwner(owner,node):
	if owner!=node:
		node.owner = owner
	for c in node.get_children():
		setOwner(owner,c)
