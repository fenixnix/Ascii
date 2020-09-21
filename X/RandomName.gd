extends Node

class_name RandomName

var nameList = []

func Food():
	var n = "food[%d]"%len(nameList)
	nameList.append(n)
	return n
	
func Item():
	var n = "item[%d]"%len(nameList)
	nameList.append(n)
	return n

static func numName():
	var length = randi()%6+3
	var tmp = ''
	for i in length:
		tmp += char(randi()%26+65)
	return tmp
