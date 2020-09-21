package main
import(
	"fmt"
	"./journal"
)

type TD struct{
	AA int
	BB string
}

func main(){
	jo := journal.NewJournal("./testDat")
	defer jo.Close()
	jo.Save(TD{
		AA:99,
		BB:"hello",
	})
	tmp:=TD{}
	jo.Load(&tmp)
	fmt.Printf("loaded dat: %v",tmp)	
}