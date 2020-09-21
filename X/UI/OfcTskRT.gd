extends RichTextLabel

class_name OfcTskRT

func Set(tsk):
	bbcode_enabled = true
	var timeReduced = 0
	if tsk.has("ofc"):
		timeReduced = Officer.TimeReduce(tsk.ofc,tsk.needs)

	var code = """
%s
%s
[center][s]                [/s][/center]
Time Decreased %3d%%
	%s
"""%[
	ofc_code(tsk),
	bonus(tsk),
	floor(timeReduced*100.0),
	BBCode.build_time((1-timeReduced)*tsk.time),
]
	bbcode_text = code


func ofc_code(tsk):
	if tsk.has("ofc"):
		return """
%s
	[img]%s[/img]
"""%[
	tsk.ofc.name,
	tsk.ofc.icon,
]
	else:
		return ''


func bonus(tsk):
	var ofc = {}
	if tsk.has("ofc"):
		ofc = tsk.ofc
	var txt = ""
	for n in tsk.needs.keys():
		var ability = ofc.get(n,0)
		var rate = clamp(ability/tsk.needs[n],0,1)
		txt += "[color=#%s]%s %s[/color] %3d/%3d\n"%[
			GlbDb.att_color_dict[n].to_html(),n,BBCode.bar_full(rate),
			ability,tsk.needs[n]]
	return txt
