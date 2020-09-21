extends RichTextLabel

export var width = 64
export var height = 24
var grid_width = 8
var grid_height = 13

var data = ""

func _ready():
	bbcode_enabled = true
	bbcode_text = ''
	bbcode_text += charTable(32,95)
	bbcode_text += charTable(0x2500,255)

func charTable(start,length):
	var txt = ""
	for i in range(length):
		if i%width == width-1:
			txt += '\n'
		var code = char(i+start)
		txt += code
	txt += "\n"
	return txt

func Set(x,y,rune):
	data[x+y*width] = rune

func _draw():
	var pixelWidth = width*grid_width
	var pixelHeight = height*grid_height
	for i in width+1:
		draw_line(Vector2(i*grid_width,0),Vector2(i*grid_width,pixelHeight),Color.green)
	for i in height+1:
		draw_line(Vector2(0,i*grid_height),Vector2(pixelWidth,i*grid_height),Color.green)
