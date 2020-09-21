extends Node

const maxBP = 5
const maxBoostLv = 3

var BP = 0
var boostLv = 0

var boosted = false

func Tick():
	if !boosted:
		Add(1)
	else:
		boosted = false

func Boost():
	if BP>0 && boostLv<maxBoostLv:
		BP -= 1
		boostLv += 1
		return true
	return false

func UnBoost():
	if boostLv>0:
		boostLv -= 1
		BP += 1
		return true
	return false

func Cast():
	var bstLv = boostLv
	if boostLv>0:
		boosted = true
	boostLv = 0
	return bstLv
	
func Add(cnt):
	BP += cnt
	if BP>maxBP:
		BP = maxBP
	if BP<0:
		BP = 0

func Print():
	return "[%s]\nBoost:%d\n"%["*".repeat(BP)+" ".repeat(maxBP-BP),boostLv]
