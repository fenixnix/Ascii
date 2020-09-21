extends Node

func _ready():
	yield(get_tree().create_timer(5),"timeout")
	$BehaviorTreeRoot.Run(get_parent(),$"/root/Trade/World")
	print("init think")
	
func _on_BehaviorTreeRoot_finish():
	$BehaviorTreeRoot.Run(get_parent(),$"/root/Trade/World")
	print("think")
