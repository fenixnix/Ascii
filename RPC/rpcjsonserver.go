package main

import (
    "fmt"
    "log"
    "net"
    "net/rpc"
    "net/rpc/jsonrpc"
    "os"
	"./rpcinterface"
)

func main() {
    rpc.Register(new(rpci.Arith)) // 注册rpc服务

    lis, err := net.Listen("tcp", "127.0.0.1:8096")
    if err != nil {
        log.Fatalln("fatal error: ", err)
    }

    fmt.Fprintf(os.Stdout, "%s", "start connection")

    for {
        conn, err := lis.Accept() // 接收客户端连接请求
        if err != nil {
            continue
        }

        go func(conn net.Conn) { // 并发处理客户端请求
            fmt.Fprintf(os.Stdout, "%s", "new client in coming\n")
            jsonrpc.ServeConn(conn)
        }(conn)
    }
}