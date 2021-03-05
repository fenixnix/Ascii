package game

import(
	"./unit"
	"testing"
)

func TestBattle(t *testing.T){
	pc := Battlers{NewBattlerFromDB("Slime A",0,unit.GetAttr("Slime")),
	NewBattlerFromDB("Slime B",0,unit.GetAttr("Slime")),}

	npc := Battlers{NewBattlerFromDB("Goblin A",1,unit.GetAttr("Goblin")),
	NewBattlerFromDB("Goblin B",1,unit.GetAttr("Goblin")),}

	battle := NewBattle(pc,npc)
	battle.wg.Wait()
}