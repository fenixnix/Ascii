extends ColorRect

var time = 0.5

func _ready():
	color = Color(0,0,0,0)
	pass

func FadeOut():
	print_debug("fadeOut")
	CvtColor(color,Color.black)

func FadeIn():
	print_debug("fadeIn")
	CvtColor(color,Color(0,0,0,0))

func FadeOutIn():
	FadeOut()
	yield($Tween,"tween_all_completed")
	FadeIn()

func CvtColor(from,to):
	$Tween.interpolate_property(self,"color",from,to,time,Tween.TRANS_BACK)
	$Tween.start()
