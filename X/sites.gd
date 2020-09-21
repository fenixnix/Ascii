extends Node2D

export(PackedScene) var site_prefab

signal select(site)

func _ready():
	seed(OS.get_system_time_msecs())
	RandInit(25,500)

func RandInit(count,radius):
	for c in count:
		var site = site_prefab.instance()
		add_child(site)
		site.RandInit()
		var x = rand_range(-radius,radius)
		var y = rand_range(-radius,radius)
		site.position = Vector2(x,y)

func _on_Main_hour_tick():
	for s in get_children():
		s.HourTick()

func SetSelectSiteMode():
	for s in get_children():
		s.connect("selected",self,"on_select_site")
		s.SetUiMode("select")

func SetViewMode():
	for s in get_children():
		s.disconnect("selected",self,"on_select_site")
		s.SetUiMode("view")

func on_select_site(site):
	emit_signal("select",site)
