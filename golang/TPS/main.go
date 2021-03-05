package main

import(
	"fmt"
	"time"
)

const(
	checkInterval = 1
	queueLength = 5
)

var(
	count = 0
	queue []int
)

func main(){
	t := time.NewTicker(checkInterval*time.Second)
	t1 := time.NewTicker(time.Millisecond*150)
	go onTime(t.C)
	go onTick(t1.C)
	fmt.Println("main thread")
	for true{
		time.Sleep(time.Hour)
	}
}

func onTime(c <-chan time.Time){
	for now:= range c{
		fmt.Printf("Time:%s",now.String())
		queue = append(queue,count)
		if len(queue)>queueLength{
			queue = queue[1:]
		}
		count = 0
		fmt.Println(" TPS:",TPS())
	}
}

func onTick(c <- chan time.Time){
	for{
		select{
		case <-c:
			count++
		}
	}
}

func TPS()int{
	sum := 0
	for _,v := range queue{
		sum += v;
	}
	return sum / (queueLength*checkInterval)
}

