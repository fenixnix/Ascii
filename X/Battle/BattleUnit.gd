extends Node

var hp_max = 100
var hp = 1
var acc = 0
var evd = 0
var crt = 0
var spd = 3

var ress = []

var wpns = []
var skls = []
var sklStat = []

func init_skillStat():
	sklStat.clear()
	for s in skls:
		sklStat = {
			"wu":s.wu,
			"cd":0,
			"cd_max":s.cd
		}
