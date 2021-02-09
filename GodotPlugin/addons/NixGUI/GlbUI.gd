extends CanvasLayer

class_name GlobalUI

var queue = []
var dict = {}

signal fade_finish()
signal select(index)

func _ready():
	layer = 5

func Push(path):
	var ui = Load(path)
	if !IsEmpty():
		remove_child(queue.back())
		#queue.pop_back()
	queue.append(ui)
	return ui
	
func Pop():
	if IsEmpty():
		return null
	queue.pop_back().queue_free()
	if !IsEmpty():
		add_child(queue.back())
		return queue.back()
	return null

func Load(path):
	var ui = load(path).instance()
	add_child(ui)
	return ui

func Clear():
	while !IsEmpty():
		Pop()
	for v in dict.values():
		v.queue_free()
	dict.clear()

func IsEmpty():
	return queue.size()==0

func Add(key,path):
	dict[key] = Load(path)

func Del(key):
	var ui = Get(key)
	if IsExist(key):
		ui.queue_free()
		dict.erase(key)

func IsExist(key):
	return dict.has(key)

func Get(key):
	if IsExist(key):
		return dict[key]
	return null

func Show(key):
	add_child(Get(key))

func Hide(key):
	remove_child(Get(key))

#Extra Function
const path = "res://addons/NixGUI/%s.tscn"
func ExOption(list):
	var ui = Push(path%"OptionDialog")
	ui.Select(list)
	ui.connect("select",self,"on_select")
	return ui

func ExMsg(msg):
	var ui = Load(path%"MessageBox")
	ui.Set(msg)
	return ui

func ExLog(msg):
	var ui = Load(path%"MessageLog")
	ui.Set(msg)

func ExFadeOut():
	$cover/veil.FadeOut()

func ExFadeIn():
	$cover/veil.FadeIn()
	
func ExFadeOutIn():
	$cover/veil.FadeOutIn()

func _on_Tween_tween_all_completed():
	emit_signal("fade_finish")

func on_select(index):
	emit_signal("select",index)
