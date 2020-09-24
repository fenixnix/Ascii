extends Control

func Set(asset):
	$Label.text = asset.name
	var ammo = asset.get("ammo",0)
	for i in ammo:
		$Ammo.add_image(load("res://image/resource.png"),16,16)
