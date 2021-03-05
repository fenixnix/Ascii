package game
import(
	//"../tuibox"
)

type StateChar struct{
	game *GameFrame
}

func NewStateChar (g *GameFrame)*StateChar {
	tmp :=StateChar {
		game : g,
	}
	return &tmp
}
func (s *StateChar)Rcv(msg int){}
func (s *StateChar)Enter(){}
func (s *StateChar)Back(){
	s.game.states.Pop()
}

func (s *StateChar)Render(){
	s.game.pc.PC.PrintColor()
}

