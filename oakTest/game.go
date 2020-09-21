package main

import (
	"github.com/oakmound/oak"
)

func main(){
	oak.Add("firstScene",
	func(prevScene string, inData interface{}){},
	func()bool {return true},
	func()(nextScene string, result *scene.Result){return "firstScene",nil})
	oak.Init("firstScene")
} 