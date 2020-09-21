extends RichTextLabel

class_name FacilityBuildInfoRT

func Set(dat):
	bbcode_enabled = true
	var txt = """
[center][font=%s]%s[/font][/center]
%s
[img=16]%s[/img] %d

Cost: %s
%s

	[u]%s[/u]
"""%[
	"res://font/led_font.tres",
	dat.name,
	BBCode.line(),
	GlbDb.icon_dict["power"],dat.get("power",0),
	BBCode.resource(dat.cost),
	BBCode.build_time(dat.get("time",0)),
	dat.get("desc","")
]
	bbcode_text = txt
