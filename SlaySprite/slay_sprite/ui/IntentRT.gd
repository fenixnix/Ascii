extends RichTextLabel

func Set(skl,dmg):
	bbcode_enabled = true
	bbcode_text = ""
	push_align(RichTextLabel.ALIGN_CENTER)
	append_bbcode(skl.name)
	for e in skl.efx:
		if e.type == "dmg":
			append_bbcode("\n[img=32x32]%s[/img] %d"%[attack_icon(dmg),dmg])
	pop()

func attack_icon(dmg):
	var level = floor(dmg/5)
	if level>6:
		level = 6
	return "res://image/intent/tip/%d.png"%(level+1)
