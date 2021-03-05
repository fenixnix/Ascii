package coroutine

import(
	"fmt"
	"sync"
	"time"
	"testing"
	"runtime"
)

var(
	wg sync.WaitGroup
	datChan chan int
	hg1 HourGlass
	hg2 HourGlass
	hg3 HourGlass
)

func TestCoroutine(t *testing.T){
	runtime.GOMAXPROCS(4)
	datChan = make(chan int,100)
	wg.Add(2)
	go Sender()
	go Reciver()
    fmt.Printf("start main\n")
	wg.Wait()
    fmt.Printf("finish\n")
}

func Reciver(){
	for i:=0;i<20;i++ {
		time.Sleep(time.Second*2)
		fmt.Printf("\t\tReciver%c %d\r",hg1.Run(),i)
		select{
		case d:=<- datChan:
			fmt.Printf("\t\t\t\tRcv:%d\r",d)
		default:
		}
	}
	wg.Done();
}

func Sender(){
	for i:=0;i<20;i++ {
		time.Sleep(time.Second*1)
		datChan <- i
		fmt.Printf("Sender%c %d\r",hg2.Run(),i)
	}
	wg.Done();
}