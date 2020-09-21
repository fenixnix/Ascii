extends Node

var turn = 0
var currentSiteIndex = 0
onready var avatar = $Avatar/Trader

onready var inventoryUI = $HUD/Root/HBoxContainer/InventoryDlg
onready var shopUI = $HUD/Root/HBoxContainer/ShopDlg

func _ready():
	GlbDb.GenItmDB(64*5)
	$World.GenWorld()
	yield(get_tree(),"idle_frame")
	LookAtSite(CurrentSite())
	inventoryUI.inventory = avatar.inventory
	$HUD/Root.Refresh(self)

func _input(event):
	if event.is_action_pressed("ui_down"):
		MoveTo(posmod(currentSiteIndex+1,len($World.sites)))

func LookAtSite(site):
	avatar.position = site.position

func MoveTo(index):
	var _turn = SiteDistance(CurrentSite(),$World.sites[index])
	turn += _turn
	$World.Tick(_turn)
	currentSiteIndex = index
	$HUD/Root.Refresh(self)
	LookAtSite(CurrentSite())

func _on_Inventory_pressed():
	inventoryUI.Open(avatar.inventory)

func _on_Shop_pressed():
	shopUI.Open(CurrentSite())
	inventoryUI.Open(avatar.inventory)

func _on_ShopDlg_buy(index):
	avatar.Buy(CurrentSite(),index)
	Refresh()

func CurrentSite()->Site:
	return $World.sites[currentSiteIndex]

func Refresh():
	inventoryUI.Refresh()
	shopUI.Refresh()
	$HUD/Root.Refresh(self)

func _on_InventoryDlg_sell(index):
	avatar.Sell(CurrentSite(),index)
	Refresh()

onready var siteList = $CanvasLayer/SiteList
func SetSiteList():
	siteList.clear()
	var src = CurrentSite().position/$World.grid_size
	for s in $World.sites:
#		if CurrentSite() == s:
#			continue
		var distance = SiteDistance(CurrentSite(),s)
		siteList.add_item("%s:-->[%3d]"%[s.name_text,distance])
	siteList.show()

func SiteDistance(A,B):
	var src = A.position/$World.grid_size
	var dst = B.position/$World.grid_size
	var dif = dst - src
	return abs(dif.x)+abs(dif.y)
	
func _on_Move_pressed():
	SetSiteList()

func _on_SiteList_item_activated(index):
	MoveTo(index)
	siteList.hide()

func _on_SiteList_item_selected(index):
	LookAtSite($World.sites[index])
