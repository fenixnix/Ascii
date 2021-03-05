package unit

import(
	"../../jdat"
)

func InitMstDat(fileName string)AttrDB{
	dat := AttrDB{}
	jdat.Load(fileName,&dat)
	return dat
}

func MakeDefaultFile(fileName string){
	mstDat := AttrDB{
		"Goblin":Attribute{},
		"Slime":Attribute{},
		"Orc":Attribute{},
	}
	jdat.Save(fileName,&mstDat)
}

type AttrDB map[string]Attribute