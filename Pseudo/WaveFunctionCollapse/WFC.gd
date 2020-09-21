extends Node

var width = 64
var height = 64
var periodic = false

var elms
var patterns

var startingEntropy

var stack = []
var stackSize:int = 0

func Set(w,h):
	pass
	
func Init():
	pass

func Clear():
	pass

func Observe():
	pass

func Progagate():
	pass

func Run(limit):
	Init()
	Clear()
	for l in limit:
		var res = Observe()
		if res!= null:
			return res
		Progagate()
	return true;

class WaveElement:
	var wave #[t]
	var compatible #[t][d]
	var observed
	var sumsOfOnes
	var sumsOfWeights
	var sumsOfWeightLogWeights
	var entropies

	# t:pattern, d:direction
class Pattern:
	#Pattern
	var T = 16#Pattern Count
	var propagator = []#[d][t][list]
	var weights = []#[t]Pattern Weights
	var weightLogWeight = []#[t]
	
	var sumOfWeights
	var sumOfWeightLogWeights
