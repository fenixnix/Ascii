package tui
import "fmt"
import "strings"

type Wire struct{//line 6types corner 4types
	lt,ct int
	h,v,tl,tr,bl,br rune
}
func NewWire(lt,ct int)*Wire{
	index := []int{0,1,4,5,8,9}
	wire:= &Wire{
		lt:lt,
		ct:ct,
		h:rune(0x2500 + index[lt]),
		tl:rune(0x250c + ct),
	}
	wire.v = wire.h+2
	wire.tr = wire.tl+4
	wire.bl = wire.tr+4
	wire.br = wire.bl+4
	return wire
}

func (w Wire)Line(length int)string{
	return strings.Repeat(string(w.h),length-1)
}

func (w Wire)Header(length int)string{
	return fmt.Sprintf("%c%s%c",w.tl,w.Line(length),w.tr)
}

func (w Wire)Feeter(length int)string{
	return fmt.Sprintf("%c%s%c",w.bl,w.Line(length),w.br)
}

func (w Wire)Body(length int)string{
	return fmt.Sprintf("%c%s%c",w.v,strings.Repeat(" ",length-1),w.v)
}
func (w Wire)Print(width int){
	fmt.Printf("%s\n%s\n%s\n",w.Header(width),w.Body(width),w.Feeter(width))
}