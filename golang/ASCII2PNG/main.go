package main

import (
	"fmt"
	"image"
	"io/ioutil"
	"strings"

	"./tile"
)

//   ^
//< mov >
//   v
func main() {
	txt := "0XabDeFG12343DdfFAakx"
	fmt.Println(strings.ToUpper(txt))

	size := image.Point{16, 16}
	tile.LoadImage("colored.png")
	mapDat := Load("Town.map")
	lns := strings.Split(mapDat, "\n")
	//fmt.Printf("Lines:%d\n", len(lns))
	height := len(lns)
	width := len(lns[0])
	for _, v := range lns {
		fmt.Printf("%s Width:%d\n", v, len(v))
	}
	dst := image.NewRGBA(image.Rect(0, 0, width*size.X, height*size.Y))
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			rect := image.Rect(x*size.X, y*size.Y,
				(x+1)*size.X, (y+1)*size.Y)
			tile.Draw(dst, rect, TileIndex(rune(lns[y][x])))
		}
	}
	tile.SaveImage("map.png", dst)
}

func TileIndex(c rune) int {
	switch c {
	case '.':
		return 4
	case '+':
		return 5
	case '"':
		return 6
	case '~':
		return 7
	case '#':
		return 8
	case 'X':
		return 9
	}
	return 0
}

func Load(fileName string) string {
	dat, err := ioutil.ReadFile(fileName)
	if err != nil {
		return ""
	}
	return string(dat)
}
