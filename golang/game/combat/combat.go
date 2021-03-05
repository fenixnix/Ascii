package combat
import "fmt"
type Combat struct{
	dummyA Battler
	dummyB Battler
}
func NewCombat(battler []Battler)Combat{
	return Combat{
		dummyA:battler[0],
		dummyB:battler[1],
	}
}

func (c *Combat)Finish()bool{
	return c.dummyA.HP<=0 || c.dummyB.HP<=0
}

func (c *Combat)Tick(){
	c.dummyA.PrintState()
	c.dummyB.PrintState()
	fmt.Println()
	c.dummyA.Attack(&c.dummyB)
	c.dummyB.Attack(&c.dummyA)
}