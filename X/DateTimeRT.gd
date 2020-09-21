extends RichTextLabel

func _ready():
	bbcode_enabled = true
	connect("meta_clicked",self,"on_toggle")

func _physics_process(delta):
	clear()
	push_align(RichTextLabel.ALIGN_CENTER)
	push_font(load("res://font/led_font.tres"))
	append_bbcode("%s "%GlbTime.PrintDateTime())
	push_meta("")
	if GlbTime.running:
		append_bbcode("||")
	else:
		append_bbcode(">")
	pop()
	pop()

func on_toggle(meta):
	GlbTime.running = !GlbTime.running
