package unit

type BarVal struct{
	max int
	rate float32
}

func NewBarVal(m int) BarVal{
	return BarVal{
		max:m,
		rate:1,
	}
}

func (v *BarVal)Set(max int, rate float32){
	v.max = max
	v.rate = rate
}

func (v *BarVal)Add(val int){
	v.rate += float32(val)/float32(v.max)
}
func (v BarVal)Val() int{
	return int(float32(v.max) * v.rate)
}
func (v BarVal)Max() int{
	return v.max
}