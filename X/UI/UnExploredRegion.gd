extends Control

onready var labPrefab = load("res://UI/AttNeed.tscn")

var data

signal execute(data)

func Set(explore_data):
	data = explore_data
	if data.has("ofc"):
		data.erase("ofc")
	Refresh()

func Refresh():
	$OfcTskRT.Set(data)
	$ExploreBtn.disabled = false

func _on_AssignOfficer_pressed():
	var ui = GlbUi.OverlapUI("OfcSelUI",GlbDat.currentSite.ofcs)
	ui.connect("select",self,"on_select_officer")

func on_select_officer(officer):
	data.ofc = officer
	data.act_time = Officer.TimeReduce(data.ofc,data.needs)
	Refresh()

func _on_ExploreBtn_pressed():
	emit_signal("execute",data)
