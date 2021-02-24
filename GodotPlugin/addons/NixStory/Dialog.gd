tool
extends CanvasLayer

onready var dialog = $Frame/Content
onready var nextMark = $Frame/next

var buff = []

signal finish()

func _ready():
	if $voice.stream is AudioStreamOGGVorbis:
		$voice.stream.loop = false
	Close()

func Close():
	$Frame.hide()
	nextMark.visible = false
	SetSpeaker()

func Push(text):
	buff.append(text)
	if len(buff)==1:
		Print(text)

func Print(text):
	$Frame.show()
	$Frame/Content/TextPrinter.Print(text)
	nextMark.hide()

func SetSpeaker(name = "???",face = null):
	$Frame/portrait.texture = face
	$Frame/Label/speaker.text = name

func Clear():
	$Frame/Content/TextPrinter.Clear()

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
	nextMark.show()

func _on_TextPrinter_putChar():
	$voice.pitch_scale = rand_range(0.95,1.05)
	$voice.play()
