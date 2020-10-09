extends Control

var card_data
var card_price

var sold_out = false

func Set(data,price):
	card_data = data
	card_price = price
	$CardPanel.Set(data)
	if GlbDat.gold<card_price.price:
		price["short_of_money"] = true
	$PriceLabel.Set(price)

func _on_ShopCardSlot_gui_input(event:InputEvent):
	if event.is_action_pressed("click"):
		if !sold_out:
			if GlbDat.gold>=card_price.price:
				print_debug("buy card")
				GlbAct.GainCard(card_data)
				GlbAct.CostGold(card_price.price)
				sold_out = true
				$CardPanel.hide()
				$PriceLabel.hide()
		else:
			print_debug("no enough gold!")
		
