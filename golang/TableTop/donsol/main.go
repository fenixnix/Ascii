package main
import(
	"fmt"
	"time"
	"math/rand"
	"./poke"
)
var(
	life int
	shield int
	dice poke.Dice
	room []poke.Card
	run bool
)

func main(){
	rand.Seed(time.Now().UnixNano())
	Init()
	Enter()
	for true{
		Print()
		res:=""
		fmt.Scan(&res)
		switch(res){
			case "c": Continue();
			case "r": Retreat();
			case "1":UseCard(0);
			case "2":UseCard(1);
			case "3":UseCard(2);
			case "4":UseCard(3);
		}
		if life==0{
			break;
		}
		if len(room)<=0{
			Continue()
		}
	}
	fmt.Println("Game Over");	
}

func Init(){
	dice = poke.NewDice()
	room = make([]poke.Card,0);
	life = 21;
	shield = 0;
	run = false;
}

func Print(){
	fmt.Printf("Life:%d/21,Shield:%d,Dungeon Process:%f\n",life,shield,);
	for _,v := range room{
		fmt.Printf("%s ",v.Print());
	}
	fmt.Println("\n");
	fmt.Printf("[1~4]:choice card,[c]:Continue,[r]:Retreat\n")
}

func UseCard(index int){
	if index>=len(room){
		return
	} 
	c := room[index]
	if c.IsShield(){
		shield = c.Val;
	}
	if c.IsHeart(){
		life += c.Val;
	}

	if c.IsEnemy(){
		TakeDamage(c.Val);
	}
	room = append(room[:index],room[index+1:]...)
}

func TakeDamage(val int){
	if val<=shield{
		shield -= val
		return
	}
	life -= val-shield
	if(life<=0){
		life = 0
		fmt.Printf("you dead!!\n");
	}
}

func Cure(val int){
	life+=val
	if life>21{
		life = 21
	}
}

func Continue(){
	if !HasEnemy(){
		ClearRoom()
		Enter();
		shield = 0;
		run = false
	}
}

func Enter(){
	for i:=0;i<4;i++{
		card,ok := dice.Take();
		if ok{
			room = append(room,card)
		}
	}
}

func HasEnemy()bool{
	for _,v := range room{
		if v.IsEnemy(){
			return true;
		}
	}
	return false;
}

func Retreat(){
	if !run{
		ClearRoom()
		run = true;
		Enter();
	}
}

func ClearRoom(){
	for _,v := range room{
		dice.Put(v);
	}
	room = make([]poke.Card,0)
}