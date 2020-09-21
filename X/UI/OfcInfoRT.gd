extends RichTextLabel

class_name OfcInfoRT

var editable = true
var current_ofc

signal value_change(ofc)

func _ready():
	Init()
	
func Init():
	bbcode_enabled = true
	connect("meta_clicked",self,"on_edit_name")

func Set(dat):
	current_ofc = dat
	clear()
	if editable:
		push_meta(dat)
		append_bbcode(GlbDb.FontIcon("edit"))
		pop()
	var txt = """ [font=res://font/optimus_font.tres][u]%-16s[/u][/font]
Lv:%2d [font=res://font/led_font.tres] %s[/font]
[img]%s[/img] EXP:%s[%d/%d]
%s
%s
	"""%[
		dat.get("name","none"),
		dat.get("lv",0)+1,GlbDb.cls_dict[dat.get("cls","eng")],
		dat.get("icon",GlbDb.default_officer_portrait),
		BBCode.bar_full(float(dat.get("exp",0))/GlbDb.expTable[dat.get('lv',1)],24),
		dat.get("exp",0),GlbDb.expTable[dat.get('lv',1)],
		param_code(dat,
			[
				{"key":"DIP","color":"#00ff00"},
				{"key":"ENG","color":"#ffff00"},
				{"key":"SCI","color":"#00ffff"},
				{"key":"TAC","color":"#ff0000"},
			]
		),
		"%s %d %s per Month"%[
			GlbDb.FontIcon("money"),
			dat.get("wage",1),
			GlbDb.FontIcon("btc")]
	]
	append_bbcode(txt)

func param_code(dat,param):
	var txt = ""
	for p in param:
		txt += "[color=%s]%s %s %d[/color]\n"%[
			p.color,
			p.key,
			BBCode.bar_full(dat.get(p.key,0)/256),
			dat.get(p.key,0)
		]
	return txt

func bar(rate,max_val=64):
	var v = ceil(max_val*rate)
	var txt = "[font=res://font/mini_pixel.tres]%s[/font]"%['|'.repeat(v)+'|']
	return txt

func on_edit_name(ofc):
	current_ofc = ofc
	var input:Popup = load("res://UI/LineEditorDialog.tscn").instance()
	add_child(input)
	input.popup_centered()
	input.connect("value_change",self,"on_ofc_name_change")

func on_ofc_name_change(new_text):
	current_ofc.name = new_text
	Set(current_ofc)
	emit_signal("value_change",current_ofc)
