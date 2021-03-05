package bcm

import(
	"fmt"
	"net"
	"sync"
	"os"
)

const(
	bufLen = 1024
)

var(
	wg sync.WaitGroup
	buf [bufLen]byte
	mnt Monitor
)

type Monitor interface{
	Process(string)string
}

func SetMonitor(m Monitor){
	mnt = m
}

func checkError(err error){
    if  err != nil {
        fmt.Println("Error: %s", err.Error())
        os.Exit(1)  
    }
}

func Start(){
	fmt.Printf("Start Monitor")
}

func recvUDPMsg(conn *net.UDPConn){
    n, raddr, err := conn.ReadFromUDP(buf[0:])
    if err != nil {
        return  
	}
	if n>=bufLen{
		n = bufLen-1
	}
	cmd := string(buf[0:n])
    //fmt.Println("cmd:", cmd)
	msg := mnt.Process(cmd)
	_, err = conn.WriteToUDP([]byte(msg), raddr)
    checkError(err)
}

func InitBCM(m Monitor){
	SetMonitor(m)
	initBCM()
}

func initBCM(){
	wg.Add(1)
	go func(){
		udp_addr, err := net.ResolveUDPAddr("udp", ":11111")
		checkError(err) 
		conn, err := net.ListenUDP("udp", udp_addr)
		defer conn.Close()
		checkError(err) 
		for{
			recvUDPMsg(conn)
		}
		wg.Done();
	}()
}

func Wait(){
	wg.Wait();
}