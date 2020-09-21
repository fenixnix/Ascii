package game

import(
	"fmt"
	"./unit"
)

type PlayerData struct{
	PC unit.Charactor 
	CurrentSite string
}
func NewPlayerData()PlayerData{
	pd := PlayerData{
		PC : unit.NewCharactor(),
		CurrentSite : "Village",
	}
	return pd
}
func (pcd *PlayerData)WinBattle(gainedExp int){
	lv := pcd.PC.XP.Gain(gainedExp)
	pcd.PC.Print()
	fmt.Printf("\nVictory\n")
	for i:=0;i<lv;i++{
		fmt.Printf("%s Levelup!",pcd.PC.Name)
	}
}