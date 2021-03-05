extends Node2D

var ipTable = {}
var nameDictByHash = {}

var pos = Vector2()
var xOffset = 128
var yOffset = 128
var nodeCnt = 0
var colCnt = 4

var netLag = 50.0#ms

export (PackedScene) var BCNode
export (PackedScene) var Msg

func AddNode(node):
	var ip = $BootNode.AddNode(node)
	ipTable[ip] = node
	nameDictByHash[node.Hash()] = node.name
	$BootNode.UpdateP2PNetwork()

func AddNodeByAddr(addr):
	var node = BCNode.instance()
	node.coinbase = "ADR"+ addr
	AddNode(node)
	#Add Node to Graph
	print("AddNodeByAddr")
	node.offset = pos + Vector2(nodeCnt%colCnt*xOffset,nodeCnt/colCnt*yOffset)
	nodeCnt += 1
	$HSplitContainer/GraphEdit.add_child(node)
	
func SendMsgByID(src,dstHash,cmd,msg):
	SendMsg(src,$BootNode.nodeTable[dstHash].ipAddr,cmd,msg)

func SendMsg(src,dst,cmd,msg):
	if ipTable.has(src):
		var msgGraphNode = Msg.instance()
		$HSplitContainer/GraphEdit.add_child(msgGraphNode)
		var t = netLag/100
		msgGraphNode.Anim(ipTable[src].offset,ipTable[dst].offset,t)
		yield(get_tree().create_timer(t),"timeout")
	ipTable[dst].RcvMsg(src,cmd,msg)

func GetNodeByNodeID(id):
	var node = $BootNode.nodeTable[id]
	return node

func _on_MainMenu_add_node(addrStr):
	AddNodeByAddr(addrStr)