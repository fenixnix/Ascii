package game
import(
	"../tuibox"
)

type StateMap struct{
	game *GameFrame
}

func NewStateMap (g *GameFrame)*StateMap {
	tmp :=StateMap {
		game : g,
	}
	g.menu = tui.NewMenu(g.wm.Path(g.pc.CurrentSite))
	return &tmp
}

func (s *StateMap)Rcv(msg int){
	s.game.GoTo(s.game.menu.Current())
}

func (s *StateMap)Render(){
	s.game.ntui.PrintfBtn(0,0,false,"%s",s.game.pc.CurrentSite)
	s.game.ntui.DrawMenu(1,2,s.game.menu)
}
func (s *StateMap)Enter(){
	s.game.menu = tui.NewMenu(s.game.wm.Path(s.game.pc.CurrentSite))
}
func (s *StateMap)Back(){
	s.game.states.Pop()
}