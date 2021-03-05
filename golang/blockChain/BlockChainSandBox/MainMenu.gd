extends Control

func _ready():
	pass # Replace with function body.

signal add_node

func _on_AddNodeBtn_pressed():
	var val = $Menu/HBoxContainer/SpinBox.value
	var valStr = "%03d"%val
	print(valStr,val)
	emit_signal("add_node",valStr)
	$Menu/HBoxContainer/SpinBox.value+=1

signal init_tx
func _on_TxBtn_pressed():
	pass

func _on_Inquiry_pressed():
	$InquiryDlg.show()
	pass # Replace with function body.

func _on_InquiryDlg_gui_input(event):
	pass # Replace with function body.
