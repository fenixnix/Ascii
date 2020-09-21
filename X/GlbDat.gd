extends Node

var player_teams = [0]
var player_sites = []

var token = 500 setget set_token,get_token

var ai_sites = []

var currentSite

signal token_val_change(val)

func set_token(val):
	token = val
	emit_signal("token_val_change",token)

func get_token():
	return token

static func GetProgressCode(val,length = 20):
	var runeA = "\u25A0"
	var runeB = "\u25A1"
	var a = int(length*val)
	var b = length - a
	return "[code][color=%s]%s[/color][color=%s]%s[/color]"%[
	"#ffff00",
	runeA.repeat(a),
	"#808000",
	runeB.repeat(b)]

static func ProgressBBCode(val,length=20):
	var runeA = "\u25A0"
	var runeB = "\u25A1"
	var a = int(length*val)
	var b = length - a
	return "%s%s"%[runeA.repeat(a),runeB.repeat(b)]
