extends Spatial

func _ready():
	var ship_dat = Ship.CreateNpcShip(GlbDb.xeno_ship[0],GlbDb.xeno_wpn)
	$Battlar.Load(ship_dat)

func _on_Button_pressed():
	$Battlar.Enclose($Target)
	$Battlar.aim_target = $Target
