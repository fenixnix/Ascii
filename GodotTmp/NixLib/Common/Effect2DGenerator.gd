extends Node2D

class_name Effect2DGenerator

export(PackedScene) var efx

func Play():
	if efx!=null:
		var e = efx.instance()
		e.position = global_position
		$"/root".add_child(e)
