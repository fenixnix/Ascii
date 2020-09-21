package dice

import(
	"fmt"
	"testing"
	)

func TestDice(t *testing.T){
	fmt.Printf("Input cout and press \u2328 'Enter' to roll dice \u263a\n")
	for	i:=0;i<6;i++{
		fmt.Printf("%c ",Roll())
	}
	fmt.Printf("\n")
}