package scif

import (
	"fmt"
)

//ScInterfacePseudo faked interface
type ScInterfacePseudo struct {
	index int
}

func NewPseudo()ScInterface{
	return new(ScInterfacePseudo)
}

func (i *ScInterfacePseudo) TestCount() {
	i.index += 2
}

func (i *ScInterfacePseudo) TestPrint() {
	fmt.Printf("Pseudo:%d", i.index)
}
