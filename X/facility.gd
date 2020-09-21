extends Node

class_name Facility

static func Tick(data,site):
	if data.has("type"):
		match data.type:
			"ofc_fcty":ofc_fcty_tick(data,site)
			"ship_fcty":ship_fcty_tick(data,site)
			"wpn_fcty":wpn_fcty_tick(data,site)
			"eqp_fcty":eqp_fcty_tick(data,site)
			"research":research_tick(data,site)
	if data.has("produce"):
		produce_tick(data,site)

static func ofc_fcty_tick(data,site):
	if data.has("task")&&len(data.task)>0:
		var firstTask = data.task[0]
		firstTask.progress += 1.0/firstTask.item.time
		if firstTask.progress >=1:
			print_debug("finish training Officer")
			var ofcLst = []
			match firstTask.item.id:
				"eng":
					for i in range(3):
						ofcLst.append(Officer.randGenEng())
				"sci":
					for i in range(3):
						ofcLst.append(Officer.randGenSci())
				"tac":
					for i in range(3):
						ofcLst.append(Officer.randGenTac())
			var ui = GlbUi.OverlapUI("ChoiceTrainedOfficer",ofcLst)
			data.task.remove(0)
			GlbMsg.NewMsg("new offcer at %s"%site.site_name)
			var ofc = yield(ui,"select")
			site.ofcs.append(ofc)

static func ship_fcty_tick(data,site):
	if data.has("task")&&len(data.task)>0:
		var firstTask = data.task[0]
		firstTask.progress += 1.0/firstTask.item.time
		if firstTask.progress >=1:
			print_debug("finish build ship")
			site.ships.append(Ship.CreateShip(firstTask.item))
			data.task.remove(0)
			GlbMsg.NewMsg("new ship at %s"%site.site_name)

static func wpn_fcty_tick(data,site):
	if data.has("task")&&len(data.task)>0:
		var firstTask = data.task[0]
		firstTask.progress += 1.0/firstTask.item.time
		if firstTask.progress >=1:
			print_debug("finish build wpn")
			site.wpns.append(Ship.CreateShip(firstTask.item))
			data.task.remove(0)
			GlbMsg.NewMsg("new wpn at %s"%site.site_name)
	
static func eqp_fcty_tick(data,site):
	if data.has("task")&&len(data.task)>0:
		var firstTask = data.task[0]
		firstTask.progress += 1.0/firstTask.item.time
		if firstTask.progress >=1:
			print_debug("finish build eqp")
			site.eqps.append(Ship.CreateShip(firstTask.item))
			data.task.remove(0)
			GlbMsg.NewMsg("new eqp at %s"%site.site_name)

static func produce_tick(data,site):
	for p in data.produce.keys():
		if !site.res.has(p):
			site.res[p] = 0
		site.res[p] += data.produce[p]

static func research_tick(data,site):
	site.tech += 1
	site.indu += 1

static func DescRT(data):
	var txt = ""
	txt += "[font=%s][center]%s[/center][/font]\n"%["res://font/large_pixel.tres",data.name]
	txt += "[center]%s[/center]\n"%"_".repeat(32)
	txt += "\n\n"
	if data.has("type"):
		match data.type:
			"power":
				txt += "[img=16]%s[/img] %d\n"%[GlbDb.icon_dict["power"],data.power_gen]
			"produce":
				txt += "Production:\n"
				for p in data.produce.keys():
					txt += "[img=16]%s[/img] %d/Day\n"%[GlbDb.icon_dict[p],data.produce[p]]
				
	return txt
