extends Node

#class_name Story

var data

var curAgendaIndex = 0
var curAgenda
var curActIndex = 0
var curAct
var clue = 0
var doom = 0

signal send_msg(type,content)
signal remap(data)

func Set(dat):
	curAgendaIndex = 0
	curActIndex = 0
	clue = 0
	doom = 0
	data = dat
	curAgenda = data.agenda[curAgendaIndex]
	curAct = data.act[curActIndex]
	printA(curAgenda)
	printA(curAct)
	emit_signal("remap",{
		"locations":data.locations,
		"start_location":data.start_location
	})

func printA(dat):
	emit_signal("send_msg","title",dat.name)
	emit_signal("send_msg","text",dat.desc)

func printB(dat):
	emit_signal("send_msg","title",dat.nameB)
	emit_signal("send_msg","text",dat.descB)

func AddDoom(cnt = 1):
	doom += cnt

func CheckDoom():
	if doom>=curAgenda.get("doom",0):
		PushAgenda()

func PushAgenda():
	doom = 0
	printB(curAgenda)
	curAgendaIndex += 1
	if curAgendaIndex<len(data.agenda):
		curAgenda = data.agenda[curAgendaIndex]
		printA(curAgenda)

func PayClue(cnt = 1):
	clue += cnt
	if clue>=curAct.clues:
		PushAct()

func PushAct():
	clue = 0
	printB(curAct)
	if curAct.has("locations"):
		emit_signal("remap",{
			"locations":curAct.locations,
			"start_location":curAct.start_location
		})
	curActIndex += 1
	if curActIndex<len(data.act):
		curAct = data.act[curActIndex]
		printA(curAct)
