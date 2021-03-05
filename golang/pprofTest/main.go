package main
import(
	"fmt"
	"log"
	"net/http"
	_"net/http/pprof"
	//"runtime/pprof"
)
func main(){
	go func(){
		log.Println(http.ListenAndServe("localhost:6060",nil))
	}()
	for{
		fmt.Printf("hello world!\n")
	}
}