tool
extends CanvasLayer

onready var dialog = $Frame/Content
onready var nextMark = $Frame/next

signal finish()

func _ready():
	Close()

func Close():
	$Frame.hide()
	nextMark.visible = false
	SetSpeaker()

func Say(text):
	$Frame.show()
	$Frame/Content/TextPrinter.Print(text)
	nextMark.hide()

func SetSpeaker(name = "???",face = null):
	$Frame/portrait.texture = face
	$Frame/Label/speaker.text = name

func Clear():
	$Frame/Content/TextPrinter.Clear()

func _on_TextPrinter_finish():
	emit_signal("finish")

func _on_TextPrinter_wait():
	nextMark.show()

func _on_TextPrinter_putChar():
	$voice.pitch_scale = rand_range(0.95,1.05)
	$voice.play()
