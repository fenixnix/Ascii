package main

import(
	"./game"
	"log"
	"net/http"
	_"net/http/pprof"
)

func main(){
	go func(){
		log.Println(http.ListenAndServe("localhost:6060",nil))
	}()

	gf := game.GameFrame{}
	gf.Init()
	gf.RenderUpdate()
	for gf.Running(){
		 gf.InputUpdate()
		 gf.Update()
		 gf.RenderUpdate()
	}
	gf.Exit()
}