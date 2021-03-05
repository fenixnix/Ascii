package game
import(
	"../tuibox"
)

type StateTitle struct{
	game *GameFrame
}

func NewStateTitle(g *GameFrame)*StateTitle{
	tmp := StateTitle{
		game : g,
	}
	tmp.Enter();
	return &tmp
}

func (s *StateTitle)Rcv(msg int){
	switch msg{
		case 0:s.game.NewGame()
			s.game.states.Push(NewStateMain(s.game))
		case 1:
			s.game.states.Push(NewStateMain(s.game))
		case 2:
			s.game.running = false
	}
}

func (s *StateTitle)Render(){
	s.game.ntui.DrawMenu(0,0,s.game.menu)
}

func (s *StateTitle)Enter(){
	s.game.menu = tui.NewMenu([]string{"NEW","LOAD","EXIT"})
}

func (s *StateTitle)Back(){

}