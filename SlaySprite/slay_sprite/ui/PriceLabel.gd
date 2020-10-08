extends Control

var good

func _ready():
	Set({"on_sale":true,"price":998})

func Set(dat):
	good = dat.get("good",null)
	$sale.visible = dat.get("on_sale",false)
	$price.text = str(dat.price)
	$price.disabled = dat.has("short_of_money")
	if dat.has("short_of_money"):
		$price.self_modulate = Color.red
	else:
		$price.self_modulate = Color.white
