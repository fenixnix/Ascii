package jdat

import(
	"fmt"
	"testing"
	"math/big"
)

const(
	fileName = "./config.json"
)

func Test(t *testing.T){
	v := config{
		"hello","world",911,big.NewInt(99),[]string{"d","r","m"},Chain{},
	}
	Save(fileName,&v)
	Load(fileName,&v)
	fmt.Printf("%v\n",v)

	// cv := Complex{
	// 	Dats : map[string]config{"ddd":config{"d","e",44,[]string{"l","c","d"},Chain{}}},
	// }
	// cv.Dats["aaa"] = config{"a","b",11,[]string{"d","r","m"},Chain{}}
	// cv.Dats["bbb"] = config{"b","c",22,[]string{"d","r","m"},Chain{}}
	// cv.Dats["ccc"] = config{"c","d",33,[]string{"d","r","m"},Chain{}}
	// Save("./complex.json",&cv)
}