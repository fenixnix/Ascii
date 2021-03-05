package tile
import(
	"log"
	"os"
	"image"
	"image/draw"
	"image/png"
)
var(
	GridWidth = 16
	GridHeight = 16
	XOffset = 1;
	YOffset = 1;
	TileCol = 32
	Tile image.Image
)

func SrcPoint(index int)image.Point{
	x := index%TileCol
	y := index/TileCol
	return image.Point{
		x*(GridWidth+XOffset),
		y*(GridHeight+YOffset),
	}
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

func Draw(dst draw.Image, rect image.Rectangle, index int){
	draw.Draw(dst,rect,Tile,SrcPoint(index),draw.Src)
}


