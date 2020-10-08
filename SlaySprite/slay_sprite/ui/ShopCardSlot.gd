extends Control

func Set(data,price):
	$CardPanel.Set(data)
	$PriceLabel.Set(price)

func _on_ShopCardSlot_gui_input(event:InputEvent):
	if event.is_action_pressed("click"):
		print_debug("click card")
		pass
