package game
import(
	"../tuibox"
)

type StateMain struct{
	game *GameFrame
}

func NewStateMain (g *GameFrame)*StateMain {
	tmp :=StateMain {
		game : g,
	}
	tmp.Enter()
	return &tmp
}

func (s *StateMain)Rcv(msg int){
	switch msg{
		case 0:s.game.states.Push(NewStateChar(s.game))
		case 1:s.game.states.Push(NewStateMap(s.game))
		case 2:s.game.states.Pop()
	}
}

func (s *StateMain)Enter(){
	s.game.menu = tui.NewMenu([]string{"Charactor","MAP","QUIT"})
}

func (s *StateMain)Back(){

}

func (s *StateMain)Render(){
	s.game.ntui.PrintfBtn(0,0,false,s.game.pc.PC.Print())
	s.game.ntui.PrintfBtn(0,1,false,s.game.pc.PC.BarValStateStr())
	s.game.ntui.DrawMenu(4,0,s.game.menu)
}
