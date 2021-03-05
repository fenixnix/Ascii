package unit

import(
	"fmt"
	"strings"
	"../../term"
	tui"../../tuibox"
)

type Charactor struct{
	Name string
	XP EXP
	HP BarVal
	MP BarVal
	SP BarVal
    Attr Attribute
}

func (c *Charactor) PrintLinux(){
	fmt.Printf("\n")
	fmt.Printf("%16s\n",c.Name)
	fmt.Printf("Lvl:%d\n",c.XP.Level()+1)
	term.DrawBarVal(10,"\u272a EXP",c.XP.CurrentExp(),c.XP.NeededExp())
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u2665 HP ",c.HP.Val(),c.HP.max)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u2726 MP ",c.MP.Val(),c.MP.max)
	fmt.Printf("\n")
	term.DrawBarVal(10,"\u263b SP ",c.SP.Val(),c.SP.max)
	fmt.Printf("\n")
	c.Attr.Print()
}

func (c *Charactor) Print()string{
	return fmt.Sprintf("@:%-12s\tLvl:%2d\t\u272a XP%s",
	c.Name,c.XP.Level()+1,tui.BarValStr(8,c.XP.CurrentExp(),c.XP.NeededExp()))
}
func (c *Charactor) BarValStateStr()string{
	return fmt.Sprintf("\u2665 %s \u2726 %s \u263b %s",
	tui.BarValStr(8,c.HP.Val(),c.HP.max),
	tui.BarValStr(8,c.MP.Val(),c.MP.max),
	tui.BarValStr(8,c.SP.Val(),c.SP.max))
}

func (c *Charactor) PrintColor(){
	tui.SetColor(0b01111001)
	fmt.Printf("%-12s\t",c.Name)
	tui.SetColor(0b10000111)
	fmt.Printf("Lvl:%2d\t",c.XP.Level()+1)
	tui.SetColor(9)
	tui.DrawBarVal(8,"\u272a XP",c.XP.CurrentExp(),c.XP.NeededExp())
	fmt.Printf("\n%s\n",strings.Repeat("=",40))
	tui.SetColor(2)
	tui.DrawBarVal(8,"\u2665 HP",c.HP.Val(),c.HP.max)
	fmt.Printf("  ")
	tui.SetColor(1)
	tui.DrawBarVal(8,"\u2726 MP",c.MP.Val(),c.MP.max)
	fmt.Printf("  ")
	tui.SetColor(6)
	tui.DrawBarVal(8,"\u263b SP",c.SP.Val(),c.SP.max)
	fmt.Printf("\n%s\n",strings.Repeat("-",40))
	tui.SetColor(7)
	c.Attr.Print()
	tui.SetColor(7)
}
func NewCharactor() Charactor{
	c := Charactor{
		Name : "Nix",
		Attr : Attribute{
			ATK : 10,
			MTK : 3,
			DEF : 6,
			MDF : 4,
			SPD : 6,
		},
	}
	c.HP.Set(100,0.8)
	c.MP.Set(20,1)
	c.SP.Set(20,0.5)
	return c
}