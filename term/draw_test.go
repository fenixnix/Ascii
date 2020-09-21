package term

import(
	"fmt"
	"testing"
	"time"
	"sync"
	"runtime"
)

var wg sync.WaitGroup

func TestDraw(t *testing.T){
	runtime.GOMAXPROCS(1)
	fmt.Println("TestDraw")
	ClearScreen()
	for i:=1;i<=5;i++{
		for j:=1;j<=5;j++{
			SetPos(i*2,j*2)
			SetFColor(i)
			SetBColor(j)
			PutChar('K')
		}
	}
	ClearColor()
	time.Sleep(1*time.Second)
	ClearScreen()
	fmt.Printf("\r")
	for i:=1;i<=5;i++{
		for j:=1;j<=5;j++{
			MovRight(1)
			PutChar('K')
		}
		fmt.Printf("\r")
		MovDown(1)
	}
	//DrawBox(5,3,20,5)
	DrawFrame("Nix Master:",5,1,20,5)
	DrawMsg("HP:100/100",7,2)
	DrawFrame("lyb",5,6,20,5)
	ClearColor()
	wg.Add(1)
	var wt string
	fmt.Scanln("%s",&wt)
	fmt.Println(wt)
	go func() {
		defer wg.Done()
		i:=0
		for{
			i = i+1
			var cmd string
			fmt.Scanln("%s",&cmd)
			if cmd == "1" {
				break
			}
			fmt.Printf("running:%s+%d\r",cmd,i)
		}
	}()
	wg.Wait()
}