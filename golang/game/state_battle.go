package game
import(
	//"../tuibox"
)

type StateBattle struct{
	game *GameFrame
}

func NewStateBattle (g *GameFrame)*StateBattle {
	tmp :=StateBattle {
		game : g,
	}
	return &tmp
}
func (s *StateBattle)Rcv(msg int){}
func (s *StateBattle)Enter(){}
func (s *StateBattle)Back(){
}

func (s *StateBattle)Render(){
	s.game.pc.PC.Print()
}