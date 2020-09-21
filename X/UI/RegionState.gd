extends Node

enum{UNEXPLORED,EXPLORING,OPENSPACE,BUILDING,OCCUPID}

func _ready():
	for c in get_children():
		c.hide()

func Set(state):
	hide_all()
	match state:
		"unexplored":
			$UnExplored.visible = true
		"exploring":
			$Exploring.visible = true
		"openspace":
			$NoFacility.visible = true
		"building":
			$Building.visible = true
		"occupied":
			$Occupied.visible = true

func hide_all():
	$UnExplored.visible = false
	$Exploring.visible = false
	$NoFacility.visible = false
	$Occupied.visible = false
	$Building.visible = false
