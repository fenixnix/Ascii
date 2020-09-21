extends Spatial

func Run(target):
	print("run")
	$Tween.interpolate_property(self,"translation",translation,target.translation,1.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	#queue_free()
