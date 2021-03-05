package game

import(
	"fmt"
	"math/rand"
	"./unit"
)

type Battler struct{
	Name string
	Team int
	attr unit.Attribute
	HP unit.BarVal
	MP unit.BarVal
	SP unit.BarVal
	Wt int
	dead bool
}

func NewBattlerFromDB(name string,team int,att unit.Attribute)*Battler{
	return &Battler{
		Name:name,
		Team:team,
		attr:att,
		HP:unit.NewBarVal(att.MHP),
		MP:unit.NewBarVal(att.MMP),
		SP:unit.NewBarVal(att.MSP),
		Wt:20,
		dead:false,
	}
}
func NewBattlerFromChar(char unit.Charactor)*Battler{
	tmp:=Battler{
		Name:char.Name,
		Team:0,
		attr:char.Attr,
		HP:char.HP,
		MP:char.MP,
		SP:char.SP,
		Wt:10,
		dead:false,
	}
	return &tmp
}

func (b *Battler)Attack(t *Battler){
	fmt.Printf("%s attack %s!\n",b.Name,t.Name)
	t.TakeDamage(b.attr.ATK)
}

func (b *Battler)TakeDamage(val int)(dmg int){
	d := val - b.attr.DEF;
	if d<0{d=0}
	b.HP.Add(-d)
	fmt.Printf("%s take %d damage!\n",b.Name,d)
	if b.HP.Val() <=0{b.dead = true;}
	return d
}
func (b *Battler)Print()string{
	tmp := fmt.Sprintf("\u2659 %s\n[\u2661 %3d/%-3d   \u2726 %3d/%-3d   \u263b %3d/%-3d]\n"+
	"\u2694 %-2d  \u2727 %-2d  \u26e8 %-2d  \u262f %-2d  \u26f8 %-2d  \u23f3 %-2d\n",
	b.Name,b.HP.Val(),b.HP.Max(),b.MP.Val(),b.MP.Max(),b.SP.Val(),b.SP.Max(),
	b.attr.ATK,b.attr.MTK,b.attr.DEF,b.attr.MDF,b.attr.SPD,b.Wt)
	return tmp
}

type Battlers []*Battler
func (b Battlers)Len()int{return len(b)}
func (b Battlers)Less(i,j int)bool{return b[i].Wt<b[j].Wt}
func (b Battlers)Swap(i,j int){b[i],b[j]=b[j],b[i]}

func (b *Battlers)Append(a *Battler){
	*b = append(*b,a)
}
func (b Battlers)RndSel() Battlers{
	fmt.Printf("bufferLen:%d\n",len(b))
	v := rand.Intn(len(b))
	tmp := Battlers{}
	tmp.Append(b[v])
	return tmp
}
