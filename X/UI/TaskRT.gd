extends RichTextLabel

class_name TskRT

func _ready():
	bbcode_enabled = true

func Set(tsk):
	var ofc_code = ""
	if tsk.has("ofc"):
		ofc_code = "%s\n[img]%s[/img]"%[tsk.ofc.name,tsk.ofc.icon]
	
	bbcode_text = """[center]
[font=res://font/led_font.tres]%s[/font]

%s

[color=#00ff00]%s[/color]
%3d%%

%s %d Hour
[/center]"""%[
	tsk.get("title","Exploring"),
	ofc_code,
	BBCode.bar_full(tsk.progress,128),
	floor(tsk.progress*100),
	GlbDb.FontIcon("time"),tsk.time*(1-tsk.progress)
]
