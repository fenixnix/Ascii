extends Object

class_name Tx

var from
var to
var balance
var signature
func _init(src,dst,val,sig):
	from = src
	to = dst
	balance = val
	signature = sig