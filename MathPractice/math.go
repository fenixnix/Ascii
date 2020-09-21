package main
import(
	"fmt"
	"math/rand"
	"time"
	"../jdat"
)
var exercises map[string]int
var appearRate map[string]int

func InitMultiply(){
	exercises = make(map[string]int)
	appearRate = make(map[string]int)
	for i:=0;i<10;i++{
		for j:=0;j<10;j++{
			exerc := fmt.Sprintf("%2d * %2d",i,j)
			exercises[exerc] = i*j
			appearRate[exerc] = 10
		}
	}
}

func Right(key string){
	appearRate[key]+=1
}

func Wrong(key string) {
	appearRate[key]-=1
	if appearRate[key]==0{
		delete(appearRate,key)
	}
}

func RndSelKey()string{
	rateSum := 0
	for _,v := range appearRate{
		rateSum += v
	}
	sel:=rand.Intn(rateSum)
	progressSum := 0
	for k,v := range appearRate{
		progressSum += v
		if progressSum>=sel{
			return k;
		}
	}
	return ""
}
func main(){
	rand.Seed(time.Now().UnixNano())
	InitMultiply()
	jdat.Save("./math.json",appearRate)
//	for k,v := range exercises{
//		fmt.Printf("%s = %d\n",k,v)
//	}
	for i:=0;i<50;i++{
		qua := RndSelKey()
		fmt.Printf("Q%d: %s = ?\n-->:",i,qua)
		var ans int
		cnt,_ := fmt.Scanf("%d\n",&ans)
		if cnt >0{
			if ans == exercises[qua]{
				fmt.Printf("Right☻ ✓\n\n")
				Right(qua)
			}else{
				fmt.Printf("Wrong ✗!\n The answer is %d\n",exercises[qua])
				Wrong(qua)
			}
		}
	}
	jdat.Save("./math.json",appearRate)
}