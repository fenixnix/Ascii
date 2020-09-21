package main
import(
	"time"
	"fmt"
)
func main(){
	var postTime = time.Now()
	time.Sleep(3)
    delay := time.Unix(int64(postTime.Second()), 0).Sub(time.Now())
	//delay = 4 * time.Second
	fmt.Println("Seal delay:", delay)

	select {
	case <-time.After(delay):
	} 
    fmt.Println("finish");
}
