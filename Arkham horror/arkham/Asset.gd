extends Control

var data

func Set(asset):
	data = asset
	$Label.text = asset.name
	var charge = asset.get("charge",0)
	for i in charge:
		$charge.add_image(load("res://image/resource.png"),16,16)
	if data.cd:
		$ColorRect.color = Color(0,0,0,.5)
	else:
		$ColorRect.color = Color(.2,.2,.2,.5)

func _on_Asset_mouse_entered():
	print(data)
	CardDetail.Show(data)

func _on_Asset_mouse_exited():
	CardDetail.Hide()
