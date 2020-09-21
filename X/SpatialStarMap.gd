extends Spatial

var sitePrefab = preload("res://SpatialSite.tscn")

func _ready():
	RandGen(128)

func RandGen(count):
	for c in count:
		var site = sitePrefab.instance()
		$sites.add_child(site)
		site.translation = RandSpatial(64)

func RandSpatial(radius):
	return Vector3(
		rand_range(-radius,radius),
		rand_range(-radius,radius),
		rand_range(-radius,radius)
		)

func _on_Control_gui_input(event):
	$Camera.Event(event)
