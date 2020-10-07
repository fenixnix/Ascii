extends RichTextLabel

func Set(skl,dmg):
	bbcode_enabled = true
	for e in skl.efx:
		if e.type == "dmg":
			append_bbcode("[img=32x32]%s[/img] %d"%[attack_icon(dmg),dmg])

func attack_icon(dmg):
	var level = floor(dmg/5)
	if level>6:
		level = 6
	return "res://image/intent/attack/attack_intent_%d.png"%(level+1)
