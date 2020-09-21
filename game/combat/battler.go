package combat
import(
	"fmt"
	"math/rand"
)

func init(){
	rand.Seed(0)
}
//dice is important
//chance rate is necessary
type Battler struct{
	Name string
	HIT int
	ACC int
	EVD int
	RND int
	DMG int
	DEF int
	MHP int
	HP int
}

func NewBattler(id string,dat MstDat)Battler{
	return Battler{
		id,
		dat.HIT,
		dat.ACC,dat.EVD,dat.RND,dat.DMG,dat.DEF,
		dat.MHP,dat.MHP,
	}
}

func (b *Battler)Print(){
	fmt.Printf("%v\n",b)
}

func (b *Battler)PrintState(){
	fmt.Printf("%s[%d/%d] ",b.Name,b.HP,b.MHP)
}

func (b *Battler)Attack(t *Battler){
	fmt.Printf("%s attack %s. ",b.Name,t.Name)
	hitThresh := 10-b.ACC+t.EVD
	for index := 0; index < b.HIT; index++ {
		b.Hit(t,hitThresh)
	}
}

func (b *Battler)Hit(t *Battler, hitThresh int){
	roll := rand.Intn(20)
	if roll>hitThresh {
		dmg := b.DMG + rand.Intn(b.RND)
		if roll-hitThresh>=7{
			fmt.Printf("%s hit %s crit!!! ",b.Name,t.Name)
			t.TakeDmg(dmg*2)
		}else{
		fmt.Printf("%s hit %s! ",b.Name,t.Name)
		t.TakeDmg(dmg)
		}
	}else{
		fmt.Printf("miss! ")
	}
	fmt.Println()
}

func (b *Battler)TakeDmg(dmg int){
	d := dmg - b.DEF
	if d>0 {
		b.HP -= d
		fmt.Printf("%s take %d damage! ",b.Name,d)
	}else{
		fmt.Printf("%s immue damage... ",b.Name)
	}
	if b.HP<=0{
		fmt.Printf("%s dead! ",b.Name)
	}
}