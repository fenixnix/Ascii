extends Node

func _ready():
	pass

func Run():
	$BehaviorTreeRoot.Run(get_parent(),$"/root")
	
