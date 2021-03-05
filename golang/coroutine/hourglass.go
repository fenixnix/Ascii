package coroutine

var hourglass = []rune{'|','/','-','\\','|','/','-','\\'}

type HourGlass struct{
	cnt int
}

func (h *HourGlass)Run() rune{
	h.cnt = (h.cnt+1)%8
	return hourglass[h.cnt]
}