extends CanvasLayer

func Set(dat={
	"chara":{"img":"res://image/01001.png"},
	"type":"W",
	"chaos":"",
	"dst":3
}):
	$root/img.texture = GlbDb.CardImg(dat.chara.data.img)
	$root/code.bbcode_text = "%s %s %d"%[
		GlbDb.attr_icon_dict[dat.type]%dat.chara.GetAttr(dat.type),dat.chaos,dat.dst]
	$root.show()

func _on_OK_pressed():
	$root.hide()
