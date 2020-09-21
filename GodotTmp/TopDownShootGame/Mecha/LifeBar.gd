extends TextureProgress


export(NodePath) var lifeNode

onready var life = get_node(lifeNode)

func _process(delta):
	max_value = life.maxLife
	value = life.life
