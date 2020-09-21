extends Control

func _ready():
	Refresh()

func Refresh():
	$Menu/Info.text = $Boost.Print()

func _on_Tick_pressed():
	$Boost.Tick()
	Refresh()

func _on_Boost_pressed():
	$Boost.Boost()
	Refresh()

func _on_UnBoost_pressed():
	$Boost.UnBoost()
	Refresh()

func _on_Cast_pressed():
	$Boost.Cast()
	Refresh()

func _on__pressed():
	$Boost.Add($Menu/StarMod/val.value)
	Refresh()
