package worldmap
import(
	"fmt"
	"os"
	"../../jdat"
	"encoding/csv"
)
const(
	datFile = "./siteLink.csv"
)
type WorldMap map[string]Site
type Site struct{
	Name string
	Linked []string
}
func (s*Site)AddLink(lnk string){
	for _,v := range s.Linked{
		if v ==lnk{
			return
		}
	}
	s.Linked = append(s.Linked,lnk)
}

func (wm *WorldMap)Path(id string)[]string{
	return (*wm)[id].Linked
}

func (wm *WorldMap)Print(id string)string{
	txt := ""
	for _,v := range wm.Path(id){
		txt = fmt.Sprintf("%s%s\n",txt,v)
	}
	return txt
}
func (wm *WorldMap)AddSite(id string,site Site){
	(*wm)[id] = site
}
func (wm *WorldMap)AppendNewLink(id,link string){
	tmp := (*wm)[id]
	tmp.AddLink(link)
	(*wm)[id]= tmp
}
func (wm *WorldMap)Remap(){
	for k,v := range (*wm){
		for _,l := range v.Linked{
			wm.AppendNewLink(l,k)
		}
	}
}
func (wm *WorldMap)PrintWorld()string{
	str := "World\n"
	return str
}
func (wm *WorldMap)Save(){
	jdat.Save(datFile,&wm)
}
func (wm *WorldMap)Load(){
	jdat.Load(datFile,&wm)
}
func (wm *WorldMap)LoadPath(){
	if file,err := os.Open(datFile); err==nil{
		defer file.Close()
		reader := csv.NewReader(file)
		reader.FieldsPerRecord = -1	
		if records,err:= reader.ReadAll();err==nil{
			for _,record := range records{
				wm.AddSite(record[0],Site{
					Name:record[0],
					Linked:record[1:],
				})
			}
		}else{
			fmt.Printf("%s\n",err)
		}
		for k,v := range (*wm){
			fmt.Printf("%s:%s\n",k,v)
		}
	}else{
		fmt.Printf("%s\n",err)
	}
}