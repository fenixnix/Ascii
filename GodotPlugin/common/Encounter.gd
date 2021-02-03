extends Node

const min_ect_dis = 50
const max_ect_dis = 150

var ect_cnt = 0

signal encounter()

func Reset():
	ect_cnt = rand_range(min_ect_dis,max_ect_dis)

func Walk(distance):
	ect_cnt -= distance
	if ect_cnt <= 0:
		Reset()
		emit_signal("encounter")
		return true
	return false
