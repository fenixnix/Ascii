tool
extends Node

signal finish

func _ready():
	$TextPrinter/next.hide()
	Clear()
	Close()

func Clear():
	$TextPrinter.Clear()

func Show():
	$bg.show()
	$TextPrinter.show()

func Close():
	$TextPrinter.hide()
	$TextPrinter/next.hide()
	$bg.hide()

func SetTypeRate(rate):
	$TextPrinter.delayTime = rate
	
func SetColor(color):
	$TextPrinter.modulate = color

func Print(text):
	$TextPrinter/next.hide()
	Show()
	$TextPrinter.Print(text)

func _on_TextPrinter_finish():
	emit_signal("finish")

func _on_TextPrinter_wait():
	$TextPrinter/next.show()
