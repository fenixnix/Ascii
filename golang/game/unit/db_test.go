package unit
import(
	"testing"
	"../../jdat"
	"fmt"
)
func Test(t *testing.T){
	//MakeDefaultFile()
	for	k,v := range attrDB{
		t.Logf("%s:%v\n",k,v)
	}
	for k,v := range locDB{
		t.Logf("%s:%v\n",k,v)
	}
	a:=1
	a++
	fmt.Printf("a:%d",a)
	edb := EncounterDB{}
	jdat.Load("./encounterDB.json",&edb)
	jdat.Save("./encounterDB_clone.json",&edb)
}