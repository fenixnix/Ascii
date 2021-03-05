package unit

const(
	attrJson string = "./mstDat.json"
	ectJson string = "./encounterDB.json"
)

var(
	attrDB AttrDB
	ectDB EncounterDB
)

func init(){
	InitDB()
}

func InitDB(){
	attrDB = InitMstDat(attrJson)
	ectDB = InitDomDat(ectJson)
}

func GetAttr(id string)Attribute{
	return attrDB[id]
}
func GetEncntCost(locID string)float32{
	return ectDB.Cost(locID)
}
func GetEncntMst(locID string)[]string{
	return ectDB.Encounter(locID)
}