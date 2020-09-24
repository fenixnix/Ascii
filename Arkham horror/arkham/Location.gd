extends Node2D

var data
var clue = 0
var front = false
var chara = []
var enm = []

onready var charaPrefab = preload("res://CharaSymbel.tscn")
onready var enmPrefab = preload("res://EnmSymbel.tscn")

func Set(dat):
	data = dat
	refresh()

func refresh():
	name = str(data.id)
	position = Vector2(data.X,data.Y)*Vector2(500,300)
	$Name.text = data.name
	if front:
		$Sprite.texture = GlbDb.CardImg(data.img)
	else:
		$Sprite.texture = GlbDb.CardImg(data.imgb)
		
	var has_clues = data.has("clues")
	if front:
		$shroud.visible = has_clues
		$clues.visible = has_clues
		if has_clues:
			$shroud.text = str(data.shroud)
			$clues.text = str(clue)
		
	for c in $chara.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	var cnt = 0
	for c in chara:
		var cha = charaPrefab.instance()
		$chara.add_child(cha)
		cha.position += Vector2.RIGHT*40*cnt
		cha.Set(c)
		cnt+=1
		
	for c in $enm.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	cnt = 0
	for c in enm:
		var cha = enmPrefab.instance()
		$enm.add_child(cha)
		cha.position += Vector2.LEFT*40*cnt
		cha.Set(c)
		cnt += 1

func SetActionType(type):
	match type:
		"scan":
			$Scan.visible = true
			$Move.visible = false
		"move":
			$Scan.visible = false
			$Move.visible = true
		_:
			$Scan.visible = false
			$Move.visible = false

func Spawn(id):
	var enemy = GlbDb.cardDict[str(id)].duplicate(true)
	enm.append(enemy)
	return enemy

func Enter(_chara):
	_chara.location = self
	chara.append(_chara)
	clue = data.clues*GlbDat.CharaCount()
	front = true
	refresh()

func _on_Move_pressed():
	GlbDat.MoveTo(self)
	get_parent().Refresh()
	get_parent().SetupAction(GlbDat.current_chara)

func _on_Scan_pressed():
	GlbDat.Scan(self)
	refresh()
