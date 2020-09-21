package unit

import (
	"fmt"
	"../../term"
	"../../tuibox"
)

const(
	attrMax int = 20
)

type Attribute struct{
	MHP int
	MMP int
	MSP int
	ATK int
	MTK int
	DEF int
	MDF int
	SPD int
}

func (a Attribute)PrintLinux(){
	term.DrawBarVal(10,"\u2694 ",a.ATK,attrMax)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u2727 ",a.MTK,attrMax)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u26e8 ",a.DEF,attrMax)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u262f ",a.MDF,attrMax)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u26f8 ",a.SPD,attrMax)
	fmt.Printf("\n")
}
func (a Attribute)Print(){
	tui.DrawBarVal(10,"\u2694 ",a.ATK,attrMax)
	fmt.Printf("  ")
	tui.DrawBarVal(10,"\u2727 ",a.MTK,attrMax)
	fmt.Printf("\n")
	tui.DrawBarVal(10,"\u26e8 ",a.DEF,attrMax)
	fmt.Printf("  ")
	tui.DrawBarVal(10,"\u262f ",a.MDF,attrMax)
	fmt.Printf("\n")
	tui.DrawBarVal(10,"\u26f8 ",a.SPD,attrMax)
	fmt.Printf("\n")
}