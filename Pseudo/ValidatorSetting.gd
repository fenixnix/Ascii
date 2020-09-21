extends CanvasLayer

export(PackedScene) var validatorSetPrefab

var validatorList = []

var mainValidatorSet = {"id":-1,"set":[]}
var subValidatorSet = []

var currentValidatorSet = null

signal set_validators(dat)

func _ready():
	var tmp = FileRW.LoadJsonFile("res://validators.json")
	if tmp!=null:
		validatorList = tmp

	tmp = FileRW.LoadJsonFile("user://validatorSet.json")
	if tmp!=null:
		mainValidatorSet = tmp["main"]
		subValidatorSet = tmp["sub"]

	$Root/ValidatorList.clear()
	for v in validatorList:
		$Root/ValidatorList.add_item(v)
	Refresh()

func Refresh():
	for c in $Root/SubValidator.get_children():
		c.queue_free()
	$Root/ValidatorSet.Set(mainValidatorSet)
	for s in subValidatorSet:
		var set = validatorSetPrefab.instance()
		$Root/SubValidator.add_child(set)
		set.Set(s)
		set.connect("selected",self,"on_select")
		set.connect("remove_shard",self,"on_remove_shard")

func on_select(dat):
	currentValidatorSet = dat

func on_remove_shard(id):
	for s in subValidatorSet:
		if s.id == id:
			subValidatorSet.erase(s)
			print(subValidatorSet)
			return

func _on_AddSub_pressed():
	subValidatorSet.append({"id":len(subValidatorSet),"set":[]})
	Refresh()

func _on_ValidatorList_item_activated(index):
	if currentValidatorSet!=null:
		currentValidatorSet.data["set"].append(validatorList[index])
	currentValidatorSet.Refresh()

func _on_OK_pressed():
	var tmpData = {}
	tmpData["main"] = mainValidatorSet
	tmpData["sub"] = subValidatorSet
	FileRW.SaveJsonFile("user://validatorSet.json",tmpData)
	emit_signal("set_validators",tmpData)
	queue_free()
