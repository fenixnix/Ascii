extends Control

func Refresh(trade):
	$Label.text = "Time：%d, Gold:%d, Food:%d, WT:%d/%d"%[
		trade.turn,
		trade.avatar.money,
		trade.avatar.supply,
		trade.avatar.AllWeight(),
		trade.avatar.maxWeight]
