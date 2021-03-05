extends Node

class_name DataBase

var db = {}

func _ready():
	pass # Replace with function body.

func Size():
	return len(db)

func Insert(key,val):
	db[key] = val