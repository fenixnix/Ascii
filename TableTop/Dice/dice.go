package dice
import(
	"math/rand"
)
const(
	dice = 0x2680
)	
func Roll()rune{
	point := rand.Intn(6)
	return rune(point+dice)
}
