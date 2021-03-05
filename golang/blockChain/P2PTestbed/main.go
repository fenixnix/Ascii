package main

import(
	"fmt"
	"net"
)

var(
	gateway = "127.0.0.1:10000"
	//ChainLinks
	root []string
	childs []string
	//Links
	brothers map[string]string
)

func main(){
	fmt.Println("hello P2P!")
	ConnectToGateway(gateway)
}

func ConnectToGateway(gw string){
	conn,err := net.Dial("tcp",gw)
	if err!=nil{

	}
	fmt.Fprintf(conn,"Get / HTTP/1.0\r\n\r\n")
}
