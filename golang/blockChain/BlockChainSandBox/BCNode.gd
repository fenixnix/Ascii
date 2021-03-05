extends GraphNode
#PRI%%% privite key
#PUB%%% public key
#ADR%%% address
#SIG%%% signature

var blockBonus = 50

export var coinbase = "ADR000"
export var ipAddr = ""
export var links = {}
export var validators = ["ADR000","ADR001"]
var commit = 0

var bc = BlockChain.new()
var pool = TxPool.new()
var balances = {}

var logMsg = ""

func Hash():
	return hash(coinbase+ipAddr)
	
func RcvMsg(sender,cmd,msg):
	if cmd == "p2p":
		links = msg
		print("Rcv Links:",str(links))
		print("Vlds:",str(validators))

	if cmd == "tx":
		pool.AddTx(msg)
		for l in links:
			Net().SendMsg(ipAddr,l,"txt",msg)
	
	if cmd == "txt":
		pool.AddTx(msg)
	
	if cmd == "query":
		print("%s$:%d"%[msg,balances[msg]])
	
	if cmd == "ppp":
		commit = 0
		pool.VldTx()
		BroadcastVld("pp","")
	
	if cmd == "pp":
		commit += 1
		if commit >= len(validators)/3*2:
			wait = false;
			commit = 0
			var blk = WrapperTx()
			blk.txs.append(Tx.new(null,GetProposalCoinBase(),blockBonus,null))
			ExecuteBlock(blk)
			$Timer.start(3)
			
	Refresh()

func Net():
	return get_tree().root.get_node("World")

func GetBalance(addr):
	if !balances.has(addr):
		return 0
	return balances[addr]

var wait = false
func Mine():
	if ImProposal():
		if !wait:
			commit = 0
			pool.VldTx()
			BroadcastVld("ppp","")

func BroadcastVld(cmd,msg):
	for v in validators:
		if v != Hash():
			Net().SendMsgByID(ipAddr,v,cmd,msg)

func ImProposal():
	var ppsl = GetProposal()
	return ppsl == Hash()

func WrapperTx():
	var block = Block.new()
	block.txs = pool.Pending()
	return block

func Refresh():
	if ImProposal():
		$Data/Type.color = Color.green
	else:
		$Data/Type.color = Color.blue
	title = "#%X"%Hash()
	$Data/Type/CoinBase.text = "%s,%s"%[ipAddr,coinbase]
	$Data/Balance.text = "$:" + str(GetBalance(coinbase))
	$Data/Links.text = "links:%d"%len(links)
	$Data/pool.text = pool.Print()
	$Data/block.text = bc.Print()
	$Data/Valid.text = "Vld:%d/%d#%X"%[commit,len(validators),GetProposal()]

func GetProposal():
	seed(bc.top)
	var index = randi()%len(validators)
	return validators[index]

func GetProposalCoinBase():
	return Net().GetNodeByNodeID(GetProposal()).coinbase

func ExecuteBlock(block):
	for t in block.txs:
		if t.from!=null:
			if !balances.has(t.from):
				balances[t.from] = 0
			balances[t.from] -= t.balance
		if !balances.has(t.to):
			balances[t.to] = 0
		balances[t.to] += t.balance
		
	#AddBlockToDB
	bc.Add(block)
	pool.Clear()
	
class TxPool:
	var maxTxCnt = 50
	var pending = []
	var queue = []
	
	func AddTx(tx):
		var t = Tx.new(tx["from"],tx["to"],tx["value"],tx["from"])
		queue.append(t)
		Sort()
	
	func Sort():
		pending.sort_custom(TxSorter,"sort")
	
	func VldTx():
		queue.sort_custom(TxSorter,"sort")
		for t in queue:
			pending.append(t)
			if len(pending) >= maxTxCnt:
				break;
		Sort()
		for t in range(len(pending)):
			queue.pop_front();
	
	func Pending():
		return pending
	
	func Clear():
		pending.clear()
	
	func Print():
		return "Q:%3d,P:%3d"%[len(queue),len(pending)]
	
	class TxSorter:
		static func sort(a,b):
			return a.balance > b.balance

class BlockChain:
	var top = 0
	var db = DataBase.new()
	
	func Add(block):
		block.parentHash = top
		block.height = db.Size()
		top = block.blockHash()
		db.Insert(top,block)
	
	func Print():
		return "BLK:%d#%X"%[db.Size(),top]
		
func _on_Timer_timeout():
	Mine()

func _on_BCNode_focus_entered():
	selected = true