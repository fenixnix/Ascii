extends Area2D

class_name TriggerArea2D

export(Script) var trigScript
export(NodePath) var trigNodePath
export var destoryOnTrigger = true

func _on_Trigger_body_entered(body):
	if trigScript!=null:
		trigScript.Trig(get_tree())
	var trigNode = get_node_or_null(trigNodePath)
	if trigNode!=null:
		trigNode.Trig(get_tree())
	if destoryOnTrigger:
		queue_free()
