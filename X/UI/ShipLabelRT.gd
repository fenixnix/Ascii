extends RichTextLabel

var data

func Set(ship_data):
	bbcode_enabled = true
	data = ship_data
	refresh()

func refresh():
	var text = """
[center]%s
[s]%s[/s]

[img=0x32]%s[/img]
[color=#ffff00]%s[/color][/center]
"""%[
	data.name,
	' '.repeat(32),
	data.img,
	BBCode.bar_full(data.hp,64)
]
	bbcode_text = text
