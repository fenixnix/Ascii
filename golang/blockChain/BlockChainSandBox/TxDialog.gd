extends Panel

signal initTx
func _on_TxBtn_pressed():
	var tx = {"from":$From.text,"to":$To.text,"value":$Value.value}
	emit_signal("initTx",tx)