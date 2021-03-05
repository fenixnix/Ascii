package main

import (
	"./sc_interface"
)

func main(){
	//testFunc := new(scif.ScInterfaceReal)
	testFunc1 := scif.NewReal()
	testFunc2 := scif.NewPseudo()
	Function(testFunc1)
	Function(testFunc2)
}

func Function(inter scif.ScInterface){
	inter.TestCount()
	inter.TestPrint()
}