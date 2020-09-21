extends GridContainer

var race
var cls
var tier

func _init():
	columns = 2
	race = Insert("RACE","")
	cls = Insert("CLASS","")
	tier = Insert("TIER","")

func Set(data):
	race.text = data.race
	cls.text = data.cls
	tier.text = str(data.tier)
		
func Insert(key,val):
	var keyLab = Label.new()
	keyLab.text = key
	keyLab.modulate = Color.aquamarine
	keyLab.size_flags_horizontal = Label.SIZE_EXPAND
	add_child(keyLab)
	var valLab = Label.new()
	#valLab.size_flags_horizontal = Label.SIZE_EXPAND
	valLab.align = valLab.ALIGN_RIGHT
	valLab.text = val
	valLab.modulate = Color.aqua
	add_child(valLab)
	return valLab
