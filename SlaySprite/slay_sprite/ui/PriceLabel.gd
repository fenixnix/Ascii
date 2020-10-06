extends Control

var good

func _ready():
	Set({"on_sale":true,"price":998})

func Set(dat):
	good = dat.get("good",null)
	if dat.has("on_sale"):
		$frame.self_modulate = Color.red
	else:
		$frame.self_modulate = Color.white
	$frame/price.text = str(dat.price)
	$frame/price.disabled = dat.has("short_of_money")
	if dat.has("short_of_money"):
		$frame/price.self_modulate = Color.red
	else:
		$frame/price.self_modulate = Color.white
