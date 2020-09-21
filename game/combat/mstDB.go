package combat

import(
	"fmt"
	"strconv"
	"log"
	"os"
	"encoding/csv"
)

type MstDat struct{
	MHP int
	DEF int
	EVD int
	ACC int
	DMG int
	RND int
	HIT int
}

var mstDB map[string]MstDat

func InitMstDB(){
	if file,err:=os.Open("./RLMstDB.csv");err==nil{
		defer file.Close()
		reader := csv.NewReader(file)
		reader.FieldsPerRecord = -1
		if dat,err := reader.ReadAll();err==nil{
			mstDB = make(map[string]MstDat)
			for _,v:=range dat[1:5]{
				mstDB[v[0]] = MstDat{
					atoi(v[1]),
					atoi(v[2]),
					atoi(v[3]),
					atoi(v[4]),
					atoi(v[5]),
					atoi(v[6]),
					atoi(v[7]),
				}
			}
			fmt.Printf("MstDB:\n%v\n",mstDB)
		}else{
			log.Fatal(err.Error())
		}
	}else{
		log.Fatal(err.Error())
	}
}

func GenMst(id string)Battler{
	return NewBattler(id,mstDB[id])
}

func atoi(s string)int{
	if v,err := strconv.Atoi(s);err==nil{
		return v 
	}
	return 0
}