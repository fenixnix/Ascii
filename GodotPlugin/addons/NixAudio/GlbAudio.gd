tool
extends Node

var bgm:AudioStreamPlayer
var eax:AudioStreamPlayer
var ui_sfx:AudioStreamPlayer
var voice:AudioStreamPlayer

signal finish()

func _enter_tree():
	_init()

func _init():
	print("Init Global Audio")
	pause_mode = Node.PAUSE_MODE_PROCESS
	bgm = add_audio_player("BGM")
	eax = add_audio_player("EAX")
	ui_sfx = add_audio_player("UI_SFX")
	voice = add_audio_player("Voice")

func SFX(id,rnd = false):
	PlaySFX("res://audio/sfx/%s.ogg"%id,rnd)
	
func BGM(id):
	PlayBGM("res://audio/bgm/%s"%id)

func PlayBGM(path,oneshot = false):
	PlayBGMStream(load(path),oneshot)

func PlayBGMStream(stream,oneshot = false,vol = 0):
	bgm.stream = stream
	bgm.volume_db = vol
	if bgm.stream is AudioStreamOGGVorbis:
		bgm.stream.loop = !oneshot
	bgm.play()

func MuteBGM():
	bgm.stop()

func PlayUISfx(path,vol = 0):
	ui_sfx.volume_db = vol;
	ui_sfx.stream = load(path)
	ui_sfx.stream.loop = false
	ui_sfx.play()

func PlayEAX(path,vol = 0):
	PlayEAXStream(load(path),vol)

func PlayEAXStream(stream,vol = 0):
	eax.volume_db = vol
	eax.stream = stream
	eax.stream.loop = true;
	eax.play()

func MuteEAX():
	eax.stop()

func PlaySFX(path,rnd = false):
	PlaySFXStream(load(path),rnd)

func PlaySFXStream(stream,rnd = false):
	var sfx = add_audio_player("SFX")
	sfx.volume_db = ui_sfx.volume_db;
	if rnd:
		sfx.pitch_scale = rand_range(0.8,1.2)
	sfx.stream = stream
	if sfx.stream is AudioStreamOGGVorbis:
		sfx.stream.loop = false
	sfx.play()
	yield(sfx,"finished")
	sfx.stop()
	emit_signal("finish")
	sfx.queue_free()

func PlaySFX3D(path,node,vol = 0):
	var sfx = add_audio_player("SFX")
	sfx.volume_db = vol
	sfx.stream = load(path)
	sfx.stream.loop = false
	node.add_child(sfx)
	sfx.play()
	yield(sfx,'finished')
	sfx.stop()
	sfx.queue_free()
	
func PlayVoice(stream,vol = 0):
	PlayOneShot(stream,"Voice",vol)
	
func PlayOneShot(stream,bus = "SFX",vol = 0):
	var player = add_audio_player(bus)
	player.volume_db = vol
	player.stream = stream
	player.play()
	yield(player,"finished")
	player.stop()
	player.queue_free()

func add_audio_player(bus):
	var player = AudioStreamPlayer.new()
	player.name = bus
	player.bus = bus
	add_child(player)
	return player

func Print():
	for p in get_children():
		print(p.name)
