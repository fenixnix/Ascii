extends Node

class_name Palette

static func LoadFromImage(imgPath):
	var palette = {}
	var img:Image = load(imgPath).get_data()
	img.lock()
	for row in img.get_height():
		for col in img.get_width():
			var clr:Color = img.get_pixel(col,row)
			var index = (clr.r8<<16) + (clr.g8<<8) + clr.b8
			palette[index] = clr.to_html(false)
	img.unlock()
	var tmp = []
	for p in palette.values():
		tmp.append(p)
	return tmp

static func Remap(img,palette):
	var paletteVecs = calcPaletteVecs(palette)
	img.lock()
	for row in img.get_height():
		for col in img.get_width():
			var clr:Color = img.get_pixel(col,row)
			var dst = nearstColorVec(Vector3(clr.r8,clr.g8,clr.b8),paletteVecs)
			var dstClr = Color(dst)
			dstClr.a = clr.a
			img.set_pixel(col,row,dstClr)
	img.unlock()
	return img

#static func GenMap(palette):
#	var paletteVecs = calcPaletteVecs(palette)
#	var map = {}
#	for r in 0x100:
#		for g in 0x100:
#			for b in 0x100:
#				var selClr = nearstColor(Vector3(r,g,b),paletteVecs)
#				var keyClr = intToHtmlIndex(r,g,b)
#				map[keyClr] = selClr
#	return map
#
#static func Remap(img:Image,map):
#	img.lock()
#	for row in img.get_height():
#		for col in img.get_width():
#			var clr:Color = img.get_pixel(col,row)
#			var index = intToHtmlIndex(clr.r8,clr.g8,clr.b8)
#			var dstClr = Color(map[index])
#			dstClr.a = clr.a
#			img.set_pixel(col,row,dstClr)
#	img.unlock()

static func nearstColor(src:Color,palette):
	pass

static func nearstColorVec(srcColorVec:Vector3,paletteVecs):
	var minDistance = pow(0xff,6)
	var colorHtmlIndex = ""
	for p in paletteVecs:
		var distance = srcColorVec.distance_squared_to(p)
		if distance<minDistance:
			minDistance = distance
			colorHtmlIndex = intToHtmlIndex(p.x,p.y,p.z)
	return colorHtmlIndex

static func intToHtmlIndex(r:int,g:int,b:int):
	var index = (r<<16)+(g<<8)+b
	return "%6x"%[index]

static func calcPaletteVecs(palette):
	var tmp = []
	for p in palette:
		tmp.append(indexToVector3(p))
	return tmp

static func indexToVector3(colorHtml):
	var clr = Color(colorHtml)
	return Vector3(clr.r8,clr.g8,clr.b8)
