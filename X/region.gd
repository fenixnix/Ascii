extends Node

class_name Region

static func GenPower(regions):
	var power = 0
	for r in regions:
		if r.facility!=null:
			power += r.facility.get("power_gen",0)
	return power

static func CostPower(regions):
	var power = 0
	for r in regions:
		if r.facility!=null:
			power += r.facility.get("power",0)
	return power

static func Tick(region,site):
	if region.has("explore")&& region.explore.running:
		region.explore.progress += (1.0/region.explore.time)
		if region.explore.progress >= 1:
			region.erase("explore")
			GlbMsg.NewMsg("[color=#00ff0f]%s[/color] explored at [u]%s[/u]"%[region.name,site.site_name])
	if region.has("building"):
		region.building.progress += 1.0/region.building.time
		if region.building.progress >= 1:
			region.facility = region.building
			region.facility.erase("cost")
			region.facility.erase("time")
			region.erase("building")
			GlbMsg.NewMsg("[color=#00ff0f]%s[/color] completed at [u]%s[/u]"%[region.facility.name,site.site_name])			
	if region.facility!=null:
		Facility.Tick(region.facility,site)

static func RandomRegion():
	var tmp = {
		"name":"none",
		"type":"",
		"img":"",
		"facility":null,
		"explore":{
			"time":8,
			"needs":{
				
			},
			"running":false,
			"progress":0,
		}
	}
