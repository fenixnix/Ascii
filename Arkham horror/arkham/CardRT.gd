extends RichTextLabel

var data

func Set(dat):
	data = dat
	refresh()
	
func refresh():
	print(data)
	clear()
	newline()
	newline()
	push_align(RichTextLabel.ALIGN_CENTER)
	add_image(GlbDb.CardImg(data.get("img","")))
	pop()
