package main

import (
	"net/http"
    "fmt"
    "log"
	"net/rpc"
	"net/rpc/jsonrpc"
	"./rpcinterface"
)
const(
    httpClient = iota
    jsonClient
)

func main() {
    //Set Client type
    clientType := httpClient
    var conn *rpc.Client
    var err error
    //http
    if clientType == httpClient{
        conn, err = rpc.DialHTTP("tcp", "127.0.0.1:8095")
    }
    //json
    if clientType == jsonClient{
        conn, err = jsonrpc.Dial("tcp", "127.0.0.1:8096")
    }
    if err != nil {
        log.Fatalln("dailing error: ", err)
    }

    req := rpci.ArithRequest{100, 30}
    var res rpci.ArithResponse

    err = conn.Call("Arith.Multiply", req, &res) // 乘法运算
    if err != nil {
        log.Fatalln("arith error: ", err)
    }
    fmt.Printf("%d * %d = %d\n", req.A, req.B, res.Pro)

    err = conn.Call("Arith.Divide", req, &res)
    if err != nil {
        log.Fatalln("arith error: ", err)
    }
    fmt.Printf("%d / %d, quo is %d, rem is %d\n", req.A, req.B, res.Quo, res.Rem)
}