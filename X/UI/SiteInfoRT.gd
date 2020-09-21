extends RichTextLabel

class_name SiteInfoRT

var line = "[color=green][s]%s[/s][/color]\n"%(" ".repeat(32))

func _ready():
	connect("meta_clicked",self,"_on_Info_meta_clicked")

func Set(site):
	bbcode_enabled = true
	clear()
	var txt = BBCode.site(site)
	txt += "\nHP:[color=yellow]%s[/color][%d/%d]"%[BBCode.bar_full(site.hp),site.hp*site.mhp,site.mhp]
	txt += " [color=yellow]%s[/color] %d/%d\n"%[GlbDb.FontIcon("power"),Region.CostPower(site.regions),Region.GenPower(site.regions)]
	txt += BBCode.resource(site.res)
	bbcode_text = txt
	BBCode.fleets(self,site.fleets)

func _on_Info_meta_clicked(meta):
	GlbUi.OverlapUI("InfoDlg",
	{"script":"res://UI/ShipInfoRT.gd","data":meta})
