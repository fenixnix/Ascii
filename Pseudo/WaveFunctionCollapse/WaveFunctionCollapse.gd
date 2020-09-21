extends Control

func _ready():
	Learn("res://WaveFunctionCollapse/Flowers.png",3,3)

func Learn(file,width,height):
	var tx:StreamTexture = load(file)
	var img:Image = tx.get_data()
	print(img)
	for y in tx.get_height() - height:
		for x in tx.get_width() - width:
			var pattern = Image.new()
			pattern.create(width,height,false,Image.FORMAT_RGB8)
			pattern.blit_rect(img,Rect2(x,y,width,height),Vector2.ZERO)
			pattern.save_png("Pattern/pattern[%d,%d].png"%[x,y])
	var colorList = GetColorList(img)
	var C = colorList.size()
	var W = pow(C,width*height)
	#统计所有模板，所有模板出现的概率

#Pattern =>8 rotate 4 + reflect4

func GetColorList(img:Image):
	var colorList = []
	for y in img.get_height():
		for x in img.get_width():
			var clr = img.get_pixel(x,y)
			if !colorList.has(clr):
				colorList.append(clr)
	return colorList
