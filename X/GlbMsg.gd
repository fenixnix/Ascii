extends Node

signal new_msg(msg)

func NewMsg(dat):
	emit_signal("new_msg","[color=#00ffff]%s[/color]:"%GlbTime.PrintDateTime()+dat+"\n")
