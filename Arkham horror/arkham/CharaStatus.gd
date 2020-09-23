extends RichTextLabel

var data

func Set(dat):
	data = dat
	bbcode_enabled = true
	refresh()
	
func refresh():
	for chara in data:
		bbcode_text += charaInfo(chara)

func charaInfo(chara):
	var code = """[center]%s[/center]
	[color=#008080]%d [font=res://font/icon.tres]p[/font][/color] [color=#f0f000]%d [font=res://font/icon.tres]b[/font][/color] [color=#e00000]%d [font=res://font/icon.tres]c[/font][/color] [color=#00e000]%d [font=res://font/icon.tres]a[/font][/color]
	Sanity: %d/%d, Health: %d/%d
	"""%[
		chara.name,
		chara.W,chara.I,chara.C,chara.A,
		chara.san,chara.SAN,chara.hp,chara.STA
	]
	return code 
