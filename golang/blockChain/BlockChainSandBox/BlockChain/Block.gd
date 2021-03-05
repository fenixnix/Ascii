extends Object

class_name Block

var parentHash = 0
var height = 0
var txs = []
var validators = {}
func blockHash():
	return (str(height)).hash()