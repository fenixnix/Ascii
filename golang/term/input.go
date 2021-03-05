package term

import(
	"fmt"
	"sync"
)

var(
	InputWG sync.WaitGroup
	Input chan(string)
)

func StartInput(){
	InputWG.Add(1)
	Input = make(chan string)
	go func(){
		for{
			var cmd string
			n,err:=fmt.Scanf("%s",&cmd)
			if n>0 && err==nil{
				Input<-cmd
				if cmd == "exit"{
					break;
				}
			}
		}
		InputWG.Done()
		close(Input)
	}()
}

func WaitInput(){
	InputWG.Wait()
}