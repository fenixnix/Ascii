extends Node2D


export (PackedScene) var sp

func _ready():
	for i in range(128):
		for j in range(128):
			var r = sp.instance()
			r.position = Vector2(i*8,j*8)
			add_child(r)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


