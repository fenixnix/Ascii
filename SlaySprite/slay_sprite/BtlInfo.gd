extends RichTextLabel

func Set(dat):
	bbcode_enabled = true
	var hpRate = dat.hp*80/dat.mhp
	var nhpRate = 80 - hpRate
	print(hpRate," ",nhpRate)
	bbcode_text = """Block %d [img=%dx16]res://image/green_button12.png[/img][img=%dx16]res://image/whiteSquare32.png[/img] %d/%d
	"""%[
		dat.blk,hpRate,nhpRate,dat.hp,dat.mhp
	]
