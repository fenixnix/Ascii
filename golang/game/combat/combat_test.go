package combat

import (
	"testing"
	"fmt"
	"math/rand"
	"time"
)
func Test(t*testing.T){
	rand.Seed(time.Now().Unix())
	InitMstDB()
	combat:=NewCombat([]Battler{GenMst("wolf"),GenMst("zombie")})
	index :=1
	for{
		fmt.Printf("Round:%d\n",index)
		combat.Tick()
		index++
		if combat.Finish(){
			break
		}
	}
}