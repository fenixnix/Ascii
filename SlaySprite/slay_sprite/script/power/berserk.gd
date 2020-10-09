extends Node

var caster
var para

func run(_caster,_para):
	para = _para
	caster = _caster
	caster.power["berserk"]
	caster.connect("new_turn",self,"on_new_turn")

func on_new_turn():
	caster.ModStatus("vul",para.vul)
	caster.en += 1
