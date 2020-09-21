package main

import(
	"fmt"
)

type A struct{
	ValA int
	ValB int
}

type B struct{
	A
	ValB int
	ValC int
}

func main(){
	fmt.Println("hello")
	val := B{}
	val.ValA = 1
	val.ValB = 2
	val.ValC = 3
}