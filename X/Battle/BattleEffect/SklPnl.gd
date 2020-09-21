extends RichTextLabel

func _ready():
	Set({
		"name":"Skill Name",
		"type":"Self",
		"wu":3,
		"rcv":0,
		"cd":3,
		})

func Set(data):
	var code = '[img]res://icon.png[/img] [color=#FF00FFFF]%s[/color]\n[color=#FFFFFF00]%s[/color]\n'%[
		data.name,data.type
		]
	code += 'Warm Up: %d Recover: %d Cool Down: %d'%[data.wu,data.rcv,data.cd]
	bbcode_text = code
