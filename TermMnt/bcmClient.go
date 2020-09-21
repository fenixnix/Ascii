package main

import(
	"fmt"
	"./input"
)

func main(){
	fmt.Printf("Start Monitor\n")
	input.NewInput()
	input.WG.Wait()
	fmt.Println("Quit Monitor")
}