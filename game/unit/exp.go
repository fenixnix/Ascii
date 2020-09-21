package unit

var expTable []int

func init(){
	expTable = []int{10,20,30,40,60,90,120,170,250}
}

type EXP struct{
	exp int
}

func (e EXP) Level() int{
	lv := 0
	tmp := e.exp
	for index := 0; index < len(expTable); index++ {
		tmp -= expTable[lv]
		if tmp < 0{
			break;
		}
		lv++
	}
	return lv
} 

func (e EXP) NeededExp() int{
	lv := e.Level()
	return expTable[lv]
}

func (e EXP) CurrentExp() int{
	lv := e.Level()
	tmp := e.exp
	for index:=0;index<lv;index++{	
		tmp = tmp - expTable[index]
	}
	return tmp
}

func (e *EXP) Gain(val int) int{
	lv := e.Level()
	e.exp += val
	return e.Level()-lv
}