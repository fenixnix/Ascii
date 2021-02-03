extends CanvasLayer

class_name GlobalUI

var queue = []
var dict = {}
const defaultPath = "res://commonUI/%s.tscn"

func Push(path):
	var ui = Load(path)
	if !IsEmpty():
		queue.back().hide()
	queue.append(ui)
	return ui
	
func Pop():
	queue.pop_back().queue_free()
	if !IsEmpty():
		queue.back().show()
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
	return len(queue)==0

func Add(key,path):
	dict[key] = Load(path)
	Hide(key)

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
	var ui = Get(key)
	if ui!=null:
		ui.show()

func Hide(key):
	var ui = Get(key)
	if ui!=null:
		ui.hide()
