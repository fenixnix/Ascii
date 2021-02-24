tool
extends Node

signal finish
var buff = []

func _ready():
	Clear()
	Close()
	$TextPrinter/next.hide()

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

func Push(text):
	buff.append(text)
	if len(buff)==1:
		Print(text)

func Print(text):
	Show()
	$TextPrinter/next.hide()
	$TextPrinter.Print(text)

func _on_TextPrinter_finish():
	if len(buff)>0:
		buff.pop_front()
		if len(buff)>0:
			Print(buff.front())
	else:
		emit_signal("finish")

func _on_TextPrinter_wait():
	if len(buff)>0:
		buff.pop_front()
		if len(buff)>0:
			Print(buff.front())
	else:
		emit_signal("finish")
	$TextPrinter/next.show()

func _on_TextPrinter_putChar():
	$sfx.play()
