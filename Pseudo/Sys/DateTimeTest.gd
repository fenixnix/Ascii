extends Control

func _process(delta):
	if$Menu/Running.pressed:
		$Node.Flow(delta)
	Refresh()

func _on_Battle_pressed():
	$Node.BattleTurn($Menu/Turn/Turn.value)
	Refresh()

func Refresh():
		var time = $Node.DateTime()
		$Menu/Info.text = "Day:%d,Month:%d,Year:%d:Time:%d"%[time["D"],time["M"],time["Y"],$Node.time]
		$Menu/DayNight.value = $Node.DayNight()
