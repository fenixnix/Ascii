extends RichTextLabel

class_name CharaRT

func Set(dat):
	print(dat)
	var txt = """[color=#101000]
	[center][font=res://font/name.tres]%s[/font]
	[s]                                [/s][/center]
	[img]%s[/img] [color=#404040][i][font=res://font/desc.tres]The %s[/font][/i][/color][/color]
	
	[color=#008080]%s %d [font=res://font/icon.tres]p[/font][/color]
	[color=#f0f000]%s %d [font=res://font/icon.tres]b[/font][/color] 
	[color=#e00000]%s %d [font=res://font/icon.tres]c[/font][/color]
	[color=#00e000]%s %d [font=res://font/icon.tres]a[/font][/color]
	[color=#0080ff]Sanity: %d[/color]\t[color=#ff8000]Health: %d[/color]
[color=#000000][s]                                [/s]
	#: %s
	
	⚝&: ⚝%s[/color]
"""%[
	dat.name,
	GlbDb.class_icon[dat["class"]],
	dat["class"],
	#"[color=#000000]%s[/color]"%dat.name[1],
	bar(dat.W),dat.W,
	bar(dat.I),dat.I,
	bar(dat.C),dat.C,
	bar(dat.A),dat.A,
	dat.SAN,dat.STA,
	dat.get('desc',''),
	dat.get('eldritch','')
]
	bbcode_enabled = true
	bbcode_text = txt
	
func bar(val,val_cap=9):
	return "%s%s"%["|".repeat(val),"[color=#808080]%s[/color]"%"|".repeat(val_cap-val)]
	
