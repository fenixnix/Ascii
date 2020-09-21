extends Node

onready var treeRoot = $BehaviorTreeRoot
onready var agent = $AgentObj

func _ready():
	print("BT Start")
	treeRoot.Run(agent,null)
	yield(treeRoot,"finish")
	print("BT finish")
