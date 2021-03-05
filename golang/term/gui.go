package term

import(
	"fmt"
	"strings"
)

func DrawMenu(title string, lst []string){
	SetColor(0,7)
	fmt.Printf("\n%-17s\n",title)
	for index := 0; index < len(lst); index++ {
		SetColor(0,6)
		if index%2 == 0{
			SetColor(7,4)
		}
		tmp := fmt.Sprintf("[%2d]->%-10s|",index,lst[index])
		fmt.Printf(tmp)
		fmt.Printf("\n")
	}
	ClearColor()
}

func DrawBtn(title string){
	SetColor(0,3)
	fmt.Printf("[%-10s]\n",title);
	ClearColor()
}

func DrawBarVal(w int, title string, c int, m int){
	fg := c*10/m
	bg := 10-fg
	SetColor(0,6)
	//SetBColor(6)
	fmt.Printf("%3s:",title)
	SetBColor(0)
	SetFColor(2)
	if fg<=7 {
		SetFColor(3)
	}
	if fg <=3{
		SetFColor(1)
	}
	fmt.Printf("%s%s ",strings.Repeat("\u220e",fg),strings.Repeat(" ",bg))
	ClearColor()
	SetColor(0,3)
	fmt.Printf("[%4d/%-4d]",c,m)
	ClearColor()
}

func DrawTab(){
	fmt.Printf("\t")
}