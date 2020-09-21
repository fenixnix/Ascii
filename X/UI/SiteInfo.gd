extends RichTextLabel

var line = "[color=green][s]%s[/s][/color]\n"%(" ".repeat(32))

func _ready():
	connect("meta_clicked",self,"_on_Info_meta_clicked")

func Set(site):
	bbcode_enabled = true
	var txt = ""
	txt += "%s\n"%[site.site_name]
	txt += "type %s\n"%[site.type]
	txt += "HP:%s[%d/%d]\n"%[GlbDat.GetProgressCode(site.hp/site.mhp),site.hp,site.mhp]
	txt += line
	txt += "[img=16]%s[/img]%d/%d\n"%[GlbDb.icon_dict["power"],Region.CostPower(site.regions),Region.GenPower(site.regions)]
	txt += "[img=16]%s[/img] %d [img=16]%s[/img] %d [img=16]%s[/img] %d [img=16]%s[/img] %d\n"%[
		GlbDb.icon_dict["crew"],site.crew,
		GlbDb.icon_dict["mtrl"],site.mtrl,
		GlbDb.icon_dict["dkmt"],site.dkmt,
		GlbDb.icon_dict["fuel"],site.fuel,
	]
	bbcode_text = txt
	for f in site.fleets:
		bbcode_text += line
		newline()
		add_text("Fleets:%s\n"%[f.name])
		for s in f.ships:
			add_text("\t"+s.name + "\n")
			push_meta(s)			add_image(load(s.img))
			pop()
			add_text("\n")
			#txt += "\t[img]%s[/img]\n"%[s.img] 

func _on_Info_meta_clicked(meta):
	GlbUi.OverlapUI("ShipInfo",meta)
