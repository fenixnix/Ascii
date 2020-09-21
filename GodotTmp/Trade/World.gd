extends Node2D

class_name TradeWorld

export(PackedScene) var sitePrefab

var map_size = Vector2(64,48)
var grid_size = 32
var site_count = 64

var sites = []

func GenWorld():
	sites.clear()
	var list = range(map_size.x*map_size.y)
	list.shuffle()
	var res = list.slice(0,site_count-1,1,true)
	for r in res:
		var site = sitePrefab.instance()
		add_child(site)
		site.position = index2Pos(r)
		var index = len(sites)
		site.RndGen(range(index*5,(index+1)*5))
		sites.append(site)

func index2Pos(index:int):
	return Vector2(index%int(map_size.x),index/int(map_size.x))*grid_size

func Tick(turn):
	for s in sites:
		s.Tick(turn)

func NearSiteList(pos:Vector2,cnt):
	var tmpSites = []
	for s in sites:
		tmpSites.append([s,pos.distance_squared_to(s.position)])
	tmpSites.sort_custom(SiteSorter,"sort_ascending")
	return tmpSites.slice(0,cnt)

class SiteSorter:
	static func sort_ascending(a, b):
		if a[1] < b[1]:
			return true
		return false
