extends RichTextLabel

var data
var res_icon = preload("res://image/resource.png")
var sanity_icon = preload("res://image/sanity.png")
var health_icon = preload("res://image/health.png")

func Refresh(dat):
	data = dat
	bbcode_enabled = true
	clear()
	add_image(sanity_icon,32,32)
	append_bbcode("%d\t"%dat.sanDmg)
	add_image(health_icon,32,32)
	append_bbcode("%d\t"%dat.hpDmg)
	add_image(res_icon,32,32)
	append_bbcode("%d"%dat.resource)
	newline()
	append_bbcode("Deck:%d Discard:%d"%[len(dat.deck),len(dat.discard)])
	newline()
	
#	push_font(load("res://font/icon.tres"))
#	for i in range(256):
#		add_text(char(i))
#	pop()

	for card in dat.handCard:
		add_text(" ")
		push_meta(card)
		add_image(GlbDb.CardImg(card.img),120,168)
		pop()
	newline()

func _on_Status_meta_clicked(meta):
	data.handCard.erase(meta)
	Refresh(data)

var ui
func _on_Status_meta_hover_ended(meta):
	ui.queue_free()

func _on_Status_meta_hover_started(meta):
	ui = load("res://CardInfo.tscn").instance()
	get_parent().add_child(ui)
	ui.Set(meta)
