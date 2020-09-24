extends Node

var story
var doom = 0
var ect_deck = []
var ect_discard = []
var chaosbag = []

var current_chara:Chara
var charas

func _init():
	charas = Node.new()
	charas.name = "charas"
	add_child(charas)

func InitGame(_charaList,deckList):
	seed(OS.get_system_time_msecs())
	for c in charas.get_children():
		c.queue_free()
	for i in len(_charaList):
		var cha = Chara.new()
		cha.Set(_charaList[i],deckList[i])
		$charas.add_child(cha)
	current_chara = $charas.get_child(0)
	
	#prepare ect_deck
	ect_deck.clear()
	for setKey in GlbDb.ectDict[story.name].keys():
		for i in GlbDb.ectDict[story.name][setKey]:
			ect_deck.append(GlbDb.cardDict[str(setKey)])

func CharaCount():
	return $charas.get_child_count()

func Use(card):
	#check action	
	var cost = card.get("cost",0)
	if current_chara.res>=cost:
		current_chara.at -= 1
		current_chara.res -= cost
		current_chara.hands.erase(str(card.id))
		match card.type:
			"Asset":
				current_chara.EqpAsset(card)
			"Event":
				print("Event:",card)
				var s = load("res://data/event/%s.gd"%str(card.id))
				if s==null:
					print_debug("no script:",card.id)
				else:
					s.Event(current_chara)
				current_chara.discard.append(card)
			_:print_debug("unknow type:",card)
		return true
	return false

func MoveTo(loc):
	current_chara.at -= 1
	current_chara.location.chara.erase(current_chara)
	loc.Enter(current_chara)

func Scan(loc):
	current_chara.at -= 1
	#TODO show chaos token
	#success
	loc.clue -= 1
	current_chara.clue += 1

func ActionDrawCard():
	if current_chara.at >0:
		current_chara.Draw()
		current_chara.at -= 1
		return true
	return false

func ActionSupply():
	if current_chara.at>0:
		current_chara.res += 1
		current_chara.at -= 1
		return true
	return false

func EnemyPhyse():
	pass

func SupplyPhase():
	for chara in charas.get_children():
		chara.Draw()
		chara.res += 1
		chara.at = 3
		#TODO discard hand card

func MythosPhase():
	doom -= 1
	#Check agenda
	for chara in charas.get_children():
		chara.Encounter(ect_deck.pop_front())
