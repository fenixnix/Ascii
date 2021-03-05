package poke
import "math/rand"
import "fmt"
var cardMark = []string{"♡","♤","♧","♢","&"}
type Card struct{
	ctype int//"♡♤♧♢" Heart Spade Club Diamond
	Val int
	Symbel string
}

func (card Card)IsEnemy()bool{
	return card.ctype == 1||card.ctype == 2||card.ctype == 4 
}

func (card Card)IsHeart()bool{
	return card.ctype == 0
}

func (card Card)IsShield()bool{
	return card.ctype == 3
}

func (card Card)Print()string{
	return fmt.Sprintf("[%s:%d]",card.Symbel,card.Val)
}

func NewCard(cardType,num int)Card{
	tmp:= Card{
		ctype:cardType,
		Val:num,
	}
	tmp.Symbel = cardMark[tmp.ctype]+"-";
	switch(tmp.Val){
		case 1:tmp.Symbel+="A"
		case 2:tmp.Symbel+="2"
		case 3:tmp.Symbel+="3"
		case 4:tmp.Symbel+="4"
		case 5:tmp.Symbel+="5"
		case 6:tmp.Symbel+="6"
		case 7:tmp.Symbel+="7"
		case 8:tmp.Symbel+="8"
		case 9:tmp.Symbel+="9"
		case 10:tmp.Symbel+="10"
		case 11:tmp.Symbel+="J"
		case 12:tmp.Symbel+="Q"
		case 13:tmp.Symbel+="K"
	}
	if cardType == 1||cardType == 2{
		switch(tmp.Val){
       		case 1:tmp.Val = 17
			case 12:tmp.Val = 13
			case 13:tmp.Val = 15
		}
	}
	if cardType == 0||cardType == 3{
		switch(tmp.Val){
			case 1:tmp.Val = 11
			case 12:tmp.Val = 11
			case 13:tmp.Val = 11
		}
	}
	return tmp
}

type Dice struct{
	cards []Card
}

func NewDice()Dice{
	tmp := Dice{}
	tmp.cards = make([]Card,0)
	for j:=0;j<4;j++{
		for i:=1;i<14;i++{
			tmp.Put(NewCard(j,i))
		}
	}
	tmp.Put(NewCard(4,21))
	tmp.Put(NewCard(4,21))
	totleDmg :=0
	totleShield :=0
	totleHeart := 0
	for _,v := range tmp.cards{
		if v.IsEnemy(){
			totleDmg += v.Val
		}
		if v.IsHeart(){
			totleHeart += v.Val
		}
		if v.IsShield(){
			totleShield += v.Val
		}
	}
	fmt.Printf("Enemy:%d,Shield:%d,Heart:%d\n",totleDmg,totleShield,totleHeart);
	return tmp
}

func (dice Dice)Len()int{
	return len(dice.cards)
}

func (dice *Dice)Put(card Card){
	dice.cards = append(dice.cards,card);
}

func (dice *Dice)Take()(Card,bool){
	if dice.Len()<=0{
		return NewCard(0,0),false
	}
	index := rand.Intn(dice.Len())
	tmp := dice.cards[index]
	dice.cards = append(dice.cards[:index],dice.cards[index+1:]...)
	//fmt.Printf("[%s,%d],",tmp.Symbel,dice.Len());
	return tmp,true
}