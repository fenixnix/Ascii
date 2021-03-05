package scif

import (
	"fmt"
)

type ScInterfaceReal struct {
	index int
}

func NewReal()ScInterface{
	return new(ScInterfaceReal)
}

func (i *ScInterfaceReal) TestCount() {
	i.index += 1
}

func (i *ScInterfaceReal) TestPrint() {
	fmt.Println(i.index)
}
