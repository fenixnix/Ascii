package game

import(
	tb"github.com/nsf/termbox-go"
	"../tuibox"
	"./worldmap"
	"./unit"
	"fmt"
)
type GameFrame struct{
	wm worldmap.WorldMap
	pc PlayerData
	ntui *tui.TUI
	wire *tui.Wire
	menu *tui.Menu
	states StateStack 
	running bool
}

func (g *GameFrame)Init(){
	g.running = true
	g.wm = worldmap.WorldMap{}
	g.wm.LoadPath()
	g.wm.Remap()
	unit.InitDB()
	g.ntui = tui.NewTUI(tb.ColorWhite,tb.ColorBlack,
		tb.ColorGreen,tb.ColorBlack,tb.ColorBlack,tb.ColorWhite)
	g.wire = tui.NewWire(3,1)
	g.states = NewStateStack()
	g.states.Push(NewStateTitle(g))
	err:=tb.Init()
	if err != nil {
		panic(err)
	}
	tb.HideCursor()
	tb.SetInputMode(tb.InputEsc)
}

func (g *GameFrame)NewGame(){
	g.pc = NewPlayerData()
}

func (g *GameFrame)Running()bool{
	return g.running
}

func (g *GameFrame)InputUpdate()bool{
	switch ev := tb.PollEvent(); ev.Type {
		case tb.EventKey:
			return g.KeyFunc(ev.Key)
	}
	return false
}

func (g *GameFrame)Update(){

}

func (g *GameFrame)RenderUpdate(){
	tb.Clear(tb.ColorDefault,tb.ColorDefault)
	g.states.Top().Render()
	tb.Flush()
}

func (g *GameFrame)Exit(){
	tb.Close()
}

func (g *GameFrame)KeyFunc(key tb.Key)bool{
	switch(key){
		case tb.KeyEsc:
			g.states.Top().Back()
		case tb.KeyArrowUp:
			g.menu.Prev()
		case tb.KeyArrowDown:
			g.menu.Next()
		case tb.KeyEnter:
			g.states.Top().Rcv(g.menu.Index())
			g.menu.Enter()
	}
	return false;
}

func (g *GameFrame)GoTo(target string){
	for _,v := range g.wm[g.pc.CurrentSite].Linked{
		if v == target{
			g.pc.CurrentSite = v
			g.encouter()
			return
		}
	}
}

func (g *GameFrame)encouter(){
	pcBtl := []*Battler{NewBattlerFromChar(g.pc.PC)}
	npcBtl := NewBattlerTeam(unit.GetEncntMst(g.pc.CurrentSite))
	if len(npcBtl)<=0{
		fmt.Printf("Not Encounter Monster in %s\n",	g.pc.CurrentSite,)
		return
	}
	g.states.Push(NewStateBattle(g))
	battle := NewBattle(pcBtl,npcBtl)
	battle.wg.Wait()
	if battle.win {
		fmt.Printf("Battle Win!!!\n%s gain %d exp\n",
		g.pc.PC.Name,1)
		g.pc.PC.XP.Gain(1)
	}else{
		fmt.Printf("Battle loss!!!\n")
	}
	g.states.Pop();
	g.states.Switch(NewStateMap(g))
	g.RenderUpdate()
}

func NewBattlerTeam(idOfTeam []string)Battlers{
	tmp:=[]*Battler{}
	for _,v :=range idOfTeam{
		tmp = append(tmp,NewBattlerFromDB(v,1,unit.GetAttr(v)))
	}
	return tmp
}