extends Node2D

class_name Trader

var money = 10000
var movSpd = 30
var supply = 50
var maxSupply = 100
var maxWeight = 100
var inventory = []

var moving = false
var targetPosition = null
var targetSite = null
var lastVisitedSite = null

signal arrive(site)

func MoveTo(site):
	targetSite = site
	targetPosition = site.position
	moving = true

func Buy(site,index):
	var itm = site.shopList[index]
	var price = site.RecommandPrice(itm.id)*1.1
	if price>money:
		return
	#check weight
	money -= price
	putItemToInventory(itm.id)
	site.wealth += price
	site.Take(index)
	
func Sell(site,index):
	var id = takeItemFromInventoryByIndex(index)
	money += site.RecommandPrice(id)
	site.AddCommodity(id)

func _physics_process(delta):
	if !moving:
		return
	var dir:Vector2 = targetPosition - position
	if dir.length_squared()<0.1:
		moving = false
		lastVisitedSite = targetSite
		emit_signal("arrive",targetSite)
		return
	position += dir.normalized()*movSpd*delta

func AllWeight():
	var tmpWt = 0
	for i in inventory:
		var dat = GlbDb.itmDb[i.id]
		tmpWt += dat.wt*i.cnt
	return tmpWt

func LoadRate():
	return AllWeight()/maxWeight

func RndSelNearSite():
	var world:TradeWorld = $"/root/Trade/World"
	var lst = world.NearSiteList(position,4)
	if len(lst)<=0:
		return null
	lst.erase(lastVisitedSite)
	var rndIndex = randi()%len(lst)
	return lst[rndIndex][0]

func putItemToInventory(itm_id):
	var dat = GlbDb.itmDb[itm_id]
	for i in len(inventory):
		if inventory[i].id == itm_id:
			inventory[i].cnt+=1
			return
	inventory.append({'id':itm_id,'cnt':1})

func takeItemFromInventoryByIndex(index):
	inventory[index].cnt -= 1
	var id = inventory[index].id
	if inventory[index].cnt<=0:
		inventory.remove(index)
	return id
