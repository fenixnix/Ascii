extends Node2D

signal select(site)

func SelectLaunchSite(fleet):
	$HUD/Label.show()

func _unhandled_input(event):
	$MainCam.Event(event)
