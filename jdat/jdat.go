package jdat

//jsoniter https://github.com/json-iterator/go

import(
	"io/ioutil"
	"encoding/json"
)

func Load(fileName string,v interface{}){
	dat,err := ioutil.ReadFile(fileName)
	if err!=nil{
		return
	}
	err = json.Unmarshal(dat,v)
	if err !=nil{
		return
	}
}

func Save(fileName string,v interface{}){
	dat,err:=json.Marshal(v)
	if err!=nil{
		return
	}
	ioutil.WriteFile(fileName,dat,0644)
}