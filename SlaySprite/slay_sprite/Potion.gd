extends Control

const defaultAppearanceSet = {
	"type":"m",
	#"outline_clr":"#ffffff",
	"fill":1,
	"fill_clr":"#ffffffff",
	"spot":true,
	"spot_clr":"#ffffffff"
}

const path_tmp = "res://image/potion/%s/%s"
func SetAppearance(set):
	$outline.texture = load(path_tmp%[set.type,GlbDb.potionImgDict[set.type][0]])
	$body.texture = load(path_tmp%[set.type,GlbDb.potionImgDict[set.type][1]])
	match set.fill:
		0:$liquid.texture = null
		1:$liquid.texture = load(path_tmp%[set.type,GlbDb.potionImgDict[set.type][2]])
		2:$liquid.texture = load(path_tmp%[set.type,GlbDb.potionImgDict[set.type][3]])
	$liquid.self_modulate = Color(set.fill_clr)
	if set.spot:
		$spots.texture = load(path_tmp%[set.type,GlbDb.potionImgDict[set.type][4]])
		$spots.self_modulate = Color(set.spot_clr)
	else:
		$spots.texture = null

func RndAppearanceSet():
	return {
		"type":GlbDb.potionImgDict.keys()[randi()%len(GlbDb.potionImgDict)],
		"fill":randi()%3,
		"fill_clr":RandomColor(),
		"spot":randi()%2 == 0,
		"spot_clr":RandomColor()
	}
	pass

func RandomColor():
	return Color(
		rand_range(0,1),
		rand_range(0,1),
		rand_range(0,1),
		rand_range(.3,.9)
	).to_html()

func _ready():
	randomize()
	SetAppearance(RndAppearanceSet())
