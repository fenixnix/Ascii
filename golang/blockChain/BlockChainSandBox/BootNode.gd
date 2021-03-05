extends Node

var nodeTable = {}#key:hash,val:node
var ipTable = {}#key:ip,val:node
var p2pTable = {}#key:hash,val:ip Array

var ipNonce = 1

func AddNode(node):
	node.ipAddr = "IP" + "%03d"%ipNonce
	nodeTable[node.Hash()] = node
	ipTable[node.ipAddr] = node
	ipNonce += 1
	return node.ipAddr
	
func UpdateP2PNetwork():
	AllConnection()
	for node in nodeTable.values():
		get_parent().SendMsg("IP000",node.ipAddr,"p2p",p2pTable[node.Hash()])

func AllConnection():
	p2pTable.clear()
	for node in nodeTable.values():
		var arr = []
		var validators = []
		var hashs = []
		for n in nodeTable.values():
			if !validators.has(n.coinbase):
				validators.append(n.coinbase)
			hashs.append(n.Hash())
			if node.ipAddr!=n.ipAddr:
				arr.append(n.ipAddr)
		p2pTable[node.Hash()] = arr
		#node.validators = validators
		#node.validators = arr
		node.validators = hashs

func _on_Tx_initTx(tx):
	var node = nodeTable.values()[randi()%len(nodeTable)]
	print("Select Node:",node.ipAddr)
	get_parent().SendMsg("IP000",node.ipAddr,"tx",tx)
