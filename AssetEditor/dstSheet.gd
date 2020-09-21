extends TextureRect

const TileSheetMaxWidth = 2048
const TileSheetMaxHeight = 2048

export var tileColume:int = 16
export var gridSize = Vector2.ONE*64

var index = 0
var maxIndex = 0
onready var image = Image.new()

func _ready():
	New()
	update()

func New():
	index = 0
	maxIndex = 0
	image.create(TileSheetMaxWidth,TileSheetMaxHeight,false,Image.FORMAT_RGBA8)

func AddTile(srcImg,rect):
	SetTile(index,srcImg,rect)
	Refresh()
	index += 1
	maxIndex = int(max(index,maxIndex))

func SetTile(index:int,srcImage,srcRect):
	image.blit_rect(srcImage,srcRect,GetTopLeftLocFromIndex(index))

func SaveTileSheet(fileName):
	var tmpImg = Image.new()
	var tmpSize = Vector2(tileColume*gridSize.x,gridSize.y*ceil(maxIndex/tileColume))
	tmpImg.create(tmpSize.x,tmpSize.y,false,Image.FORMAT_RGBA8)
	tmpImg.blit_rect(image,Rect2(Vector2.ZERO,tmpSize),Vector2.ZERO)
	tmpImg.save_png(fileName)

func GetTopLeftLocFromIndex(index:int):
	var x = index%tileColume
	var y = index/tileColume
	return Vector2(x*gridSize.x,y*gridSize.y)

func Refresh():
	var tx = ImageTexture.new()
	tx.create_from_image(image)
	texture = tx
	update()

func PointToIndex(pt):
	var gridPos = (pt/gridSize).floor()
	return gridPos.x + gridPos.y*tileColume

func _on_DstSheet_gui_input(event):
	if event is InputEventMouse:
		if event.is_pressed() && event.doubleclick:
			var clkPt = get_global_mouse_position() - get_global_rect().position
			var id = PointToIndex(clkPt)
			if id != null:
				index = id
				update()

func _draw():
	var tl = GetTopLeftLocFromIndex(index)
	draw_rect(Rect2(tl,gridSize),Color(0,1,0,.5),false)
