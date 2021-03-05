package unit

import(
	//"fmt"
	"log"
	"math/rand"
	"../../jdat"
)
type MstSet struct{
	Rate float32
	Msts []string
}

type MstSets []MstSet

func (sets MstSets)Roll()(MstSet,bool){
	var sum float32 = 0.0
	for _,v := range sets{
		sum += v.Rate
	}
	rnd := rand.Float32()*sum
	sum = 0
	for _,v := range sets{
		sum += v.Rate
		if rnd<sum{
			return v,true
		}
	}
	return sets[0],false
}

type EncounterSet struct{
	EncounterCost float32
	Sets MstSets 
}
type EncounterDB map[string]EncounterSet

func (db EncounterDB)Cost(zoneID string)float32{
	return db[zoneID].EncounterCost
}
func (db EncounterDB)Encounter(id string)[]string{
	if dat,dok := db[id];dok{
		sets := dat.Sets
		res,ok := sets.Roll()
		if ok{
			return res.Msts
		}
	}
	log.Printf("Not find Monster in %s\n",id)
	return make([]string,0)
}
func InitDomDat(fileName string)EncounterDB{
	locDB := make(EncounterDB)
	jdat.Load(fileName,&locDB)
	log.Printf("EncounterDB load successed!")
	return locDB
}