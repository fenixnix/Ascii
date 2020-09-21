extends Node

onready var fleets = $'/root/Main/StarMap/fleets'
onready var sites = $'/root/Main/StarMap/sites'

func _ready():
	GlbTime.connect("hour_tick",$StarMap/sites,"_on_Main_hour_tick")
	GlbTime.connect("hour_tick",$Xeno,"OnDayTick")
	GlbTime.connect("day_tick",self,"on_day_tick")
	GlbDat.connect("token_val_change",self,"on_token_val_change")
	GlbMsg.connect("new_msg",$UI/MainUI/message,"append_bbcode")
	GlbDat.token = 1000

	for s in sites.get_children():
		s.regions = FileRW.LoadJsonFile("res://data/sites/poor_site.json")

	var plrSite = sites.get_child(0)
	var data = FileRW.LoadJsonFile("res://data/sites//test_site.json")
	plrSite.InitFromJsonDat(data)

	plrSite.regions = FileRW.LoadJsonFile("res://data/sites/test_regions.json")
	plrSite.ofcs.append(Officer.RandGen())
	plrSite.ofcs.append(Officer.RandGen())
	$StarMap/MainCam.MoveTo(plrSite.position)

	#plrSite.SetFleet(test_enm_fleet)
	#Battle Test
	#yield(get_tree().create_timer(1),"timeout")
	#TrigBattle(base.fleets[0],test_enm_fleet.data)

func on_day_tick():
	if GlbTime.day%30 == 0:
		payWages()

func GetAllPlayerOfc():
	var tmp = []
	for s in $StarMap/sites.get_children():
		if s.team == 0:
			for o in s.ofcs:
				tmp.append({"ofc":o,"site":s})
	return tmp

func payWages():
	print_debug("pay wages")
	for o in GetAllPlayerOfc():
		var wage = o.get("wage",1)
		if wage<=GlbDat.token:
			GlbDat.token -= wage
		else:
			if !o.has("mood"):
				o.mood = 0
			o.mood -= 1 

func on_token_val_change(val):
	$UI/MainUI/Token.bbcode_text = "%s %d %s"%[
		GlbDb.FontIcon("money"),GlbDat.token,GlbDb.FontIcon("btc")]
	$UI/MainUI/Token.update()

func SelectSiteToLaunchFleet(fromSite,fleet):
	$StarMap/sites.SetSelectSiteMode()
	var site = yield($StarMap/sites,"select")
	GlbUi.Pop()
	GlbUi.Pop()
	$StarMap/sites.SetViewMode()
	print_debug("fleet %s from %s to %s"%[fleet.name,fromSite.name,site.name])
	var ui = GlbUi.PushUI("TransportUI",fromSite.res)
	var data = yield(ui,"transport")
	fleet["resource"] = data
	fromSite.TakeResource(data)
	GlbUi.Pop()
	$StarMap/fleets.LaunchFleet(fromSite,site,fleet)

func TrigBattle(plrFleet,enmFleet,site):
	GlbTime.running = false
	print("battle: %s VS %s"%[plrFleet.name,enmFleet.name])
	$StarMap.hide()
	var btlDat = GenBtlDat(plrFleet,enmFleet)
	var btl = load("res://Battle/Battle.tscn").instance()
	add_child(btl)
	btl.Start(btlDat)
	var result = yield(btl,"battle_result")
	if result.result == "win":
		print("destory enemy fleet")
		Fleet.GoodsTransfer(enmFleet,plrFleet)
		#enmFleet.queue_free()
	if result.result == "loss":
		print("destory player fleet")
		Fleet.GoodsTransfer(plrFleet,enmFleet)
		#plrFleet.queue_free()
	Fleet.RefreshAfterBattle(plrFleet,result.plr_hps)
	print_debug(Fleet.RefreshAfterBattle(enmFleet,result.enm_hps))
	site.CheckFleetAfterBattle()
	
	var brd = GlbUi.OverlapUI("BattleResultDialog",{"title":result.result,"text":""})
	yield(brd,"confirm")
	
	btl.queue_free()
	$StarMap.show()

func GenBtlDat(plrFleet,enmFleet):
	var dat = {"plr":[],"enm":[],"bg":""}
	for f in plrFleet.ships:
		var ship = f.duplicate(true)
		
		#init player ship wpns
		ship.erase("wpns")
		ship.wpns = []
		for w in f.wpns:
			if w.slot!=null:
				ship.wpns.append(w.slot)
				
		dat.plr.append(ship)
		
	for f in enmFleet.ships:
		var ship = f.duplicate(true)
		ship["team"] = 1
		#init enm ship wpns
		ship.erase("wpns")
		ship.wpns = []
		for w in f.wpns:
			if w.slot!=null:
				ship.wpns.append(w.slot)
				
		dat.enm.append(ship)
		
	return dat

func _on_Member_pressed():
	GlbUi.PushUI("AllPlayerOfcLst",GetAllPlayerOfc())

func _on_toggle_msg_toggled(button_pressed):
	$UI/MainUI/message.visible = button_pressed
