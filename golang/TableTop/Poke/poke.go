package poke
import(
	"fmt"
)
const(
	poke = "♡♤♧♢♥♠♣♦"
)
var(
	pokeMap = []rune(poke)
)
func NewPokeCard(icon rune,symbel string)string{
	return fmt.Sprintf("%c%-2s",icon,symbel)
}
func NewPokeCards()[]string{
	tmp:=make([]string,0)	
	for index := 0; index < 4; index++ {
		for i:=2;i<=10;i++{ 	
			tmp = append(tmp,NewPokeCard(pokeMap[index],fmt.Sprintf("%-2d",i)))
		}			
		tmp = append(tmp,NewPokeCard(pokeMap[index],"J"))
		tmp = append(tmp,NewPokeCard(pokeMap[index],"Q"))
		tmp = append(tmp,NewPokeCard(pokeMap[index],"K"))
		tmp = append(tmp,NewPokeCard(pokeMap[index],"A"))
	}
	return tmp
}
func Print(){
	for i,v:=range poke{
		fmt.Printf("%c:%d ",v,i)
	}
	fmt.Println("")
	for i,v := range NewPokeCards(){
		fmt.Printf("%s ",v)
		if i%13==12{
			fmt.Println("")
		} 
	}
}