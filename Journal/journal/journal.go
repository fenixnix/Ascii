package journal
import(
	"io"
	"os"
	"fmt"
	"log"
	"errors"
	"encoding/gob"
)
var(
	errNoActiveJournal = errors.New("No Active Journal ✗")
)
type Journal struct{
	path string
	writer io.WriteCloser	
	file *os.File
	enc *gob.Encoder
	dec *gob.Decoder
}
func NewJournal(path string)*Journal{
	fmt.Println("New Journal⇒✓")
	j:=&Journal{
		path:path,
	}
	if file,err:=os.Open(j.path);err!=nil{
		if file,err = os.Create(j.path);err!=nil{
		log.Fatal(err)
		}else{
			j.file = file
		}
		}else{
			j.file = file
		}
		j.enc = gob.NewEncoder(j.file)
		j.dec = gob.NewDecoder(j.file)
	return j
}
func (j*Journal)Close(){
	j.file.Close()
}
func (j*Journal)Save(dat interface{}){
	j.enc.Encode(dat)
	j.file.Sync()
	j.file.Seek(0,0)
}

func (j*Journal)Load(dat interface{}){
	if err:=j.dec.Decode(dat);err!=nil{
		fmt.Printf("err:%s\n",err)
		log.Print(err)
	}
}