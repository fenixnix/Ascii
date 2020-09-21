package tui
import "fmt"
type Menu struct{
	width int
	cIndex int
	menu []string
}
func NewMenu(menu []string)*Menu{
	return &Menu{
		width:16,
		cIndex:0,
		menu:menu,
	}
}

func (m *Menu)Next(){
	m.cIndex++
	if m.cIndex>=len(m.menu){
		m.cIndex = 0
	}
}

func (m *Menu)Prev(){
	m.cIndex--
	if m.cIndex<0{
		m.cIndex = len(m.menu)-1
	}
}

func (m *Menu)Index()int{
	return m.cIndex
}

func (m *Menu)Current()string{
	return m.menu[m.cIndex]
}

func (m *Menu)Enter(){

}

func (m *Menu)Print(){
	for i,v := range m.menu{
		if i == m.cIndex{
			fmt.Printf("=[%2d # %-16s]=\n",i,v)
		}else{
			fmt.Printf(" [%2d # %-16s] \n",i,v)
		}
	}
}