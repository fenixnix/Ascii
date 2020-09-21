extends Node2D

class_name Fleet

var data
var goal
var moving = false

func Set(dat):
	data = dat
	$Sprite.texture = load(GlbDb.faction_img[dat.get("team",0)])

func MoveTo(_goal):
	goal = _goal
	var dif:Vector2 = (goal.position - position)
	moving = true

func _physics_process(delta):
	if !GlbTime.running:
		return
	if !moving:
		return
	var dif:Vector2 = (goal.position - position)
	$Sprite.flip_h = dif.x<0
	position += dif.normalized()*delta*data.get("speed",3)*GlbDb.grid_size
	if dif.length_squared()<4:
		ArriveSite()

func ArriveSite():
	moving = false
	if data.get("team",0) == 0:
		for f in goal.fleets:
			if f.get("team",1)==1:
				get_tree().current_scene.TrigBattle(data,f,goal)
				break
	#Become Player Site
	if goal.team != data.team:
		goal.team = int(data.team)
	goal.PutResource(data.resource)
	data.erase("resource")
	goal.fleets.append(data)
	for s in data.ships:
		if s.get("ofc",null)!=null:
			goal.ofcs.append(s.ofc)
	queue_free()

static func RefreshAfterBattle(data,hp_lst):
	for i in len(data.ships):
		data.ships[i].hp = hp_lst[i]
	var del_lst = []
	for s in data.ships:
		if s.hp<=0:
			del_lst.append(s)
	for d in del_lst:
		data.ships.erase(d)
	return data

static func GoodsTransfer(A,B):
	if A.has("goods"):
		if !B.has("goods"):
			B.goods = {}
		for k in A.goods.keys():
			if B.goods.has(k):
				B.goods[k] += A.goods[k]
			else:
				B.goods[k] = A.goods[k]
