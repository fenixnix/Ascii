extends RichTextLabel

signal select(index)

var menu
var highlight = {}

func _ready():
	connect("meta_clicked",self,"on_click")
	connect("meta_hover_started",self,"on_enter")
	connect("meta_hover_ended",self,"on_exit")

func on_click(index):
	emit_signal("select",index)

func on_enter(index):
	highlight[index] = true
	refresh(menu)

func on_exit(index):
	highlight[index] = false
	refresh(menu)

func Set(_menu):
	menu = _menu
	highlight.clear()
	bbcode_enabled = true
	refresh(menu)

func refresh(menu):
	clear()
	append_bbcode("Select:\n")
	var index = 0
	for m in menu:
		newline()
		add_text("    * ")
		push_meta(index)
		if highlight.get(index,false):
			append_bbcode("[color=#00ff00]%s[/color]"%m)
		else:
			append_bbcode("%s"%m)
		pop()
		newline()
		index+=1
	update()
