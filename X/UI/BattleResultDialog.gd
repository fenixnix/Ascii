extends Control

signal confirm()

func Set(dat):
	$Label.text = dat.title
	$RichTextLabel.bbcode_enabled = true
	$RichTextLabel.bbcode_text = dat.text

func _on_OK_pressed():
	emit_signal("confirm")
	GlbUi.Pop()
