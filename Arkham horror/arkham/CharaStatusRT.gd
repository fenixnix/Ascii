extends RichTextLabel

var data

func Set(dat):
	bbcode_enabled = true
	data = dat
	refresh()

func refresh():
	bbcode_text = """[color=#008080] %d [font=res://font/icon.tres]p[/font][/color] [color=#f0f000] %d [font=res://font/icon.tres]b[/font][/color]
[color=#e00000] %d [font=res://font/icon.tres]c[/font][/color] [color=#00e000] %d [font=res://font/icon.tres]a[/font][/color]

[img=16x16]res://image/sanity.png[/img] %d/%d [img=16x16]res://image/health.png[/img] %d/%d
[img=16x16]res://image/clue.png[/img] %d [img=16x16]res://image/resource.png[/img] %d
	"""%[
		data.data.W,data.data.I,data.data.C,data.data.A,
		data.san,data.data.SAN,data.hp,data.data.STA,
		data.clue,data.res,
	]
