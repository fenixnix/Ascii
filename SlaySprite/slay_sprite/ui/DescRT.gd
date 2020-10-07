extends RichTextLabel

func Set(desc):
	bbcode_enabled = true
	bbcode_text = ""
	for d in desc:
		if typeof(d)==typeof("txt"):
			add_text(d+"\n")
			continue
		match d.type:
			"dmg":add_text("Duel %d Damage\n"%d.val)
			"blk":add_text("Gain %d Block\n"%d.val)
			_:add_text(str(d)+"\n")
