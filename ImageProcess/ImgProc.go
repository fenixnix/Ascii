package main
import(
	"log"
	"os"
	"fmt"
	"path/filepath"
	"io/ioutil"
	"image"
	"image/color"
	"image/png"
	"./imgProc"
	"flag"
	"regexp"
)

var(
	GridWidth = 16
	GridHeight = 16
	XOffset = 1;
	YOffset = 1;
	TileCol = 32
	Tile image.Image
)

func main(){
	srcFileName := flag.String("src","src.png","src filename")
	dstFileName := flag.String("dst","dst.png","dst filename")
	function := flag.String("func","mirror","proc func")
	all := flag.Bool("all",false,"Process All in Folder")
	flag.Parse()

	GenerateGrid(128,64,8,8)

	if *all{
		fmt.Println("Process Folder")
		dir,err:= filepath.Abs(filepath.Dir("./"))
		if err!=nil{
			log.Fatal(err)
		}
		fmt.Println("Dir:",dir)
		rd,err := ioutil.ReadDir(dir)
		reg := regexp.MustCompile(".*\\.png$")
		for _,f := range rd{
			fileName := f.Name();
			if reg.MatchString(fileName){
				dstFile := fileName[:len(fileName)-4]+"_"+*function+".png"
				fmt.Printf("Src:%s : Dst:%s\n",fileName,dstFile)
				switch *function{
					case "mirror":ProcMirror(fileName,dstFile)
					case "pixel":ProcPixel(fileName,dstFile)
				}
			}
		}
		return
	}
	switch *function{
		case "mirror":ProcMirror(*srcFileName,*dstFileName)
		case "pixel":ProcPixel(*srcFileName,*dstFileName)
	}
}

func ProcMirror(srcFile,dstFile string){
	src,_ := LoadImage(srcFile)
	dst := imgProc.Mirror(src)	
	SaveImage(dstFile,dst)
}
func ProcPixel(srcFile,dstFile string){
	src,_ := LoadImage(srcFile)
	dst := imgProc.Pixel(src)	
	SaveImage(dstFile,dst)
}

func GenerateGrid(width,height,gridW,gridH int){
	img := image.NewRGBA(image.Rect(0,0,width*gridW,height*gridH))
	for y:=0; y<height; y++{
		for x:=0; x<width; x++{
			if x%2 == 0{
				img.Set(x*gridW,y*gridW,color.RGBA{uint8(x % 16)*8, uint8(y % 16)*8, 0, 255})
			}
		}
	}
	SaveImage("grid.png",img)
}

func LoadImage(path string,)(img image.Image, err error) {
    file, err := os.Open(path)
    if err != nil {
        return
    }
    defer file.Close()
	img, _, err = image.Decode(file)
	Tile = img;
    return
}

func SaveImage(path string, img image.Image) (err error) {
	 imgfile, err := os.Create(path)
	 defer imgfile.Close()
	 err = png.Encode(imgfile, img)
	 if err != nil {
	     log.Fatal(err)
	 }
	 return
}