package main

import(
	"fmt"
	"math/rand"
)

var(
	NodeCnt = 16
	AccCnt = 50
	InitBalance = 100000
	nodes map[int]int
	accs map[int]int
)


func main(){
	nodes = make(map[int]int)
	accs = make(map[int]int)

	//init
	for i:= 0;i<NodeCnt;i++{
		nodes[i] = InitBalance
		accs[i] = InitBalance
	}
	for i:=NodeCnt; i<NodeCnt + AccCnt;i++{
		accs[i] = 0 
	}
	for true{
	//Start Random Transmit
		for i,v := range accs{
			if(v>1000){
				Transmit(i,rand.Intn(NodeCnt+AccCnt),rand.Intn(NodeCnt),v/10)
			}
		}
		PrintAcc()
	}
}

func Transmit(src,dst,node,balance int){
	//fmt.Printf("Tx:%3d to %3d with %5d in %2d\n",src,dst,balance,node)
	accs[src] -= balance
	accs[dst] += balance*9/10
	accs[node] += balance/10
	//fmt.Printf("SRC:%d DST:%d NODE:%d\n", accs[src], accs[dst],accs[node])
}

func PrintAcc(){
	for i := 0;i<NodeCnt+AccCnt;i++{
		fmt.Printf("ACC:%3d:%6d ",i,accs[i])
		if i%5==4 {fmt.Println("")}
	}
	fmt.Println("")
}