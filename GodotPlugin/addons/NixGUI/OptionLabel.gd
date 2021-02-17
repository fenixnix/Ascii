extends RichTextLabel

class_name OptionLabel,"res://addons/NixGUI/icon/icon_print_text.svg"

signal select(index)

func _ready():
	bbcode_enabled = true
	fit_content_height = true
	scroll_active = false
	connect("meta_clicked",self,"on_meta")

func Select(list, desc = ''):
	clear()
	parse_bbcode(desc)
	newline()
	push_selection(list)

func push_selection(list):
	var index = 0
	for l in list:
		push_align(RichTextLabel.ALIGN_CENTER)
		push_meta(index)
		push_underline()
		add_text(tr(l)+'\n')
		pop()
		newline()
		index += 1

func on_meta(meta):
	#print_debug("select:%d"%meta)
	emit_signal("select",meta)
