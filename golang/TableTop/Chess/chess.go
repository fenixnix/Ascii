package chess
import(
	"fmt"
)
const(
	chessHeader = 0x2654
)
func List(){
	for index := 0; index < 12; index++ {
		fmt.Printf("%c ",chessHeader + index)	
	}
}