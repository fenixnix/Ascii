package input

import(
	"fmt"
	"sync"
	"os"
	"net"
)

const(
	udpAddr = "127.0.0.1:11111"
	bufLen = 1024
)

var(
	WG sync.WaitGroup
)

func NewInput(){
	WG.Add(1)
	go func(){	
		conn, err := net.Dial("udp", udpAddr)
		defer conn.Close()
		if err != nil {
			os.Exit(1)  
		}

		rcvBuffer := make([]byte, bufLen)

		go func(){
			for{
				n,err:=conn.Read(rcvBuffer)
				if n>0 && err==nil{
					if n>=bufLen {
						n = bufLen-1
					}
					fmt.Printf("%s\n",rcvBuffer[:n])
				}
			}
		}()

		for{
			fmt.Printf("-->:")
			var cmd string
			fmt.Scanf("%s\n",&cmd)
			if cmd == "exit"{
				break;
			}
			conn.Write([]byte(cmd))
		}
		WG.Done()
	}()
}