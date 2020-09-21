tool
extends TextureRect

export(Image) var src
export var tileSize = Vector2.ONE*8
export var gridSize = Vector2.ONE*64
export var gridOffset = Vector2.ONE*64
export var startPoint = Vector2.ZERO

var txSize
var rects

signal select_rect(img,rect)

func _ready():
	Refresh()
	update()

func _draw():
	draw()

func draw():
	for rt in rects:
		draw_rect(rt,Color.green,false)

func Refresh():
	txSize = Vector2(src.get_width(),src.get_height())
	rects = GetRects(tileSize,gridOffset,startPoint,gridSize)

func LoadImage(filePath):
	src = Image.new()
	src.load(filePath)
	var tx = ImageTexture.new()
	tx.create_from_image(src)
	texture = tx

func GetRects(tileSize,gridOffset,startPoint,gridSize):
	return getRectSet(getTopLeftSet(tileSize,gridOffset),startPoint,gridSize)

func getRectSet(tlSet,startPoint,gridSize):
	var tmp = []
	for tl in tlSet:
		tmp.append(Rect2(tl+startPoint,gridSize))
	return tmp

func getTopLeftSet(size = Vector2.ONE*8,gridOffset = Vector2.ONE*64):
	var tmp = []
	for row in size.y:
		for col in size.x:
			tmp.append(Vector2(gridOffset.x*col,gridOffset.y*row))
	return tmp

func FindRect(pt):
	for rt in rects:
		if rt.has_point(pt):
			return rt
	return null

func _on_SrcSheet_gui_input(event):
	if event is InputEventMouse:
		if event.is_pressed() && event.doubleclick:
			var clkPt = get_global_mouse_position() - get_global_rect().position
			var rt = FindRect(clkPt)
			if rt!=null:
				emit_signal("select_rect",src,rt)
