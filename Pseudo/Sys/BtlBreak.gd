extends Node

var shieldMax:int = 1
var shield:int

var maxBreakedCount = 1
var breakedCount = 0
var breaked = false

func _ready():
	shield = shieldMax

func Tick():
	if breaked:
		breakedCount -= 1
		if breakedCount<=0:
			breaked = false
			shield = shieldMax

func Hit():
	shield -= 1
	if shield <=0:
		Breaked()
		return true
	return false

func Breaked():
	breakedCount = maxBreakedCount
	breaked = true
