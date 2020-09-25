extends Control

var data

func Set(asset):
	data = asset
	$Label.text = asset.name
	var ammo = asset.get("ammo",0)
	for i in ammo:
		$Ammo.add_image(load("res://image/resource.png"),16,16)

func _on_Asset_mouse_entered():
	print(data)
	CardDetail.Show(data)

func _on_Asset_mouse_exited():
	CardDetail.Hide()
