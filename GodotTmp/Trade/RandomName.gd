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
