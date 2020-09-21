package worldmap

import(
	"testing"
)

func Test(t *testing.T){
	wm:=WorldMap{}
	wm.LoadPath()
	//WorldMapTest()
	//wm:=NewDefaultMap()
	//wm.Remap();
	//wm.Save();
}

func WorldMapTest(){
	wm := WorldMap{}
	wm.Load()
	wm.Remap()
	wm.Save()
}
func NewDefaultMap()WorldMap{
	wm :=WorldMap{}
	wm.AddSite("Village",Site{
		Name:"Village",
		Linked:[]string{"Ruin"},
	})
	wm.AddSite("Ruin",Site{
		Name:"Ruin",
		Linked:[]string{},
	})
	return wm
}