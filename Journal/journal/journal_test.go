package journal

import(
	"testing"
	"fmt"
)
type TestDat struct{
	A int
	B string
	C float32
}
var datas []*TestDat
func InitTestDat(){
for index := 0; index < 32; index++ {
		datas = append(datas,&TestDat{
			A:index,
			B:"T",
			C:5,
		})
	}
}
func TestJournal(t *testing.T){
	j := NewJournal("./jourDat")
	defer j.Close()
	j.Save(TestDat{
		A:10,
		B:"hello",
		C:5,
	})
	InitTestDat()	
	rcv :=TestDat{}
	j.Load(&rcv)
	fmt.Printf("rcv:%v\n",rcv)
	for _,v := range datas{
		fmt.Printf("%v\n",*v)
	}
}