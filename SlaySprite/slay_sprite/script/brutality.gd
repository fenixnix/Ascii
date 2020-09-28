extends Node

var caster:CharaBtl
var para

func run(_caster,_para):
	para = _para
	caster = _caster
	caster.power["brutality"]
	caster.connect("new_turn",self,"on_new_turn")

func on_new_turn():
	caster.CostHp(1)
	caster.Draw()
