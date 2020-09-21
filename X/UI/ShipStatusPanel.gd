extends GridContainer

var hull
var acc
var evd
var crt
var spd

func _init():
	columns = 2
	hull = Insert("HULL","")
	acc = Insert("ACC","")
	evd = Insert("EVD","")
	crt = Insert("CRT","")
	spd = Insert("SPD","")

func Set(data):
	hull.text = str(data.hull)
	acc.text = '%d %%'%[data.acc+100]
	evd.text = '%d %%'%data.evd
	crt.text = '%d %%'%data.crt
	spd.text = str(data.spd)

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
