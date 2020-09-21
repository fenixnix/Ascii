package imgProc 
import(
	"image"
)
func Mirror(src image.Image)image.Image{
	dst := image.NewRGBA(image.Rectangle{image.Point{0,0},src.Bounds().Size()})
	for row:=0;row<dst.Rect.Size().Y;row++{
		for col:=0; col<dst.Rect.Size().Y; col++{
			dst.Set(col,row,src.At(dst.Rect.Size().X-1-col,row))
		}
	}
	return dst;
}

func Pixel(src image.Image)image.Image{
	dst := image.NewRGBA(image.Rectangle{image.Point{0,0},src.Bounds().Size().Div(2)})
	for row:=0;row<dst.Rect.Size().Y;row++{
		for col:=0; col<dst.Rect.Size().Y; col++{
			dst.Set(col,row,src.At(col*2,row*2))		
		}
	}
	return dst;
}