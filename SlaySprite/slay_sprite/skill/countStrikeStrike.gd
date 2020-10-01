extends Node

func run(src,card,dst,para):
	var cnt = 0
	cnt += countStrike(src.deck)
	cnt += countStrike(src.hand)
	cnt += countStrike(src.discard)
	cnt += countStrike(src.exhaust)
	dst.TakeDamage(cnt*para.bonus)

func countStrike(lst):
	var cnt = 0
	for c in lst:
		if c.name.end_with("Strike"):
			cnt+=1
	return cnt
