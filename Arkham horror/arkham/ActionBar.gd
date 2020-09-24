extends RichTextLabel

func Set(chara):
	var code = ""
	for i in chara.at:
		code += "[img=16x16]res://image/clue.png[/img]\n"
	bbcode_text = code
